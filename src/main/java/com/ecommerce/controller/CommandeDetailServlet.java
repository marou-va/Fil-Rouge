package com.ecommerce.controller;

import com.ecommerce.dao.CommandeDAO;
import com.ecommerce.model.Commande;
import com.ecommerce.model.Utilisateur;
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

        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                Long commandeId = Long.parseLong(idParam);
                Commande commande = commandeDAO.findById(commandeId);

                // Vérifier que la commande existe et appartient à l'utilisateur
                if (commande != null && commande.getUtilisateur().getId().equals(user.getId())) {
                    request.setAttribute("commande", commande);
                    request.getRequestDispatcher("/WEB-INF/vues/commande-detail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // ID invalide
            }
        }

        response.sendRedirect("historique");
    }
}
