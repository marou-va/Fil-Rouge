package com.ecommerce.controller;

import com.ecommerce.dao.CategorieDAO;
import com.ecommerce.dao.ProduitDAO;
import com.ecommerce.model.Categorie;
import com.ecommerce.model.Produit;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/admin/produits")
public class AdminProduitServlet extends HttpServlet {
    private ProduitDAO produitDAO = new ProduitDAO();
    private CategorieDAO categorieDAO = new CategorieDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            Produit produit = produitDAO.getProduitById(id);
            request.setAttribute("produit", produit);
            request.setAttribute("categories", categorieDAO.getAllCategories());
            request.getRequestDispatcher("/WEB-INF/vues/admin/produit-form.jsp").forward(request, response);
        } else if ("add".equals(action)) {
            request.setAttribute("categories", categorieDAO.getAllCategories());
            request.getRequestDispatcher("/WEB-INF/vues/admin/produit-form.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            produitDAO.delete(id);
            response.sendRedirect("produits");
        } else {
            List<Produit> produits = produitDAO.getProduits(null, null, null);
            request.setAttribute("produits", produits);
            request.getRequestDispatcher("/WEB-INF/vues/admin/produits.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String nom = request.getParameter("nom");
        String description = request.getParameter("description");
        BigDecimal prix = new BigDecimal(request.getParameter("prix"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        Long categorieId = Long.parseLong(request.getParameter("categorieId"));
        String imageUrl = request.getParameter("imageUrl");
        boolean actif = request.getParameter("actif") != null;

        Produit produit = new Produit();
        if (idStr != null && !idStr.isEmpty()) {
            produit = produitDAO.getProduitById(Long.parseLong(idStr));
        }

        produit.setNom(nom);
        produit.setDescription(description);
        produit.setPrix(prix);
        produit.setStock(stock);
        produit.setImageUrl(imageUrl);
        produit.setActif(actif);

        Categorie cat = categorieDAO.getCategorieById(categorieId);
        produit.setCategorie(cat);

        if (produit.getId() == null) {
            produitDAO.save(produit);
        } else {
            produitDAO.update(produit);
        }

        response.sendRedirect("produits");
    }
}
