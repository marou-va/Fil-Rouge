package com.ecommerce.controller;

import com.ecommerce.dao.PanierDAO;
import com.ecommerce.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class UpdatePanierServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PanierDAO panierDAO = new PanierDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        Long idProduit = Long.parseLong(request.getParameter("id"));

        try {
            Panier panier = panierDAO.getPanierByUserId(user.getId());
            if (panier != null) {
                for (LignePanier lp : panier.getItems()) {
                    if (lp.getProduit().getId().equals(idProduit)) {
                        int newQte = action.equals("plus") ? lp.getQuantite() + 1 : lp.getQuantite() - 1;
                        panier.updateQuantite(idProduit, newQte);
                        break;
                    }
                }
                Panier savedPanier = panierDAO.saveOrUpdate(panier);
                session.setAttribute("panier", savedPanier);
            }
        } catch (Exception e) {
            session.setAttribute("panierErreur", e.getMessage());
        }

        response.sendRedirect("panier");
    }
}