package com.ecommerce.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Tests - Gestion du Panier")
public class PanierTest {

    private Panier panier;
    private Produit produitA;
    private Produit produitB;

    // =========================================================
    // SETUP : créé avant chaque test
    // =========================================================
    @BeforeEach
    void setUp() {
        panier = new Panier();

        produitA = new Produit();
        produitA.setId(1L);
        produitA.setNom("Laptop");
        produitA.setPrix(new BigDecimal("8000.00"));
        produitA.setStock(10);

        produitB = new Produit();
        produitB.setId(2L);
        produitB.setNom("Souris");
        produitB.setPrix(new BigDecimal("150.00"));
        produitB.setStock(5);
    }

    // =========================================================
    // 1. TESTS - AJOUTER UN ARTICLE
    // =========================================================

    @Test
    @DisplayName("Ajout d'un nouveau produit → 1 ligne dans le panier")
    void testAjouterNouveauProduit() throws Exception {
        panier.ajouterArticle(produitA);

        assertEquals(1, panier.getItems().size());
        assertEquals(1, panier.getItems().get(0).getQuantite());
        assertEquals(produitA.getId(), panier.getItems().get(0).getProduit().getId());
    }

    @Test
    @DisplayName("Ajout du même produit deux fois → quantité incrémentée, pas de doublon")
    void testAjouterMemeProduitDeuxFois() throws Exception {
        panier.ajouterArticle(produitA);
        panier.ajouterArticle(produitA);

        assertEquals(1, panier.getItems().size(), "Pas de doublon : une seule ligne attendue");
        assertEquals(2, panier.getItems().get(0).getQuantite());
    }

    @Test
    @DisplayName("Ajout de deux produits différents → 2 lignes dans le panier")
    void testAjouterDeuxProduitsDifferents() throws Exception {
        panier.ajouterArticle(produitA);
        panier.ajouterArticle(produitB);

        assertEquals(2, panier.getItems().size());
    }

    @Test
    @DisplayName("Ajout d'un produit en rupture de stock → Exception levée")
    void testAjouterProduitRuptureDeStock() {
        produitA.setStock(0);

        Exception ex = assertThrows(Exception.class, () -> panier.ajouterArticle(produitA));
        assertTrue(ex.getMessage().contains("stock") || ex.getMessage().contains("Stock"),
                "Le message doit mentionner le stock");
    }

    @Test
    @DisplayName("Ajout au-delà du stock disponible → Exception levée")
    void testAjouterQuantiteDepasseStock() throws Exception {
        produitA.setStock(1); // stock limité à 1
        panier.ajouterArticle(produitA); // quantite = 1, ok

        // 2ème ajout doit échouer (stock = 1, quantite serait 2)
        Exception ex = assertThrows(Exception.class, () -> panier.ajouterArticle(produitA));
        assertTrue(ex.getMessage().contains("Stock") || ex.getMessage().contains("stock"));
    }

    // =========================================================
    // 2. TESTS - MODIFIER LA QUANTITÉ
    // =========================================================

    @Test
    @DisplayName("Modifier la quantité d'un article existant")
    void testUpdateQuantiteValide() throws Exception {
        panier.ajouterArticle(produitA);

        panier.updateQuantite(produitA.getId(), 3);

        assertEquals(3, panier.getItems().get(0).getQuantite());
    }

    @Test
    @DisplayName("Mettre la quantité à 0 → article supprimé du panier")
    void testUpdateQuantiteZeroSupprimeLigne() throws Exception {
        panier.ajouterArticle(produitA);

        panier.updateQuantite(produitA.getId(), 0);

        assertTrue(panier.getItems().isEmpty(), "Le panier doit être vide après quantité = 0");
    }

    @Test
    @DisplayName("Mettre une quantité négative → article supprimé du panier")
    void testUpdateQuantiteNegativeSupprimeLigne() throws Exception {
        panier.ajouterArticle(produitA);

        panier.updateQuantite(produitA.getId(), -1);

        assertTrue(panier.getItems().isEmpty());
    }

