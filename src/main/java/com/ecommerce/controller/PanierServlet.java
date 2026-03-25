package com.ecommerce.controller;

import com.ecommerce.model.Panier;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.service.PanierService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class PanierServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	private PanierService panierService;

    @Override
    public void init() {
        panierService = new PanierService();
    }

    void setPanierService(PanierService panierService) {
        this.panierService = panierService;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // On cherche toujours la dernière version en base
        Panier panier = panierService.getPanierByUserId(user.getId());
        request.setAttribute("panier", panier); // MAJ pour la vue

        request.getRequestDispatcher("/WEB-INF/vues/panier.jsp").forward(request, response);
    }
}
