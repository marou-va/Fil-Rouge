package com.ecommerce.controller;

import com.ecommerce.model.Categorie;
import com.ecommerce.model.Produit;
import com.ecommerce.service.CategorieService;
import com.ecommerce.service.ProduitService;
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
    private ProduitService produitService;
    private CategorieService categorieService;

    @Override
    public void init() {
        produitService = new ProduitService();
        categorieService = new CategorieService();
    }

    void setProduitService(ProduitService produitService) {
        this.produitService = produitService;
    }

    void setCategorieService(CategorieService categorieService) {
        this.categorieService = categorieService;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String search = request.getParameter("search");

        if ("edit".equals(action)) {
            Produit produit = produitService.getProduitById(request.getParameter("id"));
            if (produit == null) {
                request.getSession().setAttribute("err", "Produit introuvable.");
                response.sendRedirect("produits");
                return;
            }
            request.setAttribute("produit", produit);
            request.setAttribute("categories", categorieService.getAllCategories());
            request.getRequestDispatcher("/WEB-INF/vues/admin/produit-form.jsp").forward(request, response);
        } else if ("add".equals(action)) {
            request.setAttribute("categories", categorieService.getAllCategories());
            request.getRequestDispatcher("/WEB-INF/vues/admin/produit-form.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            try {
                produitService.supprimerProduit(request.getParameter("id"));
                request.getSession().setAttribute("msg", "Produit supprime !");
            } catch (IllegalArgumentException e) {
                request.getSession().setAttribute("err", e.getMessage());
            }
            response.sendRedirect("produits");
        } else {
            List<Produit> produits = (search != null && !search.isEmpty())
                    ? produitService.getProduitsPourAdmin(search)
                    : produitService.getProduitsPourAdmin(null);
            request.setAttribute("produits", produits);
            request.getRequestDispatcher("/WEB-INF/vues/admin/produits.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            produitService.saveOrUpdateProduit(
                    request.getParameter("id"),
                    request.getParameter("nom"),
                    request.getParameter("description"),
                    request.getParameter("prix"),
                    request.getParameter("stock"),
                    request.getParameter("categorieId"),
                    request.getParameter("imageUrl"),
                    request.getParameter("actif") != null);
            response.sendRedirect("produits");
        } catch (IllegalArgumentException e) {
            request.setAttribute("erreur", e.getMessage());
            request.setAttribute("produit", buildProduitFromRequest(request));
            request.setAttribute("categories", categorieService.getAllCategories());
            request.getRequestDispatcher("/WEB-INF/vues/admin/produit-form.jsp").forward(request, response);
        }
    }

    private Produit buildProduitFromRequest(HttpServletRequest request) {
        Produit produit = new Produit();
        produit.setNom(request.getParameter("nom"));
        produit.setDescription(request.getParameter("description"));
        produit.setImageUrl(request.getParameter("imageUrl"));
        produit.setActif(request.getParameter("actif") != null);

        try {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isBlank()) {
                produit.setId(Long.parseLong(idStr));
            }
        } catch (NumberFormatException ignored) {
        }

        try {
            String prixStr = request.getParameter("prix");
            if (prixStr != null && !prixStr.isBlank()) {
                produit.setPrix(new BigDecimal(prixStr));
            }
        } catch (NumberFormatException ignored) {
        }

        try {
            String stockStr = request.getParameter("stock");
            if (stockStr != null && !stockStr.isBlank()) {
                produit.setStock(Integer.parseInt(stockStr));
            }
        } catch (NumberFormatException ignored) {
        }

        try {
            String categorieIdStr = request.getParameter("categorieId");
            if (categorieIdStr != null && !categorieIdStr.isBlank()) {
                Categorie categorie = new Categorie();
                categorie.setId(Long.parseLong(categorieIdStr));
                produit.setCategorie(categorie);
            }
        } catch (NumberFormatException ignored) {
        }

        return produit;
    }
}
