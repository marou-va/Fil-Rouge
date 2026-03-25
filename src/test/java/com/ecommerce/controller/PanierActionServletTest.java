package com.ecommerce.controller;

import com.ecommerce.model.Panier;
import com.ecommerce.model.Produit;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.service.PanierService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;

import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class PanierActionServletTest {

    @Mock
    private PanierService panierService;
    @Mock
    private HttpServletRequest request;
    @Mock
    private HttpServletResponse response;
    @Mock
    private HttpSession session;
    @Mock
    private RequestDispatcher dispatcher;

    private PanierActionServlet servlet;

    @BeforeEach
    void setUp() {
        servlet = new PanierActionServlet();
        servlet.setPanierService(panierService);
    }

    @Test
    void testServiceForwardToLoginWhenUserMissing() throws Exception {
        when(request.getSession()).thenReturn(session);
        when(session.getAttribute("utilisateur")).thenReturn(null);
        when(request.getRequestDispatcher("/WEB-INF/vues/login.jsp")).thenReturn(dispatcher);

        servlet.service(request, response);

        verify(request).setAttribute("erreur", "Veuillez vous connecter pour gérer votre panier.");
        verify(dispatcher).forward(request, response);
    }

    @Test
    void testServiceRedirectsToRefererAfterAdd() throws Exception {
        Utilisateur user = new Utilisateur();
        user.setId(1L);
        Panier panier = new Panier();
        Produit produit = new Produit();
        produit.setId(10L);
        produit.setPrix(new BigDecimal("100.00"));
        produit.setStock(10);
        panier.ajouterArticle(produit);

        when(request.getSession()).thenReturn(session);
        when(session.getAttribute("utilisateur")).thenReturn(user);
        when(request.getParameter("action")).thenReturn("ajouter");
        when(request.getParameter("idProduit")).thenReturn("10");
        when(request.getHeader("Referer")).thenReturn("/catalogue");
        when(panierService.ajouterAuPanier(user, "10")).thenReturn(panier);

        servlet.service(request, response);

        verify(session).setAttribute("cartSize", 1);
        verify(session).removeAttribute("panier");
        verify(response).sendRedirect("/catalogue");
    }

    @Test
    void testServiceStoresErrorInSession() throws Exception {
        Utilisateur user = new Utilisateur();
        when(request.getSession()).thenReturn(session);
        when(session.getAttribute("utilisateur")).thenReturn(user);
        when(request.getParameter("action")).thenReturn("plus");
        when(request.getParameter("idProduit")).thenReturn("10");
        doThrow(new IllegalArgumentException("Erreur panier")).when(panierService)
                .modifierQuantite(user, "10", "plus");

        servlet.service(request, response);

        verify(session).setAttribute("panierErreur", "Erreur panier");
        verify(response).sendRedirect("panier");
    }
}
