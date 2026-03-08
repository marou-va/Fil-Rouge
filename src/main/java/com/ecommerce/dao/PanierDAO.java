package com.ecommerce.dao;

import com.ecommerce.model.Panier;
import com.ecommerce.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
public class PanierDAO {

	public Panier getPanierByUserId(Long userId) {
	    try (Session session = HibernateUtil.getSessionFactory().openSession()) {
	        String hql = "SELECT DISTINCT p FROM Panier p " +
	                     "LEFT JOIN FETCH p.items i " +
	                     "LEFT JOIN FETCH i.produit " +
	                     "WHERE p.utilisateur.id = :userId";
	        return session.createQuery(hql, Panier.class)
	                      .setParameter("userId", userId)
	                      .uniqueResult();
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}

    public void saveOrUpdate(Panier panier) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.merge(panier);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    public Panier getPanierById(Long panierId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT DISTINCT p FROM Panier p " +
                         "LEFT JOIN FETCH p.items i " +
                         "LEFT JOIN FETCH i.produit prod " +
                         "LEFT JOIN FETCH prod.categorie " +
                         "WHERE p.id = :panierId";
            return session.createQuery(hql, Panier.class)
                          .setParameter("panierId", panierId)
                          .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
   //compter les articles sans charger d'objets complexes
    public int getCartSize(Long userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            // Compte directement le nombre de lignes dans la base de données
            String hql = "SELECT COUNT(l) FROM LignePanier l WHERE l.panier.utilisateur.id = :userId";
            Long count = session.createQuery(hql, Long.class)
                                .setParameter("userId", userId)
                                .uniqueResult();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    public void viderPanier(Panier panier) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();

            // Vider la liste des items (orphanRemoval = true supprime les lignes en BDD)
            Panier panierManage = session.get(Panier.class, panier.getId());
            if (panierManage != null) {
                panierManage.getItems().clear();
                session.merge(panierManage);
            }

            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
}