package com.ecommerce.service;

import com.ecommerce.dao.ProduitDAO;
import com.ecommerce.dao.CategorieDAO;
import com.ecommerce.model.Produit;
import com.ecommerce.model.Categorie;

import java.math.BigDecimal;
import java.util.*;

public class ProduitService {

    private ProduitDAO produitDAO;
    private CategorieDAO categorieDAO;

    public ProduitService() {
        this.produitDAO = new ProduitDAO();
        this.categorieDAO = new CategorieDAO();
    }

    public ProduitService(ProduitDAO produitDAO, CategorieDAO categorieDAO) {
        this.produitDAO = produitDAO;
        this.categorieDAO = categorieDAO;
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

    public Produit getProduitById(String idStr) {
        if (idStr == null || idStr.isBlank()) {
            return null;
        }
        try {
            return getProduitById(Long.parseLong(idStr));
        } catch (NumberFormatException e) {
            return null;
        }
    }

    public List<Produit> getProduitsSimilaires(Long categorieId, Long produitId) {
        return produitDAO.getProduitsSimilaires(categorieId, produitId);
    }

    public List<Produit> getProduitsPourAdmin(String search) {
        return produitDAO.getProduits(search, null, null);
    }

    public Produit saveOrUpdateProduit(String idStr, String nom, String description, String prixStr,
            String stockStr, String categorieIdStr, String imageUrl, boolean actif) {

        if (nom == null || nom.isBlank()) {
            throw new IllegalArgumentException("Le nom du produit est obligatoire.");
        }

        BigDecimal prix = parsePrix(prixStr);
        int stock = parseStock(stockStr);
        Long categorieId = parseId(categorieIdStr, "Categorie invalide.");

        Categorie categorie = categorieDAO.getCategorieById(categorieId);
        if (categorie == null) {
            throw new IllegalArgumentException("Categorie introuvable.");
        }

        Produit produit = new Produit();
        if (idStr != null && !idStr.isBlank()) {
            Long id = parseId(idStr, "Identifiant de produit invalide.");
            produit = produitDAO.getProduitById(id);
            if (produit == null) {
                throw new IllegalArgumentException("Produit introuvable.");
            }
        }

        produit.setNom(nom.trim());
        produit.setDescription(description == null ? null : description.trim());
        produit.setPrix(prix);
        produit.setStock(stock);
        produit.setImageUrl(imageUrl == null ? null : imageUrl.trim());
        produit.setActif(actif);
        produit.setCategorie(categorie);

        if (produit.getId() == null) {
            produitDAO.save(produit);
        } else {
            produitDAO.update(produit);
        }
        return produit;
    }

    public void supprimerProduit(String idStr) {
        Long id = parseId(idStr, "Identifiant de produit invalide.");
        produitDAO.delete(id);
    }

    private Long parseId(String idStr, String message) {
        try {
            Long id = Long.parseLong(idStr);
            if (id <= 0) {
                throw new IllegalArgumentException(message);
            }
            return id;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(message);
        }
    }

    private BigDecimal parsePrix(String prixStr) {
        try {
            BigDecimal prix = new BigDecimal(prixStr);
            if (prix.signum() < 0) {
                throw new IllegalArgumentException("Le prix ne peut pas etre negatif.");
            }
            return prix;
        } catch (NumberFormatException | NullPointerException e) {
            throw new IllegalArgumentException("Prix invalide.");
        }
    }

    private int parseStock(String stockStr) {
        try {
            int stock = Integer.parseInt(stockStr);
            if (stock < 0) {
                throw new IllegalArgumentException("Le stock ne peut pas etre negatif.");
            }
            return stock;
        } catch (NumberFormatException | NullPointerException e) {
            throw new IllegalArgumentException("Stock invalide.");
        }
    }
}
