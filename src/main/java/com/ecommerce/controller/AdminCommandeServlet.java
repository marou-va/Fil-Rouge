package com.ecommerce.controller;

import com.ecommerce.dao.CommandeDAO;
import com.ecommerce.model.Commande;
import com.ecommerce.model.Statut;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@WebServlet("/admin/commandes")
public class AdminCommandeServlet extends HttpServlet {
    private CommandeDAO commandeDAO = new CommandeDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("view".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            Commande commande = commandeDAO.findById(id);
            request.setAttribute("commande", commande);
            request.getRequestDispatcher("/WEB-INF/vues/admin/commande-detail.jsp").forward(request, response);
        } else {
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

            List<Commande> commandes = commandeDAO.findAll(status, dateDebut, dateFin);
            request.setAttribute("commandes", commandes);
            request.setAttribute("statuts", Statut.values());
            request.getRequestDispatcher("/WEB-INF/vues/admin/commandes.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String action = request.getParameter("action");

        if (idStr != null && action != null) {
            Long id = Long.parseLong(idStr);
            if ("ship".equals(action)) {
                commandeDAO.updateStatut(id, Statut.EN_COURS);
            } else {
                // Pour d'autres statuts si nécessaire
                String statutStr = request.getParameter("statut");
                if (statutStr != null) {
                    commandeDAO.updateStatut(id, Statut.valueOf(statutStr));
                }
            }
        }

        response.sendRedirect("commandes");
    }
}
