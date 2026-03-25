package com.ecommerce.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "panier")
public class Panier {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "utilisateur_id", unique = true)
    private Utilisateur utilisateur;

    // orphanRemoval = true est OBLIGATOIRE pour la suppression en BDD
    @OneToMany(mappedBy = "panier", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private List<LignePanier> items = new ArrayList<>();

    // 1. AJOUTER
    public void ajouterArticle(Produit p) throws Exception {
        LignePanier existant = null;
        for (LignePanier lp : items) {
            if (lp.getProduit().getId().equals(p.getId())) {
                existant = lp; break;
            }
        }
        if (existant != null) {
            if (existant.getQuantite() + 1 > p.getStock()) throw new Exception("Stock insuffisant !");
            existant.setQuantite(existant.getQuantite() + 1);
        } else {
            if (p.getStock() < 1) throw new Exception("Rupture de stock !");
            LignePanier nouvelleLigne = new LignePanier(p, 1);
            nouvelleLigne.setPanier(this); // CRUCIAL POUR SAUVEGARDER LA LIGNE EN BDD
            items.add(nouvelleLigne);
        }
    }

    // 2. MODIFIER QUANTITE
    public void updateQuantite(Long idProduit, int nouvelleQte) throws Exception {
        LignePanier cible = null;
        for (LignePanier lp : items) {
            if (lp.getProduit().getId().equals(idProduit)) {
                cible = lp; break;
            }
        }
        if (cible != null) {
            if (nouvelleQte <= 0) {
                items.remove(cible); // Sera supprimé de la BDD grâce à orphanRemoval
            } else {
                if (nouvelleQte > cible.getProduit().getStock()) {
                    throw new Exception("Maximum disponible : " + cible.getProduit().getStock());
                }
                cible.setQuantite(nouvelleQte);
            }
        }
    }

    // 3. SUPPRIMER
    public void supprimerArticle(Long idProduit) {
        items.removeIf(lp -> lp.getProduit().getId().equals(idProduit));
    }

    @Transient
    public BigDecimal getTotal() {
        BigDecimal total = BigDecimal.ZERO;
        for (LignePanier item : items) {
            total = total.add(item.getSousTotal());
        }
        return total;
    }

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Utilisateur getUtilisateur() { return utilisateur; }
    public void setUtilisateur(Utilisateur utilisateur) { this.utilisateur = utilisateur; }
    public List<LignePanier> getItems() { return items; }
    public void setItems(List<LignePanier> items) { this.items = items; }
}