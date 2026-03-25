package com.ecommerce.service;

import com.ecommerce.dao.PanierDAO;
import com.ecommerce.dao.ProduitDAO;
import com.ecommerce.model.LignePanier;
import com.ecommerce.model.Panier;
import com.ecommerce.model.Produit;
import com.ecommerce.model.Utilisateur;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class PanierServiceTest {

    @Mock
    private PanierDAO panierDAO;

    @Mock
    private ProduitDAO produitDAO;

    @InjectMocks
    private PanierService panierService;

    private Utilisateur user;
    private Produit produit;

    @BeforeEach
    public void setUp() {
        user = new Utilisateur();
        user.setId(1L);

        produit = new Produit();
        produit.setId(10L);
        produit.setNom("Smartphone");
        produit.setPrix(new BigDecimal("500.00"));
        produit.setStock(10);
    }

    @Test
    public void testAjouterAuPanierProduitExistant() throws Exception {
        when(produitDAO.getProduitById(10L)).thenReturn(produit);
        when(panierDAO.getPanierByUserId(1L)).thenReturn(null);

        Panier result = panierService.ajouterAuPanier(user, "10");

        assertNotNull(result);
        assertEquals(1, result.getItems().size());
        verify(panierDAO).saveOrUpdate(any(Panier.class));
    }

    @Test
    public void testAjouterAuPanierProduitInexistant() {
        when(produitDAO.getProduitById(anyLong())).thenReturn(null);

        Exception exception = assertThrows(Exception.class, () -> panierService.ajouterAuPanier(user, "999"));

        assertEquals("Ce produit n'existe plus dans notre catalogue.", exception.getMessage());
    }

    @Test
    public void testAjouterAuPanierIdentifiantInvalide() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class,
                () -> panierService.ajouterAuPanier(user, "abc"));

        assertEquals("Identifiant de produit invalide.", exception.getMessage());
    }

    @Test
    public void testModifierQuantitePlus() throws Exception {
        Panier panier = new Panier();
        panier.setUtilisateur(user);
        panier.ajouterArticle(produit);

        when(panierDAO.getPanierByUserId(1L)).thenReturn(panier);

        Panier result = panierService.modifierQuantite(user, "10", "plus");

        assertEquals(2, result.getItems().get(0).getQuantite());
        verify(panierDAO).saveOrUpdate(panier);
    }

    @Test
    public void testModifierQuantiteActionInvalide() throws Exception {
        Panier panier = new Panier();
        panier.setUtilisateur(user);
        panier.ajouterArticle(produit);
        when(panierDAO.getPanierByUserId(1L)).thenReturn(panier);

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class,
                () -> panierService.modifierQuantite(user, "10", "reset"));

        assertEquals("Action non reconnue.", exception.getMessage());
    }

    @Test
    public void testModifierQuantiteIdentifiantInvalide() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class,
                () -> panierService.modifierQuantite(user, "abc", "plus"));

        assertEquals("Identifiant de produit invalide.", exception.getMessage());
    }

    @Test
    public void testSupprimerArticle() throws Exception {
        Panier panier = new Panier();
        panier.setUtilisateur(user);
        panier.ajouterArticle(produit);

        when(panierDAO.getPanierByUserId(1L)).thenReturn(panier);

        Panier result = panierService.supprimerArticle(user, "10");

        assertTrue(result.getItems().isEmpty());
        verify(panierDAO).saveOrUpdate(panier);
    }

    @Test
    public void testVerifierStockProduitManquant() {
        Panier panier = new Panier();
        panier.getItems().add(new LignePanier(produit, 1));
        when(produitDAO.getProduitById(10L)).thenReturn(null);

        List<String> erreurs = panierService.verifierStock(panier);

        assertEquals(1, erreurs.size());
        assertTrue(erreurs.get(0).contains("n'est plus disponible"));
    }

    @Test
    public void testVerifierStockQuantiteSuperieureAuStock() {
        Panier panier = new Panier();
        panier.getItems().add(new LignePanier(produit, 3));

        Produit produitActuel = new Produit();
        produitActuel.setId(10L);
        produitActuel.setNom("Smartphone");
        produitActuel.setStock(1);

        when(produitDAO.getProduitById(10L)).thenReturn(produitActuel);

        List<String> erreurs = panierService.verifierStock(panier);

        assertEquals(1, erreurs.size());
        assertTrue(erreurs.get(0).contains("mais seulement 1 sont disponibles"));
    }
}
