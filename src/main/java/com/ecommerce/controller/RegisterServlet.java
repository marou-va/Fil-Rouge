package com.ecommerce.controller;
import java.io.IOException;

import com.ecommerce.service.UtilisateurService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
  
    private UtilisateurService utilisateurService;
    public void init() {
    	  utilisateurService = new UtilisateurService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/vues/inscription.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        if (!"inscrire".equals(request.getParameter("action"))) {
            return;
        }
 
        String nom        = request.getParameter("nom");
        String email      = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        String confirmer  = request.getParameter("confirmerMDP");
        String telephone  = request.getParameter("telephone");
        String adresse    = request.getParameter("adresse");
 
        try {
            utilisateurService.inscrire(nom, email, motDePasse, confirmer, telephone, adresse);
            response.sendRedirect("login");
 
        } catch (IllegalArgumentException e) {
            request.setAttribute("erreur", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/vues/inscription.jsp").forward(request, response);
        }
    }
}

