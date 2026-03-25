package com.ecommerce.service;

import com.ecommerce.dao.PanierDAO;
import com.ecommerce.dao.ProduitDAO;
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

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.*;

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

        Exception exception = assertThrows(Exception.class, () -> {
            panierService.ajouterAuPanier(user, "999");
        });

        assertEquals("Ce produit n'existe plus dans notre catalogue.", exception.getMessage());
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
    public void testSupprimerArticle() throws Exception {
        Panier panier = new Panier();
        panier.setUtilisateur(user);
        panier.ajouterArticle(produit);
        
        when(panierDAO.getPanierByUserId(1L)).thenReturn(panier);

        Panier result = panierService.supprimerArticle(user, "10");

        assertTrue(result.getItems().isEmpty());
        verify(panierDAO).saveOrUpdate(panier);
    }
}
