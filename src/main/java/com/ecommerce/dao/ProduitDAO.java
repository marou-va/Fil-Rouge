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
}