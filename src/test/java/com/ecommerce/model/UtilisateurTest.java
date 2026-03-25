package com.ecommerce.model;

import org.junit.jupiter.api.Test;
import java.time.LocalDateTime;
import static org.junit.jupiter.api.Assertions.*;

public class UtilisateurTest {

    @Test
    public void testSetAndGetRole() {
        Utilisateur user = new Utilisateur();
        user.setRole(Role.ADMIN);
        assertEquals(Role.ADMIN, user.getRole());
        
        user.setRole(Role.CLIENT);
        assertEquals(Role.CLIENT, user.getRole());
    }

    @Test
    public void testConstructor() {
        LocalDateTime now = LocalDateTime.now();
        Utilisateur user = new Utilisateur("John Doe", "john@example.com", "hash", Role.CLIENT, now, "0123456789", "123 Street");
        
        assertEquals("John Doe", user.getNom());
        assertEquals("john@example.com", user.getEmail());
        assertEquals(Role.CLIENT, user.getRole());
        assertEquals(now, user.getDateCreation());
    }
}
