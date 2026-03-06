package com.ecommerce.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "ligne_panier")
public class LignePanier {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "panier_id")
    private Panier panier;

    @ManyToOne(fetch = FetchType.EAGER) 
    @JoinColumn(name = "produit_id")
    private Produit produit;

    @Column(nullable = false)
    private int quantite;

    public LignePanier() {}

    public LignePanier(Produit produit, int quantite) {
        this.produit = produit;
        this.quantite = quantite;
    }

    @Transient
    public BigDecimal getSousTotal() {
        return produit.getPrix().multiply(new BigDecimal(quantite));
    }

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Panier getPanier() { return panier; }
    public void setPanier(Panier panier) { this.panier = panier; }
    public Produit getProduit() { return produit; }
    public void setProduit(Produit produit) { this.produit = produit; }
    public int getQuantite() { return quantite; }
    public void setQuantite(int quantite) { this.quantite = quantite; }
}