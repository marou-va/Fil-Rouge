package com.ecommerce.controller;

import com.ecommerce.model.Commande;
import com.ecommerce.model.Statut;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.service.CommandeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/historique")
public class HistoriqueServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CommandeService commandeService;

    @Override
    public void init() {
        commandeService = new CommandeService();
    }

    // ── GET : affichage de l'historique avec filtres ───────────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = utilisateurConnecte(request, response);
        if (user == null) return;

        String statusStr = request.getParameter("status");
        String dateStr   = request.getParameter("date");

        List<Commande> commandes = commandeService.findByUtilisateur(
                user.getId(), statusStr, dateStr);

        request.setAttribute("commandes", commandes);
        request.setAttribute("statuts", Statut.values());
        request.getRequestDispatcher("/WEB-INF/vues/historique.jsp")
                .forward(request, response);
    }

    //annuler la commande 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = utilisateurConnecte(request, response);
        if (user == null) return;

        String idStr = request.getParameter("commandeId");
        if (idStr != null) {
            try {
                Long id = Long.parseLong(idStr);
                commandeService.annulerCommande(id, user.getId());
            } catch (NumberFormatException e) {
                // ID invalide → on ignore et on redirige normalement
            }
        }

        response.sendRedirect("historique");
    }



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