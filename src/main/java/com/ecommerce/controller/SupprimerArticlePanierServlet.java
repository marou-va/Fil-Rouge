package com.ecommerce.controller;

import com.ecommerce.dao.PanierDAO;
import com.ecommerce.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class SupprimerArticlePanierServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PanierDAO panierDAO = new PanierDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

        if (user != null) {
            Long idProduit = Long.parseLong(request.getParameter("id"));
            Panier panier = panierDAO.getPanierByUserId(user.getId());
            
            if (panier != null) {
                panier.supprimerArticle(idProduit);
                Panier savedPanier = panierDAO.saveOrUpdate(panier);
                session.setAttribute("panier", savedPanier);
            }
        }
        
        response.sendRedirect("panier");
    }
}