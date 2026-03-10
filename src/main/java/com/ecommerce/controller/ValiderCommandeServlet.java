package com.ecommerce.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.ecommerce.dao.CommandeDAO;
import com.ecommerce.dao.PanierDAO;
import com.ecommerce.dao.ProduitDAO;
import com.ecommerce.dao.UtilisateurDAO;
import com.ecommerce.model.Commande;
import com.ecommerce.model.LigneCommande;
import com.ecommerce.model.LignePanier;
import com.ecommerce.model.Panier;
import com.ecommerce.model.Produit;
import com.ecommerce.model.Statut;
import com.ecommerce.model.Utilisateur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/validercommande")
public class ValiderCommandeServlet extends HttpServlet{
    private static final long serialVersionUID = 1L;
	  private UtilisateurDAO utilisateurDAO;
	  private PanierDAO panierDAO;
	  private ProduitDAO produitDAO;
	  private CommandeDAO commandeDAO;
	  

	    public void init() {
	        utilisateurDAO = new UtilisateurDAO();
	         panierDAO=new PanierDAO();
	  	  produitDAO=new ProduitDAO();
	  	commandeDAO = new CommandeDAO();
	        
	    }

	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        HttpSession session = request.getSession(false); // false = ne pas créer une nouvelle session

	        // Vérifier que la session existe ET que l'utilisateur est connecté
	        if (session == null || session.getAttribute("utilisateur") == null) {
	            response.sendRedirect("login");
	            return;
	        }

	        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

	        // Récupérer le panier depuis la BDD
	        Panier panier = panierDAO.getPanierByUserId(user.getId());
	        if (panier == null || panier.getItems().isEmpty()) {
	            response.sendRedirect("panier");
	            return;
	        }

	        // Vérification du stock
	        StringBuilder erreurStock = new StringBuilder();
	        boolean stockInsuffisant = false;

	        for (LignePanier item : panier.getItems()) {
	            Produit produitActuel = produitDAO.getProduitById(item.getProduit().getId());

	            if (produitActuel == null) {
	                erreurStock.append("Le produit « ")
	                           .append(item.getProduit().getNom())
	                           .append(" » n'est plus disponible. ");
	                stockInsuffisant = true;

	            } else if (produitActuel.getStock() == 0) {
	                erreurStock.append("« ").append(produitActuel.getNom())
	                           .append(" » est épuisé. ");
	                stockInsuffisant = true;

	            } else if (item.getQuantite() > produitActuel.getStock()) {
	                erreurStock.append("« ").append(produitActuel.getNom())
	                           .append(" » : vous en demandez ").append(item.getQuantite())
	                           .append(" mais seulement ").append(produitActuel.getStock())
	                           .append(" sont disponibles. ");
	                stockInsuffisant = true;

	            } else {
	                item.getProduit().setStock(produitActuel.getStock());
	            }
	        } 
	       

	        // return après sendRedirect
	        if (stockInsuffisant) {
	            session.setAttribute("panierErreur", erreurStock.toString().trim());
	            response.sendRedirect("panier");
	            return; // ← OBLIGATOIRE
	        }

	        // transmettre le panier à la JSP
	        request.setAttribute("panier", panier);

	        request.getRequestDispatcher("/WEB-INF/vues/validercommande.jsp")
	               .forward(request, response);
	    }
	    
	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        HttpSession session = request.getSession(false);

	        // Vérifier session
	        if (session == null || session.getAttribute("utilisateur") == null) {
	            response.sendRedirect("login");
	            return;
	        }

	        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");

	        // Récupérer le panier depuis la BDD
	        Panier panier = panierDAO.getPanierByUserId(user.getId());
	        if (panier == null || panier.getItems().isEmpty()) {
	            response.sendRedirect("panier");
	            return;
	        }

	        // ── Vérification du stock (identique au doGet) ──
	        StringBuilder erreurStock = new StringBuilder();
	        boolean stockInsuffisant = false;

	        for (LignePanier item : panier.getItems()) {
	            Produit produitActuel = produitDAO.getProduitById(item.getProduit().getId());

	            if (produitActuel == null) {
	                erreurStock.append("Le produit « ")
	                           .append(item.getProduit().getNom())
	                           .append(" » n'est plus disponible. ");
	                stockInsuffisant = true;

	            } else if (produitActuel.getStock() == 0) {
	                erreurStock.append("« ").append(produitActuel.getNom())
	                           .append(" » est épuisé. ");
	                stockInsuffisant = true;

	            } else if (item.getQuantite() > produitActuel.getStock()) {
	                erreurStock.append("« ").append(produitActuel.getNom())
	                           .append(" » : vous en demandez ").append(item.getQuantite())
	                           .append(" mais seulement ").append(produitActuel.getStock())
	                           .append(" sont disponibles. ");
	                stockInsuffisant = true;
	            }
	        }

	        // Si stock insuffisant entre le doGet et le doPost → retour panier
	        if (stockInsuffisant) {
	            session.setAttribute("panierErreur", erreurStock.toString().trim());
	            response.sendRedirect("panier");
	            return;
	        }

	        // ── Créer la commande ──
	        Commande commande = new Commande();
	        commande.setUtilisateur(user);
	        commande.setDateCommande(LocalDateTime.now());
	        commande.setStatut(Statut.VALIDEE);

	        // ── Créer les lignes de commande depuis le panier ──
	        List<LigneCommande> lignes = new ArrayList<>();
	        for (LignePanier item : panier.getItems()) {
	            LigneCommande ligne = new LigneCommande( commande,item.getProduit(),item.getQuantite(),item.getProduit().getPrix());
	            lignes.add(ligne);
	        }
	        commande.setItems(lignes);

	        //
	        commandeDAO.save(commande);

	        // ── Vider le panier ──
	        panierDAO.viderPanier(panier);

	        // ── Rediriger vers confirmation ──
	        response.sendRedirect("panier");
	    }
}
