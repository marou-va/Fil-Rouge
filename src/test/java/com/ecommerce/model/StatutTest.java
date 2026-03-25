package com.ecommerce.model;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class StatutTest {

    @Test
    public void testEnumValues() {
        assertEquals(Statut.EN_COURS, Statut.valueOf("EN_COURS"));
        assertEquals(Statut.VALIDEE, Statut.valueOf("VALIDEE"));
        assertEquals(Statut.LIVREE, Statut.valueOf("LIVREE"));
        assertEquals(Statut.ANNULEE, Statut.valueOf("ANNULEE"));
    }

    @Test
    public void testEnumCount() {
        assertEquals(4, Statut.values().length);
    }
}
