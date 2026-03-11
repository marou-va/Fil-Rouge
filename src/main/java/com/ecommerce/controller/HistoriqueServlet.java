package com.ecommerce.controller;

import com.ecommerce.dao.CommandeDAO;
import com.ecommerce.model.Commande;
import com.ecommerce.model.Statut;
import com.ecommerce.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@WebServlet("/historique")
public class HistoriqueServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CommandeDAO commandeDAO;

    @Override
    public void init() {
        commandeDAO = new CommandeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // Récupération des filtres
        String statusStr = request.getParameter("status");
        String dateStr = request.getParameter("date");

        Statut status = null;
        if (statusStr != null && !statusStr.isEmpty()) {
            try {
                status = Statut.valueOf(statusStr);
            } catch (Exception e) {
            }
        }

        LocalDateTime dateDebut = null;
        LocalDateTime dateFin = null;
        if (dateStr != null && !dateStr.isEmpty()) {
            try {
                LocalDate date = LocalDate.parse(dateStr);
                dateDebut = date.atStartOfDay();
                dateFin = date.atTime(LocalTime.MAX);
            } catch (Exception e) {
            }
        }

        List<Commande> commandes = commandeDAO.findByUserId(user.getId(), status, dateDebut, dateFin);
        request.setAttribute("commandes", commandes);
        request.setAttribute("statuts", Statut.values());

        request.getRequestDispatcher("/WEB-INF/vues/historique.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String idStr = request.getParameter("commandeId");
        if (idStr != null) {
            Long id = Long.parseLong(idStr);
            Commande commande = commandeDAO.findById(id);

            // Un utilisateur ne peut annuler que ses propres commandes EN ATTENTE de
            // validation (Statut VALIDEE)
            if (commande != null && commande.getUtilisateur().getId().equals(user.getId())
                    && (commande.getStatut() == Statut.VALIDEE)) {
                commandeDAO.updateStatut(id, Statut.ANNULEE);
            }
        }

        response.sendRedirect("historique");
    }
}
