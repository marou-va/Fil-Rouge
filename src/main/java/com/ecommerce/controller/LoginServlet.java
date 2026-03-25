package com.ecommerce.controller;

import com.ecommerce.dao.UtilisateurDAO;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UtilisateurDAO utilisateurDAO;

    public void init() {
        utilisateurDAO = new UtilisateurDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/vues/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Utilisateur user = utilisateurDAO.findByEmail(email);

        if (user != null && PasswordUtil.checkPassword(password, user.getMotDePasse())) {
            HttpSession session = request.getSession();
            session.invalidate(); // Invalider l'ancienne session
            session = request.getSession(true); // Créer une nouvelle session
            session.setAttribute("utilisateur", user);
            response.sendRedirect("catalogue");
        } else {
            request.setAttribute("error", "Email ou mot de passe incorrect");
            request.getRequestDispatcher("/WEB-INF/vues/login.jsp").forward(request, response);
        }
    }
}
