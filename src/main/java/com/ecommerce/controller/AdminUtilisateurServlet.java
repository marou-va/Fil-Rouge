package com.ecommerce.controller;

import com.ecommerce.model.Utilisateur;
import com.ecommerce.service.UtilisateurService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/utilisateurs")
public class AdminUtilisateurServlet extends HttpServlet {
    private UtilisateurService utilisateurService;

    @Override
    public void init() {
        utilisateurService = new UtilisateurService();
    }

    void setUtilisateurService(UtilisateurService utilisateurService) {
        this.utilisateurService = utilisateurService;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("toggleRole".equals(action)) {
            try {
                utilisateurService.toggleRole(request.getParameter("email"));
            } catch (IllegalArgumentException e) {
                request.getSession().setAttribute("err", e.getMessage());
            }
            response.sendRedirect("utilisateurs");
        } else {
            List<Utilisateur> users = utilisateurService.findAllUtilisateurs();
            request.setAttribute("utilisateurs", users);
            request.getRequestDispatcher("/WEB-INF/vues/admin/utilisateurs.jsp").forward(request, response);
        }
    }
}
