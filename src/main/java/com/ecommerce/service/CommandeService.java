package com.ecommerce.service;



import com.ecommerce.dao.CommandeDAO;
import com.ecommerce.dao.ProduitDAO;
import com.ecommerce.model.Commande;
import com.ecommerce.model.LigneCommande;
import com.ecommerce.model.LignePanier;
import com.ecommerce.model.Panier;
import com.ecommerce.model.Produit;
import com.ecommerce.model.Statut;
import com.ecommerce.model.Utilisateur;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class CommandeService {

    private final CommandeDAO commandeDAO;
    private final ProduitDAO  produitDAO;

    public CommandeService() {
        this.commandeDAO = new CommandeDAO();
        this.produitDAO  = new ProduitDAO();
    }

    //creer une commande 

    public Commande creerCommande(Utilisateur user, Panier panier) {
        Commande commande = new Commande();
        commande.setUtilisateur(user);
        commande.setDateCommande(LocalDateTime.now());
        commande.setStatut(Statut.VALIDEE);

        List<LigneCommande> lignes = new ArrayList<>();
        for (LignePanier item : panier.getItems()) {
            LigneCommande ligne = new LigneCommande(
                    commande,
                    item.getProduit(),
                    item.getQuantite(),
                    item.getProduit().getPrix());
            lignes.add(ligne);

            // Décrémenter le stock
            Produit produit = produitDAO.getProduitById(item.getProduit().getId());
            produit.setStock(produit.getStock() - item.getQuantite());
            produitDAO.update(produit);
        }
        commande.setItems(lignes);
        commandeDAO.save(commande);
        return commande;
    }
    // recuperer la liste des commande par utilisateur (filtre date  et filtre status)
    public List<Commande> findByUtilisateur(Long userId, String statusStr, String dateStr) {
        Statut status = parseStatut(statusStr);
        LocalDateTime[] plage = parsePlageJour(dateStr);
        return commandeDAO.findByUserId(userId, status, plage[0], plage[1]);
    }

   //recuperer les information detailer d une commande 
    public Commande findByIdPourUtilisateur(Long commandeId, Long userId) {
        Commande commande = commandeDAO.findById(commandeId);
        if (commande != null && commande.getUtilisateur().getId().equals(userId)) {
            return commande;
        }
        return null;
    }

   //annuler une commande 
    public void annulerCommande(Long commandeId, Long userId) {
        Commande commande = commandeDAO.findById(commandeId);
        if (commande != null
                && commande.getUtilisateur().getId().equals(userId)
                && commande.getStatut() == Statut.VALIDEE) {
            commandeDAO.updateStatut(commandeId, Statut.ANNULEE);
        }
    }

    // ── Helpers privés ─────────────────────────────────────────────────────────

    private Statut parseStatut(String statusStr) {
        if (statusStr == null || statusStr.isBlank()) return null;
        try {
            return Statut.valueOf(statusStr);
        } catch (IllegalArgumentException e) {
            return null;
        }
    }

    /** Retourne [dateDebut, dateFin] pour un jour donné, ou [null, null]. */
    private LocalDateTime[] parsePlageJour(String dateStr) {
        if (dateStr == null || dateStr.isBlank()) {
            return new LocalDateTime[]{null, null};
        }
        try {
            LocalDate date = LocalDate.parse(dateStr);
            return new LocalDateTime[]{date.atStartOfDay(), date.atTime(LocalTime.MAX)};
        } catch (Exception e) {
            return new LocalDateTime[]{null, null};
        }
    }
}