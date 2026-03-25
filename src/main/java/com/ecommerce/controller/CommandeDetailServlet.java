package com.ecommerce.controller;

import com.ecommerce.model.Commande;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.service.CommandeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/commande-detail")
public class CommandeDetailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CommandeService commandeService;

    @Override
    public void init() {
        commandeService = new CommandeService();
    }

    // ── GET : affichage du détail d'une commande ───────────────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = utilisateurConnecte(request, response);
        if (user == null) return;

        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                Long commandeId = Long.parseLong(idParam);
                Commande commande = commandeService.findByIdPourUtilisateur(
                        commandeId, user.getId());

                if (commande != null) {
                    request.setAttribute("commande", commande);
                    request.getRequestDispatcher("/WEB-INF/vues/commande-detail.jsp")
                            .forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // ID invalide → redirige vers historique
            }
        }

        response.sendRedirect("historique");
    }

    // ── Helper ─────────────────────────────────────────────────────────────────

    private Utilisateur utilisateurConnecte(HttpServletRequest request,
                                             HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        Utilisateur user    = (session != null)
                              ? (Utilisateur) session.getAttribute("utilisateur")
                              : null;
        if (user == null) response.sendRedirect("login");
        return user;
    }
}