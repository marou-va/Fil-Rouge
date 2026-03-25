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

    public Categorie getCategorieById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Categorie.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void save(Categorie categorie) {
        org.hibernate.Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(categorie);
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        }
    }

    public void update(Categorie categorie) {
        org.hibernate.Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.merge(categorie);
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        }
    }

    public void delete(Long id) {
        org.hibernate.Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Categorie categorie = session.get(Categorie.class, id);
            if (categorie != null) {
                session.remove(categorie);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        }
    }
}
