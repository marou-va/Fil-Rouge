package com.ecommerce.controller;

import com.ecommerce.service.PanierService;
import com.ecommerce.model.Panier;
import com.ecommerce.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class PanierActionServlet extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PanierService panierService;

    public void init() {
        panierService = new PanierService();
    }

    void setPanierService(PanierService panierService) {
        this.panierService = panierService;
    }

    // La méthode service intercepte à la fois les requêtes GET (liens) et POST (formulaires)
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

        // Vérification de connexion
        if (user == null) {
            request.setAttribute("erreur", "Veuillez vous connecter pour gérer votre panier.");
            request.getRequestDispatcher("/WEB-INF/vues/login.jsp").forward(request, response);
            return;
        }

        String action = request.getParameter("action");
        String idProduitStr = request.getParameter("idProduit");
        String referer = request.getHeader("Referer"); // Pour savoir d'où vient l'utilisateur

        try {
            Panier panierAJour = null;

            if (action != null) {
                switch (action) {
                    case "ajouter":
                        panierAJour = panierService.ajouterAuPanier(user, idProduitStr);
                        break;
                    case "plus":
                    case "minus":
                        panierAJour = panierService.modifierQuantite(user, idProduitStr, action);
                        break;
                    case "supprimer":
                        panierAJour = panierService.supprimerArticle(user, idProduitStr);
                        break;
                    default:
                        throw new IllegalArgumentException("Action non reconnue.");
                }
            }

            if (panierAJour != null) {
                session.setAttribute("cartSize", panierAJour.getItems().size());
                session.removeAttribute("panier"); 
            }

        } catch (Exception e) {
            session.setAttribute("panierErreur", e.getMessage());
        }

        // Si on a ajouté depuis le catalogue, on reste sur le catalogue.
        // Sinon (modification/suppression), on va sur la page panier.
        if ("ajouter".equals(action) && referer != null) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("panier"); // Redirige vers PanierServlet pour afficher la vue
        }
    }
}
