package com.ecommerce.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "utilisateur")
public class Utilisateur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nom",nullable = false, length = 100)
    private String nom;

    @Column(name = "email",nullable = false, unique = true, length = 150)
    private String email;

    @Column(name = "mot_de_passe", nullable = false, length = 255)
    private String motDePasse;
      
    

    @Column(name = "adresse", nullable = false, length = 255)
    private String adresse;

    @Column(name = "telephone", nullable = false, length = 20)
    private String telephone;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    @Column(name = "date_creation", updatable = false)
    private LocalDateTime dateCreation;

    // Constructeurs
    public Utilisateur() {}

    public Utilisateur(String nom, String email, String motDePasse, Role role, LocalDateTime date, String tel , String adre) {
        this.nom = nom;
        this.email = email;
        this.motDePasse = motDePasse;
        this.role = role;
        this.dateCreation = date;
        this.adresse=adre;
        this.telephone=tel;
        
    }

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMotDePasse() { return motDePasse; }
    public void setMotDePasse(String motDePasse) { this.motDePasse = motDePasse; }

    
    public String getAdresse() { return adresse; }
    public void setAdresse(String a) { this.adresse = a; }
    public String getTelephone() { return telephone; }
    public void setTelephone(String tel) { this.telephone= tel; }


    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }
   
    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }
}