    @Test
    @DisplayName("Modifier quantité au-delà du stock → Exception levée")
    void testUpdateQuantiteDepasseStock() throws Exception {
        panier.ajouterArticle(produitA); // stock = 10

        Exception ex = assertThrows(Exception.class,
                () -> panier.updateQuantite(produitA.getId(), 99));
        assertTrue(ex.getMessage().contains("Maximum") || ex.getMessage().contains("stock"));
    }

    @Test
    @DisplayName("Modifier la quantité d'un produit inexistant → aucun changement")
    void testUpdateQuantiteProduitInexistant() throws Exception {
        panier.ajouterArticle(produitA);

        // ID inexistant dans le panier
        assertDoesNotThrow(() -> panier.updateQuantite(999L, 2));
        assertEquals(1, panier.getItems().size(), "Le panier ne doit pas changer");
    }

    // =========================================================
    // 3. TESTS - SUPPRIMER UN ARTICLE
    // =========================================================

    @Test
    @DisplayName("Supprimer un article existant → panier vide")
    void testSupprimerArticleExistant() throws Exception {
        panier.ajouterArticle(produitA);

        panier.supprimerArticle(produitA.getId());

        assertTrue(panier.getItems().isEmpty());
    }

    @Test
    @DisplayName("Supprimer un article parmi plusieurs → les autres restent")
    void testSupprimerUnArticleParmiPlusieurs() throws Exception {
        panier.ajouterArticle(produitA);
        panier.ajouterArticle(produitB);

        panier.supprimerArticle(produitA.getId());

        assertEquals(1, panier.getItems().size());
        assertEquals(produitB.getId(), panier.getItems().get(0).getProduit().getId());
    }

    @Test
    @DisplayName("Supprimer un article inexistant → aucun changement")
    void testSupprimerArticleInexistant() throws Exception {
        panier.ajouterArticle(produitA);

        assertDoesNotThrow(() -> panier.supprimerArticle(999L));
        assertEquals(1, panier.getItems().size());
    }

    // =========================================================
    // 4. TESTS - CALCUL DU TOTAL
    // =========================================================

    @Test
    @DisplayName("Total d'un panier vide = 0")
    void testTotalPanierVide() {
        assertEquals(BigDecimal.ZERO, panier.getTotal());
    }

    @Test
    @DisplayName("Total correct avec un seul article")
    void testTotalAvecUnArticle() throws Exception {
        panier.ajouterArticle(produitA); // 8000 * 1 = 8000

        assertEquals(new BigDecimal("8000.00"), panier.getTotal());
    }

    @Test
    @DisplayName("Total correct avec plusieurs articles et quantités")
    void testTotalAvecPlusieursArticles() throws Exception {
        panier.ajouterArticle(produitA); // 8000 * 1
        panier.ajouterArticle(produitA); // 8000 * 2
        panier.ajouterArticle(produitB); // 150 * 1
        // Total = 16000 + 150 = 16150

        assertEquals(new BigDecimal("16150.00"), panier.getTotal());
    }

    @Test
    @DisplayName("Total recalculé correctement après suppression")
    void testTotalApresSuppression() throws Exception {
        panier.ajouterArticle(produitA); // 8000
        panier.ajouterArticle(produitB); // 150

        panier.supprimerArticle(produitA.getId());

        assertEquals(new BigDecimal("150.00"), panier.getTotal());
    }

    @Test
    @DisplayName("Total recalculé correctement après modification de quantité")
    void testTotalApresModificationQuantite() throws Exception {
        panier.ajouterArticle(produitB); // 150 * 1

        panier.updateQuantite(produitB.getId(), 3); // 150 * 3 = 450

        assertEquals(new BigDecimal("450.00"), panier.getTotal());
    }
}