package com.ecommerce.model;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import java.math.BigDecimal;
import static org.junit.jupiter.api.Assertions.*;

public class LigneCommandeTest {

    private Produit produit;
    private Commande commande;

    @BeforeEach
    public void setUp() {
        produit = new Produit();
        produit.setId(1L);
        produit.setNom("Test Product");
        produit.setPrix(new BigDecimal("10.50"));
        
        commande = new Commande();
        commande.setId(100L);
    }

    @Test
    public void testGetTotal() {
        LigneCommande ligne = new LigneCommande(commande, produit, 3, new BigDecimal("10.50"));
        assertEquals(new BigDecimal("31.50"), ligne.getTotal());
    }

    @Test
    public void testGetTotalWithCustomPrice() {
        // En cas de changement de prix, la ligne de commande garde le prix unitaire fixé au moment de l'achat
        LigneCommande ligne = new LigneCommande(commande, produit, 2, new BigDecimal("15.00"));
        assertEquals(new BigDecimal("30.00"), ligne.getTotal());
    }
}
