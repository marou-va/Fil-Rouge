package com.ecommerce.dao;

import com.ecommerce.model.Produit;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.util.List;

public class ProduitDAOTest {

    private static ProduitDAO produitDAO;

    @BeforeAll
    public static void setUp() {
        // Initialisation du DAO avant de lancer les tests
        produitDAO = new ProduitDAO();
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
        // Exécution
        List<Produit> resultats = produitDAO.getProduits(null, null, null);

        // Vérification : Aucun produit de la liste ne doit avoir l'attribut actif à
        // false
        for (Produit p : resultats) {
            Assertions.assertTrue(p.isActif(),
                    "Le produit " + p.getNom() + " est inactif mais a été retourné par le DAO !");
        }
    }
}