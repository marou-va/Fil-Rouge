package com.ecommerce.controller;

import com.ecommerce.model.LignePanier;
import com.ecommerce.model.Panier;
import com.ecommerce.model.Produit;
import com.ecommerce.model.Role;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.service.PanierService;
import com.ecommerce.service.UtilisateurService;
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

import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class LoginServletTest {

    @Mock
    private UtilisateurService utilisateurService;
    @Mock
    private PanierService panierService;
    @Mock
    private HttpServletRequest request;
    @Mock
    private HttpServletResponse response;
    @Mock
    private HttpSession oldSession;
    @Mock
    private HttpSession newSession;
    @Mock
    private RequestDispatcher dispatcher;

    private LoginServlet servlet;

    @BeforeEach
    void setUp() {
        servlet = new LoginServlet();
        servlet.setUtilisateurService(utilisateurService);
        servlet.setPanierService(panierService);
    }

    @Test
    void testDoPostRedirectsClientOnSuccess() throws Exception {
        Utilisateur user = new Utilisateur();
        user.setId(1L);
        user.setRole(Role.CLIENT);

        Produit produit = new Produit();
        produit.setId(10L);
        produit.setPrix(new BigDecimal("100.00"));
        Panier panier = new Panier();
        panier.getItems().add(new LignePanier(produit, 1));

        when(request.getSession(true)).thenReturn(oldSession, newSession);
        when(oldSession.getAttribute("loginTentatives")).thenReturn(null);
        when(oldSession.getAttribute("loginBlocageDepuis")).thenReturn(null);
        when(request.getParameter("email")).thenReturn("client@test.com");
        when(request.getParameter("password")).thenReturn("Password123!");
        when(utilisateurService.authentifier("client@test.com", "Password123!")).thenReturn(user);
        when(panierService.getPanierByUserId(1L)).thenReturn(panier);

        servlet.doPost(request, response);

        verify(oldSession).invalidate();
        verify(newSession).setAttribute("utilisateur", user);
        verify(newSession).setAttribute("cartSize", 1);
        verify(response).sendRedirect("catalogue");
    }

    @Test
    void testDoPostBlocksAfterThirdFailure() throws Exception {
        when(request.getSession(true)).thenReturn(oldSession);
        when(oldSession.getAttribute("loginTentatives")).thenReturn(2);
        when(oldSession.getAttribute("loginBlocageDepuis")).thenReturn(null);
        when(request.getParameter("email")).thenReturn("client@test.com");
        when(request.getParameter("password")).thenReturn("bad");
        when(utilisateurService.authentifier("client@test.com", "bad")).thenReturn(null);
        when(request.getRequestDispatcher("/WEB-INF/vues/login.jsp")).thenReturn(dispatcher);

        servlet.doPost(request, response);

        verify(oldSession).setAttribute("loginTentatives", 3);
        verify(oldSession).setAttribute(eq("loginBlocageDepuis"), anyLong());
        verify(request).setAttribute("bloque", true);
        verify(dispatcher).forward(request, response);
    }

    @Test
    void testDoPostKeepsBlockedSessionBeforeTimeout() throws Exception {
        when(request.getSession(true)).thenReturn(oldSession);
        when(oldSession.getAttribute("loginTentatives")).thenReturn(3);
        when(oldSession.getAttribute("loginBlocageDepuis")).thenReturn(System.currentTimeMillis());
        when(request.getRequestDispatcher("/WEB-INF/vues/login.jsp")).thenReturn(dispatcher);

        servlet.doPost(request, response);

        verify(utilisateurService, never()).authentifier(anyString(), anyString());
        verify(request).setAttribute("bloque", true);
        verify(dispatcher).forward(request, response);
    }
}
