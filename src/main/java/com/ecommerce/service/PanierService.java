package com.ecommerce.service;

import com.ecommerce.dao.PanierDAO;
import com.ecommerce.dao.ProduitDAO;
import com.ecommerce.model.LignePanier;
import com.ecommerce.model.Panier;
import com.ecommerce.model.Produit;
import com.ecommerce.model.Utilisateur;

public class PanierService {
    
    private PanierDAO panierDAO = new PanierDAO();
    private ProduitDAO produitDAO = new ProduitDAO();

    /**
     * 1. Ajouter un produit
     */
    public Panier ajouterAuPanier(Utilisateur user, String idProduitStr) throws Exception {
        if (idProduitStr == null || idProduitStr.trim().isEmpty()) {
            throw new IllegalArgumentException("L'identifiant du produit est manquant.");
        }

        Long idProduit;
        try {
            idProduit = Long.parseLong(idProduitStr);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Identifiant de produit invalide.");
        }

        Produit produit = produitDAO.getProduitById(idProduit);
        if (produit == null) {
            throw new Exception("Ce produit n'existe plus dans notre catalogue.");
        }

        Panier panier = panierDAO.getPanierByUserId(user.getId());
        if (panier == null) {
            panier = new Panier();
            panier.setUtilisateur(user);
        }

        panier.ajouterArticle(produit);
        panierDAO.saveOrUpdate(panier); 
        return panier; // On retourne le panier mis à jour
    }

    /**
     * 2. Modifier la quantité (+ / -)
     */
    public Panier modifierQuantite(Utilisateur user, String idProduitStr, String action) throws Exception {
        if (idProduitStr == null || action == null) {
            throw new IllegalArgumentException("Paramètres de modification manquants.");
        }

        Long idProduit = Long.parseLong(idProduitStr);
        Panier panier = panierDAO.getPanierByUserId(user.getId());

        if (panier != null) {
            for (LignePanier lp : panier.getItems()) {
                if (lp.getProduit().getId().equals(idProduit)) {
                    int newQte = lp.getQuantite();
                    if ("plus".equals(action)) {
                        newQte++;
                    } else if ("minus".equals(action)) {
                        newQte--;
                    } else {
                        throw new IllegalArgumentException("Action non reconnue.");
                    }
                    panier.updateQuantite(idProduit, newQte);
                    break;
                }
            }
            panierDAO.saveOrUpdate(panier);
            return panier;
        }
        return null;
    }

    /**
     * 3. Supprimer un article
     */
    public Panier supprimerArticle(Utilisateur user, String idProduitStr) throws Exception {
        if (idProduitStr == null || idProduitStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Identifiant manquant pour la suppression.");
        }

        Long idProduit = Long.parseLong(idProduitStr);
        Panier panier = panierDAO.getPanierByUserId(user.getId());

        if (panier != null) {
            panier.supprimerArticle(idProduit);
            panierDAO.saveOrUpdate(panier);
            return panier;
        }
        return null;
    }
}