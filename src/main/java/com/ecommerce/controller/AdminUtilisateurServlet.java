package com.ecommerce.controller;

import com.ecommerce.dao.UtilisateurDAO;
import com.ecommerce.model.Role;
import com.ecommerce.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/utilisateurs")
public class AdminUtilisateurServlet extends HttpServlet {
    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("toggleRole".equals(action)) {
            String email = request.getParameter("email");
            Utilisateur user = utilisateurDAO.findByEmail(email);
            if (user != null) {
                user.setRole(user.getRole() == Role.ADMIN ? Role.CLIENT : Role.ADMIN);
                utilisateurDAO.update(user);
            }
            response.sendRedirect("utilisateurs");
        } else {
            List<Utilisateur> users = utilisateurDAO.findAll();
            request.setAttribute("utilisateurs", users);
            request.getRequestDispatcher("/WEB-INF/vues/admin/utilisateurs.jsp").forward(request, response);
        }
    }
}
