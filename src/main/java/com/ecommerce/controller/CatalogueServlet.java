package com.ecommerce.controller;

import com.ecommerce.dao.ProduitDAO;
import com.ecommerce.dao.CategorieDAO;
import com.ecommerce.model.Produit;
import com.ecommerce.model.Categorie;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class CatalogueServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    /**
     * 
     */
    private ProduitDAO produitDAO;
    private CategorieDAO categorieDAO;

    public void init() {
        produitDAO = new ProduitDAO();
        categorieDAO = new CategorieDAO();
    }

    private static final int PAGE_SIZE = 12;

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
            try { page = Integer.parseInt(pStr); if (page < 1) page = 1; } catch (NumberFormatException e) {}
        }

        int offset = (page - 1) * PAGE_SIZE;

        List<Produit> listeProduits = produitDAO.getProduits(search, categoryId, sort, minPrice, maxPrice, offset, PAGE_SIZE);
        long totalMatchingProducts = produitDAO.countTotalProduits(search, categoryId, minPrice, maxPrice);
        int totalPages = (int) Math.ceil((double) totalMatchingProducts / PAGE_SIZE);

        List<Categorie> categories = categorieDAO.getAllCategories();
        
        // Calculer le nombre de produits par catégorie (pour la sidebar, on garde le total par catégorie sans filtre de prix/recherche pour la navigation)
        java.util.Map<Long, Long> counts = new java.util.HashMap<>();
        for (Categorie cat : categories) {
            counts.put(cat.getId(), produitDAO.countProduitsParCategorie(cat.getId()));
        }
        long totalCount = produitDAO.countProduitsParCategorie(null);

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