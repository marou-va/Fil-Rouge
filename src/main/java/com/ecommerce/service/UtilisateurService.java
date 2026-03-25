package com.ecommerce.service;


import com.ecommerce.dao.UtilisateurDAO;
import com.ecommerce.model.Role;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.util.PasswordUtil;

import java.time.LocalDateTime;
import java.util.List;

public class UtilisateurService {

    private final UtilisateurDAO utilisateurDAO;

    public UtilisateurService() {
        this.utilisateurDAO = new UtilisateurDAO();
    }

    public UtilisateurService(UtilisateurDAO utilisateurDAO) {
        this.utilisateurDAO = utilisateurDAO;
    }

    public void inscrire(String nom, String email, String motDePasse,
                         String confirmer, String telephone, String adresse) {

    

          // 1. Champs obligatoires
          if (nom == null || nom.isBlank() ||
              email == null || email.isBlank() ||
              motDePasse == null || motDePasse.isBlank() ||
              confirmer == null || confirmer.isBlank() ||
              telephone == null || telephone.isBlank() ||
              adresse == null || adresse.isBlank()) {
   
              throw new IllegalArgumentException("Tous les champs sont obligatoires");
          }

          //Verifier le Format téléphone
          if (!telephone.matches("\\d{10}")) {
              throw new IllegalArgumentException(
                      "Le numéro de téléphone doit contenir exactement 10 chiffres");
          }
            //verifier si le mot de passe egale a mot de passe de confirmation 
          // 3. Confirmation du mot de passe
          if (!motDePasse.equals(confirmer)) {
              throw new IllegalArgumentException("Les mots de passe ne correspondent pas");
          }
   
          // 4. Complexité du mot de passe
          boolean regle8car   = motDePasse.length() >= 8;
          boolean regleLettre = motDePasse.matches(".*[a-zA-Z].*");
          boolean regleChiffre = motDePasse.matches(".*[0-9].*");
          boolean regleSymbole = motDePasse.matches(".*[^a-zA-Z0-9].*");
   
          if (!regle8car || !regleLettre || !regleChiffre || !regleSymbole) {
              throw new IllegalArgumentException(
                      "Mot de passe invalide : 8 caractères, lettre, chiffre et symbole requis");
          }
   
          // 5. Unicité de l'e-mail
          if (utilisateurDAO.findByEmail(email) != null) {
              throw new IllegalArgumentException("Cet email existe déjà");
          }
   
          // 6. Création
          Utilisateur user = new Utilisateur();
          user.setNom(nom);
          user.setEmail(email);
          user.setMotDePasse(PasswordUtil.hashPassword(motDePasse));
          user.setTelephone(telephone);
          user.setAdresse(adresse);
          user.setRole(Role.CLIENT);
          user.setDateCreation(LocalDateTime.now());
   
          utilisateurDAO.save(user);
           
          
    }

    // ── Authentification ───────────────────────────────────────────────────────

    public Utilisateur authentifier(String email, String motDePasse) {
        if (email == null || motDePasse == null) {
            return null;
        }
        Utilisateur user = utilisateurDAO.findByEmail(email);
        if (user != null && PasswordUtil.checkPassword(motDePasse, user.getMotDePasse())) {
            return user;
        }
        return null;
    }

    // ── Profil ─────────────────────────────────────────────────────────────────
    //modifier le profile 
    public void mettreAJourProfil(Utilisateur user, String nom, String email, String adresse , String tel) {
        if (user == null) {
            throw new IllegalArgumentException("Utilisateur introuvable");
        }
        if (nom == null || nom.isBlank() || email == null || email.isBlank()
                || tel == null || tel.isBlank() || adresse == null || adresse.isBlank()) {
            throw new IllegalArgumentException("Toute les champs sont obligatoires");
        }
        if (!tel.matches("\\d{10}")) {
            throw new IllegalArgumentException("Le numero de telephone doit contenir exactement 10 chiffres");
        }
        user.setNom(nom);
        user.setEmail(email);
        user.setAdresse(adresse);
        user.setTelephone(tel);
        utilisateurDAO.update(user);
    }

    public List<Utilisateur> findAllUtilisateurs() {
        return utilisateurDAO.findAll();
    }

    public void toggleRole(String email) {
        if (email == null || email.isBlank()) {
            throw new IllegalArgumentException("Email utilisateur manquant");
        }

        Utilisateur user = utilisateurDAO.findByEmail(email);
        if (user == null) {
            throw new IllegalArgumentException("Utilisateur introuvable");
        }

        user.setRole(user.getRole() == Role.ADMIN ? Role.CLIENT : Role.ADMIN);
        utilisateurDAO.update(user);
    }
}
