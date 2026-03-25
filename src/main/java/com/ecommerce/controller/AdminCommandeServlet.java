package com.ecommerce.controller;

import com.ecommerce.model.Commande;
import com.ecommerce.model.Statut;
import com.ecommerce.service.CommandeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/commandes")
public class AdminCommandeServlet extends HttpServlet {
    private CommandeService commandeService;

    @Override
    public void init() {
        commandeService = new CommandeService();
    }

    void setCommandeService(CommandeService commandeService) {
        this.commandeService = commandeService;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("view".equals(action)) {
            Commande commande = commandeService.findById(request.getParameter("id"));
            if (commande == null) {
                response.sendRedirect("commandes");
                return;
            }
            request.setAttribute("commande", commande);
            request.getRequestDispatcher("/WEB-INF/vues/admin/commande-detail.jsp").forward(request, response);
        } else {
            List<Commande> commandes = commandeService.findAll(
                    request.getParameter("status"),
                    request.getParameter("date"));
            request.setAttribute("commandes", commandes);
            request.setAttribute("statuts", Statut.values());
            request.getRequestDispatcher("/WEB-INF/vues/admin/commandes.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("id") != null && request.getParameter("action") != null) {
            try {
                commandeService.updateStatutAdmin(
                        request.getParameter("id"),
                        request.getParameter("action"),
                        request.getParameter("statut"));
            } catch (IllegalArgumentException e) {
                request.getSession().setAttribute("err", e.getMessage());
            }
        }

        response.sendRedirect("commandes");
    }
}
