package com.ecommerce.dao;

import com.ecommerce.model.Produit;
import com.ecommerce.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;
import java.util.ArrayList;
import java.util.List;

public class ProduitDAO {
    public List<Produit> getProduits(String search, Long categoryId, String sort) {
        List<Produit> produits = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            StringBuilder hql = new StringBuilder("FROM Produit p WHERE p.actif = true");

            if (search != null && !search.trim().isEmpty()) {
                hql.append(" AND (lower(p.nom) LIKE :search OR lower(p.description) LIKE :search)");
            }
            if (categoryId != null) {
                hql.append(" AND p.categorie.id = :catId");
            }

            if ("price_asc".equals(sort)) {
                hql.append(" ORDER BY p.prix ASC");
            } else if ("price_desc".equals(sort)) {
                hql.append(" ORDER BY p.prix DESC");
            } else {
                hql.append(" ORDER BY p.id DESC");
            }

            Query<Produit> query = session.createQuery(hql.toString(), Produit.class);

            if (search != null && !search.trim().isEmpty()) {
                query.setParameter("search", "%" + search.toLowerCase() + "%");
            }
            if (categoryId != null) {
                query.setParameter("catId", categoryId);
            }

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