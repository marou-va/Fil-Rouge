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
    public void testGettersAndSetters() {
        Utilisateur user = new Utilisateur();
        user.setId(1L);
        user.setNom("Alice");
        user.setEmail("alice@test.com");
        user.setMotDePasse("secured123");
        user.setAdresse("456 Avenue");
        user.setTelephone("0987654321");
        
        assertEquals(1L, user.getId());
        assertEquals("Alice", user.getNom());
        assertEquals("alice@test.com", user.getEmail());
        assertEquals("secured123", user.getMotDePasse());
        assertEquals("456 Avenue", user.getAdresse());
        assertEquals("0987654321", user.getTelephone());
    }

    @Test
    public void testConstructor() {
        LocalDateTime now = LocalDateTime.now();
        Utilisateur user = new Utilisateur("John Doe", "john@example.com", "hash", Role.CLIENT, now, "0123456789", "123 Street");
        
        assertEquals("John Doe", user.getNom());
        assertEquals("john@example.com", user.getEmail());
        assertEquals(Role.CLIENT, user.getRole());
        assertEquals(now, user.getDateCreation());
        assertEquals("0123456789", user.getTelephone());
        assertEquals("123 Street", user.getAdresse());
    }
}
