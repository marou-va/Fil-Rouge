package com.ecommerce.service;

import com.ecommerce.dao.ProduitDAO;
import com.ecommerce.dao.CategorieDAO;
import com.ecommerce.model.Produit;
import com.ecommerce.model.Categorie;

import java.util.*;

public class ProduitService {

    private ProduitDAO produitDAO;
    private CategorieDAO categorieDAO;

    public ProduitService() {
        this.produitDAO = new ProduitDAO();
        this.categorieDAO = new CategorieDAO();
    }

    public List<Produit> getProduits(String search, Long categoryId, String sort) {
        return produitDAO.getProduits(search, categoryId, sort);
    }

    public List<Categorie> getCategories() {
        return categorieDAO.getAllCategories();
    }

    public Map<Long, Long> getCategoryCounts(List<Categorie> categories) {
        Map<Long, Long> counts = new HashMap<>();
        for (Categorie cat : categories) {
            counts.put(cat.getId(), produitDAO.countProduitsParCategorie(cat.getId()));
        }
        return counts;
    }

    public long getTotalCount() {
        return produitDAO.countProduitsParCategorie(null);
    }

    public Produit getProduitById(Long id) {
        return produitDAO.getProduitById(id);
    }

    public List<Produit> getProduitsSimilaires(Long categorieId, Long produitId) {
        return produitDAO.getProduitsSimilaires(categorieId, produitId);
    }
}