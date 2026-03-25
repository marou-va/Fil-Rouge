package com.ecommerce.controller;

import com.ecommerce.service.ProduitService;
import com.ecommerce.model.Produit;
import com.ecommerce.model.Categorie;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public class CatalogueServlet extends HttpServlet {

    private ProduitService produitService;

    public void init() {
        produitService = new ProduitService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        String cid = request.getParameter("cid");
        String sort = request.getParameter("sort");

        Long categoryId = null;
        if (cid != null && !cid.isEmpty()) {
            try {
                categoryId = Long.parseLong(cid);
            } catch (NumberFormatException e) {
                // ignore
            }
        }

        List<Produit> listeProduits = produitService.getProduits(search, categoryId, sort);
        List<Categorie> categories = produitService.getCategories();
        Map<Long, Long> counts = produitService.getCategoryCounts(categories);
        long totalCount = produitService.getTotalCount();

        request.setAttribute("listeProduits", listeProduits);
        request.setAttribute("categories", categories);
        request.setAttribute("categoryCounts", counts);
        request.setAttribute("totalCount", totalCount);

        request.getRequestDispatcher("/WEB-INF/vues/catalogue.jsp").forward(request, response);
    }
}