package com.ecommerce.controller;

import com.ecommerce.model.Utilisateur;
import com.ecommerce.service.UtilisateurService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profil")
public class ProfilServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UtilisateurService utilisateurService;

    @Override
    public void init() {
        utilisateurService = new UtilisateurService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = utilisateurConnecte(request, response);
        if (user == null) return;

        request.getRequestDispatcher("/WEB-INF/vues/profil.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utilisateur user    = utilisateurConnecte(request, response);
        if (user == null) return;

        String nom   = request.getParameter("nom");
        String email = request.getParameter("email");
        String adresse =request.getParameter("adresse");
        String tel=request.getParameter("telephone");

        try {
            utilisateurService.mettreAJourProfil(user, nom, email,adresse,tel);
            session.setAttribute("utilisateur", user);
            request.setAttribute("success", "Profil mis à jour avec succès");

        } catch (IllegalArgumentException e) {
            request.setAttribute("erreur", e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/vues/profil.jsp").forward(request, response);
    }

    // ── Helper ──────────────────────────────────────────────────────────────────

    /** Récupère l'utilisateur en session ou redirige vers /login. */
    private Utilisateur utilisateurConnecte(HttpServletRequest request,
                                             HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        Utilisateur user    = (session != null)
                              ? (Utilisateur) session.getAttribute("utilisateur")
                              : null;

        if (user == null) {
            response.sendRedirect("login");
        }
        return user;
    }
}