package com.ecommerce.controller;

<<<<<<< HEAD
import java.io.IOException;
import java.time.LocalDateTime;

import com.ecommerce.dao.UtilisateurDAO;
import com.ecommerce.model.Role;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.util.PasswordUtil;

=======
import com.ecommerce.dao.UtilisateurDAO;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.util.PasswordUtil;
>>>>>>> 65d5a125312f20cf110fbfd30052dfa6f104cad7
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
<<<<<<< HEAD

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	   private UtilisateurDAO userDAO;
	   
	   public void init() {
	       userDAO = new UtilisateurDAO();
	   }
	   protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        request.getRequestDispatcher("/WEB-INF/vues/inscription.jsp").forward(request, response);
	    }

	   
	   @Override
	   protected void doPost(HttpServletRequest request, HttpServletResponse response)
	           throws ServletException, IOException {

	       String action = request.getParameter("action");

	       if ("inscrire".equals(action)) {

	           String nom = request.getParameter("nom");
	           String email = request.getParameter("email");
	           String motDePasse = request.getParameter("motDePasse");
	           String confirmer = request.getParameter("confirmerMDP");

	          //validation des champ
	           if (nom == null || email == null ||
	               motDePasse == null || confirmer == null) {

	               request.setAttribute("erreur", "Tous les champs sont obligatoires");
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

	         //verifier si le mot de passe egale a mot de passe de confirmation 
	           if (!motDePasse.equals(confirmer)) {

	               request.setAttribute("erreur",
	                       "Les mots de passe ne correspondent pas");

	               request.getRequestDispatcher("/WEB-INF/vues/inscription.jsp").forward(request, response);
	               return;
	           }

	        //verifier si l email existe deja 
	         
	           
	            if (userDAO.emailExiste(email)) {
	               request.setAttribute("erreur","Cet email existe déjà");
	               request.getRequestDispatcher("/WEB-INF/vues/inscription.jsp").forward(request,response);
	              return;
	           }

	       
              PasswordUtil hash= new PasswordUtil();
              
	           //hasher le password 
	           String motDePasseHash = hash.hashPassword(motDePasse);
	           LocalDateTime dateActuelle =LocalDateTime.now();;
	            
		        Utilisateur u = new Utilisateur(nom,email,motDePasseHash,Role.CLIENT,dateActuelle);
		        userDAO.ajouter(u);
	           request.setAttribute("succes","Compte créé avec succès !");

	           request.getRequestDispatcher("/WEB-INF/vues/login.jsp")
	                   .forward(request, response);
	       }
	   }
	}
=======
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UtilisateurDAO utilisateurDAO;

    public void init() {
        utilisateurDAO = new UtilisateurDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/vues/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Les mots de passe ne correspondent pas");
            request.getRequestDispatcher("/WEB-INF/vues/register.jsp").forward(request, response);
            return;
        }

        if (utilisateurDAO.findByEmail(email) != null) {
            request.setAttribute("error", "Cet email est déjà utilisé");
            request.getRequestDispatcher("/WEB-INF/vues/register.jsp").forward(request, response);
            return;
        }

        Utilisateur user = new Utilisateur();
        user.setNom(nom);
        user.setEmail(email);
        user.setMotDePasse(PasswordUtil.hashPassword(password));
        user.setRole(Utilisateur.Role.CLIENT);

        utilisateurDAO.save(user);

        response.sendRedirect("login");
    }
}
>>>>>>> 65d5a125312f20cf110fbfd30052dfa6f104cad7
