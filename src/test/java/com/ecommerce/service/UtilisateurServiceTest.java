package com.ecommerce.service;

import com.ecommerce.dao.UtilisateurDAO;
import com.ecommerce.model.Role;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.util.PasswordUtil;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

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

        Exception exception = assertThrows(IllegalArgumentException.class, () ->
                utilisateurService.inscrire("John Doe", "test@test.com", "Password123!", "Password123!", "0123456789", "123 Street"));

        assertEquals("Cet email existe déjà", exception.getMessage());
    }

    @Test
    public void testInscrireMotsDePasseDifferents() {
        Exception exception = assertThrows(IllegalArgumentException.class, () ->
                utilisateurService.inscrire("John Doe", "test@test.com", "Password123!", "WrongPass123!", "0123456789", "123 Street"));

        assertEquals("Les mots de passe ne correspondent pas", exception.getMessage());
    }

    @Test
    public void testInscrireTelephoneInvalide() {
        Exception exception = assertThrows(IllegalArgumentException.class, () ->
                utilisateurService.inscrire("John Doe", "test@test.com", "Password123!", "Password123!", "123", "123 Street"));

        assertEquals("Le numéro de téléphone doit contenir exactement 10 chiffres", exception.getMessage());
    }

    @Test
    public void testInscrireMotDePasseFaible() {
        Exception exception = assertThrows(IllegalArgumentException.class, () ->
                utilisateurService.inscrire("John Doe", "test@test.com", "password", "password", "0123456789", "123 Street"));

        assertEquals("Mot de passe invalide : 8 caractères, lettre, chiffre et symbole requis", exception.getMessage());
    }

    @Test
    public void testAuthentifierSucces() {
        Utilisateur user = new Utilisateur();
        user.setEmail("test@test.com");
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

    @Test
    public void testMettreAJourProfilTelephoneNull() {
        Utilisateur user = new Utilisateur();

        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class,
                () -> utilisateurService.mettreAJourProfil(user, "John", "john@test.com", "Adresse", null));

        assertEquals("Toute les champs sont obligatoires", exception.getMessage());
    }

    @Test
    public void testToggleRole() {
        Utilisateur user = new Utilisateur();
        user.setRole(Role.CLIENT);
        when(utilisateurDAO.findByEmail("test@test.com")).thenReturn(user);

        utilisateurService.toggleRole("test@test.com");

        assertEquals(Role.ADMIN, user.getRole());
        verify(utilisateurDAO).update(user);
    }
}
