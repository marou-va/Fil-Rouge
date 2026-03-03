package com.ecommerce.model;

<<<<<<< HEAD

import jakarta.persistence.*;
import java.time.LocalDateTime;


@Entity
@Table(name = "utilisateur")
public class Utilisateur {

=======
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "utilisateur")
public class Utilisateur {
>>>>>>> 65d5a125312f20cf110fbfd30052dfa6f104cad7
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String nom;

<<<<<<< HEAD
    @Column(nullable = false, unique = true, length = 150)//l email doit etre unique 
    private String email;

    @Column(name = "mot_de_passe", nullable = false, length = 255)//le mot de pass est hasher
=======
    @Column(nullable = false, unique = true, length = 150)
    private String email;

    @Column(name = "mot_de_passe", nullable = false)
>>>>>>> 65d5a125312f20cf110fbfd30052dfa6f104cad7
    private String motDePasse;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

<<<<<<< HEAD
    @Column(name = "date_creation", updatable = false)
    private LocalDateTime dateCreation ;

   /* //Relation OneToOne avec Panier
    @OneToOne(mappedBy = "utilisateur", cascade = CascadeType.ALL)//on a choisi de faire cascade pour dire que si on applique qlq chose sur user doit etre appliquer aussi sur le panier 
    private Panier panier;
*/
    //Constructeurs
    public Utilisateur() {}

    public Utilisateur(String nom, String email, String motDePasse, Role role,LocalDateTime date) {
        this.nom = nom;
        this.email = email;
        this.motDePasse = motDePasse;
        this.role = role;
       this.dateCreation=date;
    }

    // 🔹 Getters & Setters
    public Long getId() { return id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMotDePasse() { return motDePasse; }
    public void setMotDePasse(String motDePasse) { this.motDePasse = motDePasse; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }

    public LocalDateTime getDateCreation() { return dateCreation; }

 /*   public Panier getPanier() { return panier; }
    public void setPanier(Panier panier) { this.panier = panier; }*/
}
=======
    @Column(name = "date_creation", insertable = false, updatable = false)
    private LocalDateTime dateCreation;

    public enum Role {
        CLIENT, ADMIN
    }

    public Utilisateur() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public LocalDateTime getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(LocalDateTime dateCreation) {
        this.dateCreation = dateCreation;
    }
}
>>>>>>> 65d5a125312f20cf110fbfd30052dfa6f104cad7
