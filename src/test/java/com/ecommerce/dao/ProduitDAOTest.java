package com.ecommerce.dao;

import com.ecommerce.model.Categorie;
import com.ecommerce.model.Produit;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.util.List;

public class ProduitDAOTest {

    private static ProduitDAO produitDAO;

    @BeforeAll
    public static void setUp() {
        produitDAO = new ProduitDAO();
        
        // Initialiser quelques données pour les tests
        Categorie cat = new Categorie();
        cat.setNom("Test Category");
        new CategorieDAO().save(cat);
        
        Produit p1 = new Produit();
        p1.setNom("Produit Actif");
        p1.setPrix(new java.math.BigDecimal("10.00"));
        p1.setStock(10);
        p1.setActif(true);
        p1.setCategorie(cat);
        produitDAO.save(p1);
        
        Produit p2 = new Produit();
        p2.setNom("Produit Inactif");
        p2.setPrix(new java.math.BigDecimal("20.00"));
        p2.setStock(5);
        p2.setActif(false);
        p2.setCategorie(cat);
        produitDAO.save(p2);
    }

    @Test
    public void testGetProduits_NotNull() {
        // Exécution
        List<Produit> resultats = produitDAO.getProduits(null, null, null);

        // Vérification : La liste ne doit pas être nulle, même si la BDD est vide
        Assertions.assertNotNull(resultats, "La méthode ne doit jamais retourner null.");
    }

    @Test
    public void testGetProduits_OnlyActif() {
        List<Produit> resultats = produitDAO.getProduits(null, null, null);
        
        for (Produit p : resultats) {
            Assertions.assertTrue(p.isActif(),
                    "Le produit " + p.getNom() + " est inactif mais a été retourné par le DAO !");
            if (p.getNom().equals("Produit Inactif")) {
                Assertions.fail("Le produit inactif ne devrait pas être retourné");
            }
        }
    }

    @Test
    public void testGetProduitsWithFiltersAndPagination() {
        List<Produit> resultats = produitDAO.getProduits(null, null, "newest", 5.0, 15.0, 0, 10);
        Assertions.assertNotNull(resultats);
        boolean found = resultats.stream().anyMatch(p -> p.getNom().equals("Produit Actif"));
        Assertions.assertTrue(found, "Le produit actif dans la plage de prix devrait être retourné");
        
        boolean foundInactive = resultats.stream().anyMatch(p -> p.getNom().equals("Produit Inactif"));
        Assertions.assertFalse(foundInactive, "Le produit inactif ne devrait pas être retourné");
    }

    @Test
    public void testCountTotalProduits() {
        long count = produitDAO.countTotalProduits(null, null, 5.0, 15.0);
        Assertions.assertTrue(count > 0, "Le nombre de produits devrait être supérieur à 0");
    }
}