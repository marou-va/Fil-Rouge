package com.ecommerce.controller;

import com.ecommerce.dao.UtilisateurDAO;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UtilisateurDAO utilisateurDAO;

    public void init() {
        utilisateurDAO = new UtilisateurDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/vues/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Les mots de passe ne correspondent pas");
            request.getRequestDispatcher("/WEB-INF/vues/register.jsp").forward(request, response);
            return;
        }

        if (utilisateurDAO.findByEmail(email) != null) {
            request.setAttribute("error", "Cet email est déjà utilisé");
            request.getRequestDispatcher("/WEB-INF/vues/register.jsp").forward(request, response);
            return;
        }

        Utilisateur user = new Utilisateur();
        user.setNom(nom);
        user.setEmail(email);
        user.setMotDePasse(PasswordUtil.hashPassword(password));
        user.setRole(Utilisateur.Role.CLIENT);

        utilisateurDAO.save(user);

        response.sendRedirect("login");
    }
}
