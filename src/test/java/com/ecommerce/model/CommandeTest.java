package com.ecommerce.model;

import org.junit.jupiter.api.Test;
import java.time.LocalDateTime;
import java.util.ArrayList;
import static org.junit.jupiter.api.Assertions.*;

public class CommandeTest {

    @Test
    public void testDateLivraison() {
        Commande commande = new Commande();
        LocalDateTime deliveryDate = LocalDateTime.now().plusDays(3);
        commande.setDateLivraison(deliveryDate);
        
        assertEquals(deliveryDate, commande.getDateLivraison());
    }

    @Test
    public void testStatut() {
        Commande commande = new Commande();
        commande.setStatut(Statut.LIVREE);
        assertEquals(Statut.LIVREE, commande.getStatut());
    }

    @Test
    public void testLignesDeCommande() {
        Commande commande = new Commande();
        commande.setItems(new ArrayList<>());
        
        Produit p = new Produit();
        p.setNom("Test");
        
        LigneCommande ligne = new LigneCommande(commande, p, 1, java.math.BigDecimal.TEN);
        commande.getItems().add(ligne);
        
        assertEquals(1, commande.getItems().size());
        assertEquals(p, commande.getItems().get(0).getProduit());
    }
}
