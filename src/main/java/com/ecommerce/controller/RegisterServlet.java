package com.ecommerce.controller;
import java.io.IOException;
import java.time.LocalDateTime;

import com.ecommerce.dao.UtilisateurDAO;
import com.ecommerce.model.Role;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UtilisateurDAO utilisateurDAO;

    public void init() {
        utilisateurDAO = new UtilisateurDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/vues/inscription.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("inscrire".equals(action)) {

            String nom = request.getParameter("nom");
            String email = request.getParameter("email");
            String motDePasse = request.getParameter("motDePasse");
            String confirmer = request.getParameter("confirmerMDP");
            String telephone = request.getParameter("telephone");
            String adresse   = request.getParameter("adresse");

           //validation des champ
            if (nom == null || email == null ||
                motDePasse == null || confirmer == null|| telephone==null || adresse ==null) {

                request.setAttribute("erreur", "Tous les champs sont obligatoires");
                request.getRequestDispatcher("/WEB-INF/vues/inscription.jsp").forward(request, response);
                return;
            }
         // Vérification du téléphone (10 chiffres uniquement)
            if (telephone == null || !telephone.matches("\\d{10}")) {
                request.setAttribute("erreur", "Le numéro de téléphone doit contenir exactement 10 chiffres");
                request.getRequestDispatcher("/WEB-INF/vues/inscription.jsp").forward(request, response);
                return;
            }
          //verifier si le mot de passe egale a mot de passe de confirmation 
            if (!motDePasse.equals(confirmer)) {

                request.setAttribute("erreur",
                        "Les mots de passe ne correspondent pas");

                request.getRequestDispatcher("/WEB-INF/vues/inscription.jsp").forward(request, response);
                return;
            }
 //verification de validation de mot de passe 
            boolean regle8car = motDePasse.length() >= 8;
            boolean regleLettre = motDePasse.matches(".*[a-zA-Z].*");
            boolean regleChiffre = motDePasse.matches(".*[0-9].*");
            boolean regleSymbole = motDePasse.matches(".*[^a-zA-Z0-9].*");

            if (!regle8car || !regleLettre || !regleChiffre || !regleSymbole) {

                request.setAttribute("erreur",
                        "Mot de passe invalide : 8 caractères, lettre, chiffre et symbole requis");


                request.getRequestDispatcher("/WEB-INF/vues/inscription.jsp").forward(request, response);
                return;
            }

          
        
         //verifier si l email existe deja 
          
            
             if (utilisateurDAO.findByEmail(email) != null) {
                request.setAttribute("erreur","Cet email existe déjà");
                request.getRequestDispatcher("/WEB-INF/vues/inscription.jsp").forward(request,response);
               return;
            }

        

             Utilisateur user = new Utilisateur();
             user.setNom(nom);
             user.setEmail(email);
             user.setDateCreation(LocalDateTime.now());
             user.setMotDePasse(PasswordUtil.hashPassword(motDePasse));
             user.setRole(Role.CLIENT);
             user.setTelephone(telephone);
             user.setAdresse(adresse);
             utilisateurDAO.save(user);

             response.sendRedirect("login");
             
         
        }
    }
}

