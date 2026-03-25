package com.ecommerce.service;

import com.ecommerce.dao.CommandeDAO;
import com.ecommerce.dao.ProduitDAO;
import com.ecommerce.model.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class CommandeServiceTest {

    @Mock
    private CommandeDAO commandeDAO;

    @Mock
    private ProduitDAO produitDAO;

    @InjectMocks
    private CommandeService commandeService;

    private Utilisateur user;
    private Panier panier;
    private Produit produit;

    @BeforeEach
    public void setUp() {
        user = new Utilisateur();
        user.setId(1L);

        produit = new Produit();
        produit.setId(10L);
        produit.setNom("Test Product");
        produit.setPrix(new BigDecimal("100.00"));
        produit.setStock(10);

        panier = new Panier();
        LignePanier item = new LignePanier(produit, 2);
        panier.getItems().add(item);
    }

    @Test
    public void testCreerCommande() {
        when(produitDAO.getProduitById(10L)).thenReturn(produit);

        Commande result = commandeService.creerCommande(user, panier);

        assertNotNull(result);
        assertEquals(user, result.getUtilisateur());
        assertEquals(1, result.getItems().size());
        assertEquals(Statut.VALIDEE, result.getStatut());
        assertEquals(8, produit.getStock()); // 10 - 2

        verify(commandeDAO).save(any(Commande.class));
        verify(produitDAO).update(produit);
    }

    @Test
    public void testFindByIdPourUtilisateur() {
        Commande commande = new Commande();
        commande.setUtilisateur(user);
        when(commandeDAO.findById(100L)).thenReturn(commande);

        Commande result = commandeService.findByIdPourUtilisateur(100L, 1L);

        assertNotNull(result);
        assertEquals(user, result.getUtilisateur());
    }

    @Test
    public void testFindByIdPourAutreUtilisateur() {
        Commande commande = new Commande();
        Utilisateur otherUser = new Utilisateur();
        otherUser.setId(2L);
        commande.setUtilisateur(otherUser);
        when(commandeDAO.findById(100L)).thenReturn(commande);

        Commande result = commandeService.findByIdPourUtilisateur(100L, 1L);

        assertNull(result);
    }

    @Test
    public void testAnnulerCommande() {
        Commande commande = new Commande();
        commande.setUtilisateur(user);
        commande.setStatut(Statut.VALIDEE);
        when(commandeDAO.findById(100L)).thenReturn(commande);

        commandeService.annulerCommande(100L, 1L);

        verify(commandeDAO).updateStatut(100L, Statut.ANNULEE);
    }
}
