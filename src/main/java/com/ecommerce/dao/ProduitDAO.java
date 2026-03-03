package com.ecommerce.dao;

import com.ecommerce.model.Produit;
import com.ecommerce.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;
import java.util.ArrayList;
import java.util.List;

public class ProduitDAO {
    public List<Produit> getProduitsActifs() {
        List<Produit> produits = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Produit p WHERE p.actif = true";
            Query<Produit> query = session.createQuery(hql, Produit.class);
            produits = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return produits;
    }

    public Produit getProduitById(Long id) {
        Produit produit = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            produit = session.get(Produit.class, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return produit;
    }

    public List<Produit> getProduitsSimilaires(Long categorieId, Long produitIdExclu) {
        List<Produit> produits = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Produit p WHERE p.categorie.id = :catId AND p.id != :prodId AND p.actif = true";
            Query<Produit> query = session.createQuery(hql, Produit.class);
            query.setParameter("catId", categorieId);
            query.setParameter("prodId", produitIdExclu);
            query.setMaxResults(4); // Limiter à 4 suggestions
            produits = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return produits;
    }
}