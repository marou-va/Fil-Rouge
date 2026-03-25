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
        String minP = request.getParameter("minPrice");
        String maxP = request.getParameter("maxPrice");
        String pStr = request.getParameter("page");

        Long categoryId = null;
        Double minPrice = null;
        Double maxPrice = null;
        int page = 1;

        if (cid != null && !cid.isEmpty()) {
            try { categoryId = Long.parseLong(cid); } catch (NumberFormatException e) {}
        }
        if (minP != null && !minP.isEmpty()) {
            try { minPrice = Double.parseDouble(minP); } catch (NumberFormatException e) {}
        }
        if (maxP != null && !maxP.isEmpty()) {
            try { maxPrice = Double.parseDouble(maxP); } catch (NumberFormatException e) {}
        }
        if (pStr != null && !pStr.isEmpty()) {
            try { 
                page = Integer.parseInt(pStr); 
                if (page < 1) page = 1; 
            } catch (NumberFormatException e) {}
        }

        int offset = (page - 1) * ProduitService.PAGE_SIZE;

        List<Produit> listeProduits = produitService.getProduits(search, categoryId, sort, minPrice, maxPrice, offset, ProduitService.PAGE_SIZE);
        long totalMatchingProducts = produitService.countTotalProduits(search, categoryId, minPrice, maxPrice);
        int totalPages = (int) Math.ceil((double) totalMatchingProducts / ProduitService.PAGE_SIZE);

        List<Categorie> categories = produitService.getCategories();
        Map<Long, Long> counts = produitService.getCategoryCounts(categories);
        long totalCount = produitService.getTotalCount();

        request.setAttribute("listeProduits", listeProduits);
        request.setAttribute("categories", categories);
        request.setAttribute("categoryCounts", counts);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalMatching", totalMatchingProducts);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);

        request.getRequestDispatcher("/WEB-INF/vues/catalogue.jsp").forward(request, response);
    }
}