package com.ecommerce.controller;

import com.ecommerce.model.Commande;
import com.ecommerce.model.Produit;
import com.ecommerce.model.Statut;
import com.ecommerce.service.CommandeService;
import com.ecommerce.service.ProduitService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private CommandeService commandeService;
    private ProduitService produitService;

    @Override
    public void init() {
        commandeService = new CommandeService();
        produitService = new ProduitService();
    }

    void setCommandeService(CommandeService commandeService) {
        this.commandeService = commandeService;
    }

    void setProduitService(ProduitService produitService) {
        this.produitService = produitService;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Commande> allCommandes = commandeService.findAll();
        List<Produit> allProduits = produitService.getProduitsPourAdmin(null);
        if (allCommandes == null) {
            allCommandes = Collections.emptyList();
        }
        if (allProduits == null) {
            allProduits = Collections.emptyList();
        }

        long totalVentes = allCommandes.stream()
                .filter(c -> c.getStatut() == Statut.LIVREE)
                .count();

        request.setAttribute("totalCommandes", allCommandes.size());
        request.setAttribute("totalProduits", allProduits.size());
        request.setAttribute("totalVentes", totalVentes);
        request.setAttribute("recentCommandes",
                allCommandes.size() > 5 ? allCommandes.subList(0, 5) : allCommandes);

        List<Produit> lowStock = allProduits.stream()
                .filter(p -> p.getStock() < 10)
                .toList();
        request.setAttribute("lowStockProducts", lowStock);

        request.getRequestDispatcher("/WEB-INF/vues/admin/dashboard.jsp").forward(request, response);
    }
}
