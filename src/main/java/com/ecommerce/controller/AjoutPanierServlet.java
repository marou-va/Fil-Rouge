package com.ecommerce.controller;

import com.ecommerce.dao.*;
import com.ecommerce.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AjoutPanierServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    /**
	 * 
	 */
	private ProduitDAO produitDAO = new ProduitDAO();
    private PanierDAO panierDAO = new PanierDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            Long idProduit = Long.parseLong(request.getParameter("idProduit"));
            Produit produit = produitDAO.getProduitById(idProduit);

            if (produit != null) {
                // 1. Récupération et ajout (Logique métier)
                Panier panier = panierDAO.getPanierByUserId(user.getId());
                if (panier == null) {
                    panier = new Panier();
                    panier.setUtilisateur(user);
                }
                panier.ajouterArticle(produit);
                panierDAO.saveOrUpdate(panier); // Sauvegarde en BDD
                
                // =========================================================
                // 2. LE REMÈDE ANTI-CRASH : On ne stocke qu'un simple chiffre !
                int taillePanier = panierDAO.getCartSize(user.getId());
                session.setAttribute("cartSize", taillePanier);
                
                // On détruit l'objet complexe de la session au cas où il y serait encore
                session.removeAttribute("panier"); 
                // =========================================================
            }
        } catch (Exception e) {
            session.setAttribute("panierErreur", e.getMessage());
        }

        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : "catalogue");
    }
}