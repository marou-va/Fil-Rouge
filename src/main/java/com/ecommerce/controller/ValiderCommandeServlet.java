package com.ecommerce.controller;

import com.ecommerce.model.Panier;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.service.CommandeService;
import com.ecommerce.service.PanierService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/validercommande")
public class ValiderCommandeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PanierService  panierService;
    private CommandeService commandeService;

    @Override
    public void init() {
        panierService   = new PanierService();
        commandeService = new CommandeService();
    }

    // ── GET : affichage de la page de confirmation ─────────────────────────────

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = utilisateurConnecte(request, response);
        if (user == null) return;

        Panier panier = panierService.getPanierByUserId(user.getId());
        if (panier == null || panier.getItems().isEmpty()) {
            response.sendRedirect("panier");
            return;
        }
        //la verification du stock avant rediriger vers la page de validaton de commande 

        List<String> erreurs = panierService.verifierStock(panier);
        if (!erreurs.isEmpty()) {
            request.getSession().setAttribute("panierErreur", String.join(" ", erreurs));
            response.sendRedirect("panier");
            return;
        }

        request.setAttribute("panier", panier);
        request.getRequestDispatcher("/WEB-INF/vues/validercommande.jsp")
                .forward(request, response);
    }

    // ── POST : création de la commande ─────────────────────────────────────────

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utilisateur user    = utilisateurConnecte(request, response);
        if (user == null) return;

        Panier panier = panierService.getPanierByUserId(user.getId());
        if (panier == null || panier.getItems().isEmpty()) {
            response.sendRedirect("panier");
            return;
        }

        // Vérification du stock une 2e fois (protection contre les races conditions)
        List<String> erreurs = panierService.verifierStock(panier);
        if (!erreurs.isEmpty()) {
            session.setAttribute("panierErreur", String.join(" ", erreurs));
            response.sendRedirect("panier");
            return;
        }

        // Création de la commande + décrémentation du stock
        commandeService.creerCommande(user, panier);

        // Vider le panier
        panierService.viderPanier(panier);
        session.removeAttribute("cartSize");

        response.sendRedirect("panier");
    }

    // ── Helper ─────────────────────────────────────────────────────────────────

    private Utilisateur utilisateurConnecte(HttpServletRequest request,
                                             HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        Utilisateur user    = (session != null)
                              ? (Utilisateur) session.getAttribute("utilisateur")
                              : null;
        if (user == null) response.sendRedirect("login");
        return user;
    }
}