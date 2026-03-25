package com.ecommerce.service;

import com.ecommerce.dao.CategorieDAO;
import com.ecommerce.dao.ProduitDAO;
import com.ecommerce.model.Categorie;
import com.ecommerce.model.Produit;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class ProduitServiceTest {

    @Mock
    private ProduitDAO produitDAO;

    @Mock
    private CategorieDAO categorieDAO;

    @InjectMocks
    private ProduitService produitService;

    @Test
    public void testGetProduits() {
        List<Produit> expected = new ArrayList<>();
        when(produitDAO.getProduits("search", 1L, "price_asc")).thenReturn(expected);

        List<Produit> result = produitService.getProduits("search", 1L, "price_asc");

        assertEquals(expected, result);
    }

    @Test
    public void testGetCategoryCounts() {
        Categorie cat1 = new Categorie();
        cat1.setId(1L);
        List<Categorie> categories = new ArrayList<>();
        categories.add(cat1);

        when(produitDAO.countProduitsParCategorie(1L)).thenReturn(5L);

        Map<Long, Long> counts = produitService.getCategoryCounts(categories);

        assertEquals(1, counts.size());
        assertEquals(5L, counts.get(1L));
    }

    @Test
    public void testGetProduitById() {
        Produit p = new Produit();
        p.setId(10L);
        when(produitDAO.getProduitById(10L)).thenReturn(p);

        Produit result = produitService.getProduitById(10L);

        assertNotNull(result);
        assertEquals(10L, result.getId());
    }

    @Test
    public void testSaveOrUpdateProduitCreation() {
        Categorie categorie = new Categorie();
        categorie.setId(1L);
        when(categorieDAO.getCategorieById(1L)).thenReturn(categorie);

        Produit result = produitService.saveOrUpdateProduit(
                null, "Chaise", "Confortable", "99.90", "5", "1", "img.webp", true);

        assertEquals("Chaise", result.getNom());
        assertEquals(new BigDecimal("99.90"), result.getPrix());
        assertEquals(5, result.getStock());
        assertEquals(categorie, result.getCategorie());
        verify(produitDAO).save(any(Produit.class));
    }

    @Test
    public void testSaveOrUpdateProduitPrixInvalide() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class,
                () -> produitService.saveOrUpdateProduit(null, "Chaise", "Confortable",
                        "abc", "5", "1", "img.webp", true));

        assertEquals("Prix invalide.", exception.getMessage());
    }

    @Test
    public void testSupprimerProduitAvecIdInvalide() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class,
                () -> produitService.supprimerProduit("abc"));

        assertEquals("Identifiant de produit invalide.", exception.getMessage());
    }
}
