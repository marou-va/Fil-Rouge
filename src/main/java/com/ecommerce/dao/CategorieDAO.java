package com.ecommerce.dao;

import com.ecommerce.model.Categorie;
import com.ecommerce.util.HibernateUtil;
import org.hibernate.Session;
import java.util.ArrayList;
import java.util.List;

public class CategorieDAO {
    public List<Categorie> getAllCategories() {
        List<Categorie> categories = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            categories = session.createQuery("FROM Categorie", Categorie.class).list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
}
