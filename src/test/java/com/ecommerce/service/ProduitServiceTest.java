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

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

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
        when(produitDAO.getProduits(anyString(), anyLong(), anyString())).thenReturn(expected);

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
}
