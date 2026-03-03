package com.ecommerce.controller;

import com.ecommerce.dao.ProduitDAO;
import com.ecommerce.model.Produit;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ProduitDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProduitDAO produitDAO;

    public void init() {
        produitDAO = new ProduitDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                Long id = Long.parseLong(idStr);
                Produit produit = produitDAO.getProduitById(id);
                if (produit != null) {
                    request.setAttribute("produit", produit);

                    // Récupérer les suggestions de la même catégorie
                    if (produit.getCategorie() != null) {
                        request.setAttribute("suggestions",
                                produitDAO.getProduitsSimilaires(produit.getCategorie().getId(), id));
                    }

                    request.getRequestDispatcher("/WEB-INF/vues/product-detail.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Produit introuvable");
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Format d'ID invalide");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de produit manquant");
        }
    }
}
