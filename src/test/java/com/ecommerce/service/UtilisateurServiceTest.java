package com.ecommerce.service;

import com.ecommerce.dao.UtilisateurDAO;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.util.PasswordUtil;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class UtilisateurServiceTest {

    @Mock
    private UtilisateurDAO utilisateurDAO;

    @InjectMocks
    private UtilisateurService utilisateurService;

    @Test
    public void testInscrireSucces() {
        when(utilisateurDAO.findByEmail("test@test.com")).thenReturn(null);

        utilisateurService.inscrire("John Doe", "test@test.com", "Password123!", "Password123!", "0123456789", "123 Street");

        verify(utilisateurDAO).save(any(Utilisateur.class));
    }

    @Test
    public void testInscrireEmailExistant() {
        when(utilisateurDAO.findByEmail("test@test.com")).thenReturn(new Utilisateur());

        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            utilisateurService.inscrire("John Doe", "test@test.com", "Password123!", "Password123!", "0123456789", "123 Street");
        });

        assertEquals("Cet email existe déjà", exception.getMessage());
    }

    @Test
    public void testInscrireMotsDePasseDifferents() {
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            utilisateurService.inscrire("John Doe", "test@test.com", "Password123!", "WrongPass123!", "0123456789", "123 Street");
        });

        assertEquals("Les mots de passe ne correspondent pas", exception.getMessage());
    }

    @Test
    public void testAuthentifierSucces() {
        Utilisateur user = new Utilisateur();
        user.setEmail("test@test.com");
        // jbcrypt hashed password for 'Password123!'
        user.setMotDePasse(PasswordUtil.hashPassword("Password123!")); 
        
        when(utilisateurDAO.findByEmail("test@test.com")).thenReturn(user);

        Utilisateur result = utilisateurService.authentifier("test@test.com", "Password123!");

        assertNotNull(result);
        assertEquals("test@test.com", result.getEmail());
    }

    @Test
    public void testAuthentifierEchec() {
        when(utilisateurDAO.findByEmail("test@test.com")).thenReturn(null);

        Utilisateur result = utilisateurService.authentifier("test@test.com", "wrongpass");

        assertNull(result);
    }
}
