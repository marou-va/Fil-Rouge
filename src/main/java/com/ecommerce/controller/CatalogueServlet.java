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
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private ProduitDAO produitDAO;
    private CategorieDAO categorieDAO;

    public void init() {
        produitDAO = new ProduitDAO();
        categorieDAO = new CategorieDAO();
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
                // Ignorer si format invalide
            }
        }

        List<Produit> listeProduits = produitDAO.getProduits(search, categoryId, sort);
        List<Categorie> categories = categorieDAO.getAllCategories();

        request.setAttribute("listeProduits", listeProduits);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/vues/catalogue.jsp").forward(request, response);
    }
}