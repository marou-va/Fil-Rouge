package com.ecommerce.controller;

import com.ecommerce.service.ProduitService;
import com.ecommerce.model.Produit;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;

public class ProduitDetailServlet extends HttpServlet {

    private ProduitService produitService;

    public void init() {
        produitService = new ProduitService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        if (idStr != null && !idStr.isEmpty()) {
            try {
                Long id = Long.parseLong(idStr);

                Produit produit = produitService.getProduitById(id);

                if (produit != null) {
                    request.setAttribute("produit", produit);

                    if (produit.getCategorie() != null) {
                        request.setAttribute("suggestions",
                                produitService.getProduitsSimilaires(
                                        produit.getCategorie().getId(), id));
                    }

                    request.getRequestDispatcher("/WEB-INF/vues/product-detail.jsp")
                           .forward(request, response);

                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Produit introuvable");
                }

            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Format d'ID invalide");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID manquant");
        }
    }
}