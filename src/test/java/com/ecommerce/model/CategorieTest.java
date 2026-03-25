package com.ecommerce.model;

import org.junit.jupiter.api.Test;
import java.util.ArrayList;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

public class CategorieTest {

    @Test
    public void testSetAndGetNom() {
        Categorie cat = new Categorie();
        cat.setNom("Informatique");
        assertEquals("Informatique", cat.getNom());
    }

    @Test
    public void testProduits() {
        Categorie cat = new Categorie();
        List<Produit> produits = new ArrayList<>();
        
        Produit p1 = new Produit();
        p1.setNom("Laptop");
        produits.add(p1);
        
        cat.setProduits(produits);
        
        assertEquals(1, cat.getProduits().size());
        assertEquals("Laptop", cat.getProduits().get(0).getNom());
    }
}
