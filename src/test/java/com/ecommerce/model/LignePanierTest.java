package com.ecommerce.model;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import java.math.BigDecimal;
import static org.junit.jupiter.api.Assertions.*;

public class LignePanierTest {

    private Produit produit;

    @BeforeEach
    public void setUp() {
        produit = new Produit();
        produit.setId(1L);
        produit.setNom("Test Product");
        produit.setPrix(new BigDecimal("10.50"));
    }

    @Test
    public void testGetSousTotal() {
        LignePanier ligne = new LignePanier(produit, 2);
        assertEquals(new BigDecimal("21.00"), ligne.getSousTotal());
    }

    @Test
    public void testGetSousTotalWithZeroQuantity() {
        LignePanier ligne = new LignePanier(produit, 0);
        assertEquals(new BigDecimal("0.00"), ligne.getSousTotal());
    }

    @Test
    public void testSetAndGetPanier() {
        LignePanier ligne = new LignePanier();
        Panier panier = new Panier();
        ligne.setPanier(panier);
        assertEquals(panier, ligne.getPanier());
    }

    @Test
    public void testSetAndGetProduit() {
        LignePanier ligne = new LignePanier();
        ligne.setProduit(produit);
        assertEquals(produit, ligne.getProduit());
    }

    @Test
    public void testSetAndGetQuantite() {
        LignePanier ligne = new LignePanier();
        ligne.setQuantite(5);
        assertEquals(5, ligne.getQuantite());
    }
}
