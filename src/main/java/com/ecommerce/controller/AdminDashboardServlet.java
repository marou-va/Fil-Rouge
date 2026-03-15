package com.ecommerce.controller;

import com.ecommerce.dao.CommandeDAO;
import com.ecommerce.dao.ProduitDAO;
import com.ecommerce.dao.UtilisateurDAO;
import com.ecommerce.model.Commande;
import com.ecommerce.model.Produit;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
        private CommandeDAO commandeDAO = new CommandeDAO();
        private ProduitDAO produitDAO = new ProduitDAO();
        private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {

                // Statistiques rapides
                List<Commande> allCommandes = commandeDAO.findAll();
                List<Produit> allProduits = produitDAO.getProduits(null, null, null);
                long totalUsers = utilisateurDAO.findAll().size();

                long totalVentes = 0;
                if (allCommandes != null) {
                        totalVentes = allCommandes.stream()
                                        .filter(c -> c.getStatut() == com.ecommerce.model.Statut.LIVREE)
                                        .count();
                }

                request.setAttribute("totalCommandes", allCommandes != null ? allCommandes.size() : 0);
                request.setAttribute("totalProduits", allProduits != null ? allProduits.size() : 0);
                request.setAttribute("totalUsers", totalUsers);
                request.setAttribute("totalVentes", totalVentes);
                request.setAttribute("recentCommandes",
                                allCommandes != null && allCommandes.size() > 5 ? allCommandes.subList(0, 5)
                                                : allCommandes);

                List<Produit> lowStock = allProduits.stream()
                                .filter(p -> p.getStock() < 10)
                                .toList();
                request.setAttribute("lowStockProducts", lowStock);

                request.getRequestDispatcher("/WEB-INF/vues/admin/dashboard.jsp").forward(request, response);
        }
}
