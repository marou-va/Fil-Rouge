package com.ecommerce.controller;

import com.ecommerce.dao.PanierDAO;
import com.ecommerce.model.Panier;
import com.ecommerce.model.Role;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.service.UtilisateurService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UtilisateurService utilisateurService;
    private PanierDAO panierDAO;

    @Override
    public void init() {
        utilisateurService = new UtilisateurService();
        panierDAO          = new PanierDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/vues/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);

        // ── Gestion du blocage anti-brute-force ───────────────────────────────
        Integer tentatives    = (Integer) session.getAttribute("loginTentatives");
        Long    blocageDepuis = (Long)    session.getAttribute("loginBlocageDepuis");

        if (tentatives == null) tentatives = 0;

        if (blocageDepuis != null) {
            long secondesEcoulees = (System.currentTimeMillis() - blocageDepuis) / 1000;
            if (secondesEcoulees < 30) {
                long restantes = 30 - secondesEcoulees;
                request.setAttribute("error",
                        "Trop de tentatives. Réessayez dans " + restantes + " seconde(s).");
                request.setAttribute("bloque", true);
                request.getRequestDispatcher("/WEB-INF/vues/login.jsp").forward(request, response);
                return;
            }
            // Blocage expiré : réinitialiser
            session.removeAttribute("loginTentatives");
            session.removeAttribute("loginBlocageDepuis");
            tentatives = 0;
        }

        // ── Authentification via le service ───────────────────────────────────
        String     email     = request.getParameter("email");
        String     password  = request.getParameter("password");
        Utilisateur user     = utilisateurService.authentifier(email, password);

        if (user != null) {
            // Succès : ouvrir une nouvelle session propre
            session.invalidate();
            session = request.getSession(true);
            session.setAttribute("utilisateur", user);

            Panier panier = panierDAO.getPanierByUserId(user.getId());
            int cartSize  = (panier != null && panier.getItems() != null)
                            ? panier.getItems().size() : 0;
            session.setAttribute("cartSize", cartSize);

            if (user.getRole() == Role.ADMIN) {
                response.sendRedirect("admin-choice");
            } else {
                response.sendRedirect("catalogue");
            }

        } else {
            // Échec : incrémenter le compteur de tentatives
            tentatives++;
            session.setAttribute("loginTentatives", tentatives);

            if (tentatives >= 3) {
                session.setAttribute("loginBlocageDepuis", System.currentTimeMillis());
                request.setAttribute("error", "Trop de tentatives. Réessayez dans 30 seconde(s).");
                request.setAttribute("bloque", true);
            } else {
                int restantes = 3 - tentatives;
                request.setAttribute("error",
                        "Email ou mot de passe incorrect. " + restantes + " tentative(s) restante(s).");
            }

            request.getRequestDispatcher("/WEB-INF/vues/login.jsp").forward(request, response);
        }
    }
}