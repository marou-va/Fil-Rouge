package com.ecommerce.controller;

import com.ecommerce.model.LignePanier;
import com.ecommerce.model.Panier;
import com.ecommerce.model.Produit;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.service.CommandeService;
import com.ecommerce.service.PanierService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.List;

import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class ValiderCommandeServletTest {

    @Mock
    private PanierService panierService;
    @Mock
    private CommandeService commandeService;
    @Mock
    private HttpServletRequest request;
    @Mock
    private HttpServletResponse response;
    @Mock
    private HttpSession session;

    private ValiderCommandeServlet servlet;

    @BeforeEach
    void setUp() {
        servlet = new ValiderCommandeServlet();
        servlet.setPanierService(panierService);
        servlet.setCommandeService(commandeService);
    }

    @Test
    void testDoGetRedirectsWhenPanierIsEmpty() throws Exception {
        Utilisateur user = new Utilisateur();
        user.setId(1L);

        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("utilisateur")).thenReturn(user);
        when(panierService.getPanierByUserId(1L)).thenReturn(new Panier());

        servlet.doGet(request, response);

        verify(response).sendRedirect("panier");
    }

    @Test
    void testDoGetRedirectsWhenStockHasErrors() throws Exception {
        Utilisateur user = new Utilisateur();
        user.setId(1L);
        Panier panier = new Panier();
        Produit produit = new Produit();
        produit.setId(10L);
        produit.setPrix(new BigDecimal("100.00"));
        panier.getItems().add(new LignePanier(produit, 1));

        when(request.getSession(false)).thenReturn(session);
        when(request.getSession()).thenReturn(session);
        when(session.getAttribute("utilisateur")).thenReturn(user);
        when(panierService.getPanierByUserId(1L)).thenReturn(panier);
        when(panierService.verifierStock(panier)).thenReturn(List.of("Stock insuffisant"));

        servlet.doGet(request, response);

        verify(session).setAttribute("panierErreur", "Stock insuffisant");
        verify(response).sendRedirect("panier");
    }

    @Test
    void testDoPostCreatesCommandeAndVidesPanier() throws Exception {
        Utilisateur user = new Utilisateur();
        user.setId(1L);
        Panier panier = new Panier();
        Produit produit = new Produit();
        produit.setId(10L);
        produit.setPrix(new BigDecimal("100.00"));
        produit.setStock(10);
        panier.ajouterArticle(produit);

        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("utilisateur")).thenReturn(user);
        when(panierService.getPanierByUserId(1L)).thenReturn(panier);
        when(panierService.verifierStock(panier)).thenReturn(List.of());

        servlet.doPost(request, response);

        verify(commandeService).creerCommande(user, panier);
        verify(panierService).viderPanier(panier);
        verify(session).removeAttribute("cartSize");
        verify(response).sendRedirect("panier");
    }
}
