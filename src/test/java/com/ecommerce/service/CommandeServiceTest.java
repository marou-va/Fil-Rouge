package com.ecommerce.service;

import com.ecommerce.dao.CommandeDAO;
import com.ecommerce.dao.ProduitDAO;
import com.ecommerce.model.Commande;
import com.ecommerce.model.LignePanier;
import com.ecommerce.model.Panier;
import com.ecommerce.model.Produit;
import com.ecommerce.model.Statut;
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
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

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
        assertEquals(8, produit.getStock());

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
    public void testFindByIdStringInvalideRetourneNull() {
        assertNull(commandeService.findById("abc"));
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

    @Test
    public void testAnnulerCommandeIgnoreStatutNonValidee() {
        Commande commande = new Commande();
        commande.setUtilisateur(user);
        commande.setStatut(Statut.LIVREE);
        when(commandeDAO.findById(100L)).thenReturn(commande);

        commandeService.annulerCommande(100L, 1L);

        verify(commandeDAO, never()).updateStatut(any(), any());
    }

    @Test
    public void testFindAllAvecFiltresInvalides() {
        when(commandeDAO.findAll(null, null, null)).thenReturn(List.of());

        List<Commande> result = commandeService.findAll("INCONNU", "not-a-date");

        assertNotNull(result);
        verify(commandeDAO).findAll(eq(null), eq(null), eq(null));
    }

    @Test
    public void testUpdateStatutAdminShip() {
        commandeService.updateStatutAdmin("100", "ship", null);

        verify(commandeDAO).updateStatut(100L, Statut.EN_COURS);
    }

    @Test
    public void testUpdateStatutAdminAvecStatutExplicite() {
        commandeService.updateStatutAdmin("100", "update", "LIVREE");

        verify(commandeDAO).updateStatut(100L, Statut.LIVREE);
    }

    @Test
    public void testUpdateStatutAdminAvecIdInvalide() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class,
                () -> commandeService.updateStatutAdmin("abc", "ship", null));

        assertEquals("Identifiant de commande invalide.", exception.getMessage());
    }
}
