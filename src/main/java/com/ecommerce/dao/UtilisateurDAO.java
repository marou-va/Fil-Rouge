package com.ecommerce.dao;

import com.ecommerce.model.Utilisateur;
import com.ecommerce.util.HibernateUtil;
<<<<<<< HEAD

import org.hibernate.HibernateException;
=======
>>>>>>> 65d5a125312f20cf110fbfd30052dfa6f104cad7
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class UtilisateurDAO {
    public Utilisateur findByEmail(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Utilisateur u WHERE u.email = :email";
            Query<Utilisateur> query = session.createQuery(hql, Utilisateur.class);
            query.setParameter("email", email);
            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

<<<<<<< HEAD

    // ── Vérifier si email existe ──
    public boolean emailExiste(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            Long count = session.createQuery(
                "SELECT COUNT(u) FROM Utilisateur u WHERE u.email = :email",
                Long.class)
                .setParameter("email", email)
                .uniqueResult();

            return count > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    //Ajouter un utilisateur
    public void ajouter(Utilisateur user) {
        Transaction tx = null;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            session.save(user);
            tx.commit();
            System.out.println("✅ Utilisateur ajouté : " + user.getEmail()); // ← ajoute ça

        } catch (HibernateException e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            System.out.println("❌ Erreur ajouter : " + e.getMessage()); // ← ajoute ça
            e.printStackTrace();

        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
=======
    public void save(Utilisateur utilisateur) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            session.persist(utilisateur);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
>>>>>>> 65d5a125312f20cf110fbfd30052dfa6f104cad7
        }
    }

    public void update(Utilisateur utilisateur) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.merge(utilisateur);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null)
                transaction.rollback();
            e.printStackTrace();
        }
    }
}
