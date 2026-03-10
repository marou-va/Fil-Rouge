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
            List<Commande> commandes = commandeDAO.findAll();
            request.setAttribute("commandes", commandes);
            request.setAttribute("statuts", Statut.values());
            request.getRequestDispatcher("/WEB-INF/vues/admin/commandes.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String statutStr = request.getParameter("statut");

        if (idStr != null && statutStr != null) {
            Long id = Long.parseLong(idStr);
            Statut statut = Statut.valueOf(statutStr);
            commandeDAO.updateStatut(id, statut);
        }

        response.sendRedirect("commandes");
    }
}
