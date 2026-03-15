package com.ecommerce.dao;

import com.ecommerce.model.Commande;
import com.ecommerce.model.Statut;
import com.ecommerce.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.time.LocalDateTime;
import java.util.List;

public class CommandeDAO {

    private void checkAutoUpdate(Session session) {
        // Met à jour les commandes EN_COURS dont la date de livraison est passée
        List<Commande> enCoursList = session.createQuery(
                "FROM Commande WHERE statut = :statut AND dateLivraison <= :now",
                Commande.class)
                .setParameter("statut", Statut.EN_COURS)
                .setParameter("now", LocalDateTime.now())
                .getResultList();

        for (Commande c : enCoursList) {
            c.setStatut(Statut.LIVREE);
            session.merge(c);
        }
    }

    public void save(Commande commande) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(commande); // CASCADE ALL persist aussi les LigneCommande
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        }
    }

    // ── Trouver une commande par son id ──
    public Commande findById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "SELECT DISTINCT c FROM Commande c " +
                            "LEFT JOIN FETCH c.items i " +
                            "LEFT JOIN FETCH i.produit " +
                            "WHERE c.id = :id",
                    Commande.class)
                    .setParameter("id", id)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // ── Lister toutes les commandes d'un utilisateur avec filtres ──
    public List<Commande> findByUserId(Long userId, Statut status, LocalDateTime dateDebut, LocalDateTime dateFin) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            checkAutoUpdate(session);

            StringBuilder hql = new StringBuilder(
                    "SELECT DISTINCT c FROM Commande c LEFT JOIN FETCH c.items i LEFT JOIN FETCH i.produit WHERE c.utilisateur.id = :userId");
            if (status != null)
                hql.append(" AND c.statut = :status");
            //if (dateDebut != null)
             //   hql.append(" AND c.dateCommande >= :dateDebut");
            //if (dateFin != null)
              //  hql.append(" AND c.dateCommande <= :dateFin");
            hql.append(" ORDER BY c.dateCommande DESC");

            var query = session.createQuery(hql.toString(), Commande.class).setParameter("userId", userId);
            if (status != null)
                query.setParameter("status", status);
            if (dateDebut != null)
                query.setParameter("dateDebut", dateDebut);
            if (dateFin != null)
                query.setParameter("dateFin", dateFin);

            List<Commande> result = query.getResultList();
            tx.commit();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Commande> findByUserId(Long userId) {
        return findByUserId(userId, null, null, null);
    }

    // ── Lister toutes les commandes (admin) avec filtres ──
    public List<Commande> findAll(Statut status, LocalDateTime dateDebut, LocalDateTime dateFin) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            checkAutoUpdate(session);

            StringBuilder hql = new StringBuilder(
                    "SELECT DISTINCT c FROM Commande c LEFT JOIN FETCH c.items i LEFT JOIN FETCH i.produit WHERE 1=1");
            if (status != null)
                hql.append(" AND c.statut = :status");
            if (dateDebut != null)
                hql.append(" AND c.dateCommande >= :dateDebut");
            if (dateFin != null)
                hql.append(" AND c.dateCommande <= :dateFin");
            hql.append(" ORDER BY c.dateCommande DESC");

            var query = session.createQuery(hql.toString(), Commande.class);
            if (status != null)
                query.setParameter("status", status);
            if (dateDebut != null)
                query.setParameter("dateDebut", dateDebut);
            if (dateFin != null)
                query.setParameter("dateFin", dateFin);

            List<Commande> result = query.getResultList();
            tx.commit();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Commande> findAll() {
        return findAll(null, null, null);
    }

    // ── Mettre à jour le statut d'une commande ──
    public void updateStatut(Long commandeId, Statut statut) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Commande commande = session.get(Commande.class, commandeId);
            if (commande != null) {
                commande.setStatut(statut);
                // Si l'admin passe la commande en livraison, on fixe une date de livraison
                if (statut == Statut.EN_COURS && commande.getDateLivraison() == null) {
                    commande.setDateLivraison(LocalDateTime.now().plusDays(7)); // Par défaut demain
                }
                session.merge(commande);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        }
    }
}