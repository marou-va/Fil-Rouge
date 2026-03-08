package com.ecommerce.dao;

import com.ecommerce.model.Commande;
import com.ecommerce.model.Statut;
import com.ecommerce.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.util.List;

public class CommandeDAO {

    public void save(Commande commande) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(commande); // CASCADE ALL persist aussi les LigneCommande
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
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
                "WHERE c.id = :id", Commande.class)
                .setParameter("id", id)
                .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // ── Lister toutes les commandes d'un utilisateur ──
    public List<Commande> findByUserId(Long userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                "SELECT DISTINCT c FROM Commande c " +
                "LEFT JOIN FETCH c.items i " +
                "LEFT JOIN FETCH i.produit " +
                "WHERE c.utilisateur.id = :userId " +
                "ORDER BY c.dateCommande DESC", Commande.class)
                .setParameter("userId", userId)
                .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // ── Lister toutes les commandes (admin) ──
    public List<Commande> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                "SELECT DISTINCT c FROM Commande c " +
                "LEFT JOIN FETCH c.items i " +
                "LEFT JOIN FETCH i.produit " +
                "ORDER BY c.dateCommande DESC", Commande.class)
                .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // ── Mettre à jour le statut d'une commande ──
    public void updateStatut(Long commandeId, Statut statut) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Commande commande = session.get(Commande.class, commandeId);
            if (commande != null) {
                commande.setStatut(statut);
                session.merge(commande);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
}