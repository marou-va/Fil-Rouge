package com.ecommerce.dao;

import com.ecommerce.model.Produit;
import com.ecommerce.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;
import java.util.ArrayList;
import java.util.List;

public class ProduitDAO {
    public List<Produit> getProduits(String search, Long categoryId, String sort, Double minPrice, Double maxPrice, Integer offset, Integer limit) {
        List<Produit> produits = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            StringBuilder hql = new StringBuilder("FROM Produit p WHERE p.actif = true");

            if (search != null && !search.trim().isEmpty()) {
                hql.append(" AND (lower(p.nom) LIKE :search OR lower(p.description) LIKE :search)");
            }
            if (categoryId != null && categoryId > 0) {
                hql.append(" AND p.categorie.id = :catId");
            }
            if (minPrice != null) {
                hql.append(" AND p.prix >= :minPrice");
            }
            if (maxPrice != null) {
                hql.append(" AND p.prix <= :maxPrice");
            }

            if ("price_asc".equals(sort)) {
                hql.append(" ORDER BY p.prix ASC");
            } else if ("price_desc".equals(sort)) {
                hql.append(" ORDER BY p.prix DESC");
            } else if ("newest".equals(sort)) {
                hql.append(" ORDER BY p.id DESC");
            } else {
                hql.append(" ORDER BY p.id DESC");
            }

            Query<Produit> query = session.createQuery(hql.toString(), Produit.class);

            if (search != null && !search.trim().isEmpty()) {
                query.setParameter("search", "%" + search.toLowerCase() + "%");
            }
            if (categoryId != null && categoryId > 0) {
                query.setParameter("catId", categoryId);
            }
            if (minPrice != null) {
                query.setParameter("minPrice", minPrice);
            }
            if (maxPrice != null) {
                query.setParameter("maxPrice", maxPrice);
            }

            if (offset != null) {
                query.setFirstResult(offset);
            }
            if (limit != null) {
                query.setMaxResults(limit);
            }

            produits = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return produits;
    }

    public List<Produit> getProduits(String search, Long categoryId, String sort) {
        return getProduits(search, categoryId, sort, null, null, null, null);
    }

    public long countTotalProduits(String search, Long categoryId, Double minPrice, Double maxPrice) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            StringBuilder hql = new StringBuilder("SELECT count(p) FROM Produit p WHERE p.actif = true");
            
            if (search != null && !search.trim().isEmpty()) {
                hql.append(" AND (lower(p.nom) LIKE :search OR lower(p.description) LIKE :search)");
            }
            if (categoryId != null && categoryId > 0) {
                hql.append(" AND p.categorie.id = :catId");
            }
            if (minPrice != null) {
                hql.append(" AND p.prix >= :minPrice");
            }
            if (maxPrice != null) {
                hql.append(" AND p.prix <= :maxPrice");
            }

            Query<Long> query = session.createQuery(hql.toString(), Long.class);
            
            if (search != null && !search.trim().isEmpty()) {
                query.setParameter("search", "%" + search.toLowerCase() + "%");
            }
            if (categoryId != null && categoryId > 0) {
                query.setParameter("catId", categoryId);
            }
            if (minPrice != null) {
                query.setParameter("minPrice", minPrice);
            }
            if (maxPrice != null) {
                query.setParameter("maxPrice", maxPrice);
            }

            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public long countProduitsParCategorie(Long categoryId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT count(p) FROM Produit p WHERE p.actif = true";
            if (categoryId != null && categoryId > 0) {
                hql += " AND p.categorie.id = :catId";
            }
            Query<Long> query = session.createQuery(hql, Long.class);
            if (categoryId != null && categoryId > 0) {
                query.setParameter("catId", categoryId);
            }
            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
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

    public void save(Produit produit) {
        org.hibernate.Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(produit);
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        }
    }

    public void update(Produit produit) {
        org.hibernate.Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.merge(produit);
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
            Produit produit = session.get(Produit.class, id);
            if (produit != null) {
                session.remove(produit);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        }
    }
}