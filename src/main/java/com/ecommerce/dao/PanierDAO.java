package com.ecommerce.dao;

import com.ecommerce.model.Panier;
import com.ecommerce.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class PanierDAO {

    // Récupérer le panier depuis MySQL via l'ID utilisateur
    public Panier getPanierByUserId(Long userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Panier p WHERE p.utilisateur.id = :userId";
            Query<Panier> query = session.createQuery(hql, Panier.class);
            query.setParameter("userId", userId);
            Panier panier = query.uniqueResult();
            
            if (panier != null) panier.getItems().size(); // Force le chargement de la liste
            return panier;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Sauvegarder ou Mettre à jour (INSERT ou UPDATE)
    public Panier saveOrUpdate(Panier panier) {
        Transaction tx = null;
        Panier mergedPanier = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            mergedPanier = session.merge(panier); // Synchronise avec la BDD
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
        return mergedPanier; // Retourne la version propre de la BDD
    }
}