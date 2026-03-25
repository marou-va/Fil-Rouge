package com.ecommerce.model;

import org.junit.jupiter.api.Test;
import java.math.BigDecimal;
import static org.junit.jupiter.api.Assertions.*;

public class ProduitTest {

    @Test
    public void testGettersAndSetters() {
        Produit produit = new Produit();
        produit.setId(1L);
        produit.setNom("Smartphone");
        produit.setDescription("A high-end smartphone");
        produit.setPrix(new BigDecimal("999.99"));
        produit.setStock(50);
        produit.setActif(true);
        produit.setImageUrl("http://example.com/image.jpg");
        
        Categorie categorie = new Categorie();
        categorie.setNom("Electronique");
        produit.setCategorie(categorie);

        assertEquals(1L, produit.getId());
        assertEquals("Smartphone", produit.getNom());
        assertEquals("A high-end smartphone", produit.getDescription());
        assertEquals(new BigDecimal("999.99"), produit.getPrix());
        assertEquals(50, produit.getStock());
        assertTrue(produit.isActif());
        assertEquals("http://example.com/image.jpg", produit.getImageUrl());
        assertEquals("Electronique", produit.getCategorie().getNom());
    }

    @Test
    public void testDefaultStatus() {
        Produit produit = new Produit();
        assertTrue(produit.isActif(), "Un produit devrait être actif par défaut");
    }
}
