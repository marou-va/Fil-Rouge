package com.ecommerce.controller;

import com.ecommerce.dao.PanierDAO;
import com.ecommerce.dao.UtilisateurDAO;
import com.ecommerce.model.Panier;
import com.ecommerce.model.Utilisateur;
import com.ecommerce.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UtilisateurDAO utilisateurDAO;
	PanierDAO panierDAO = new PanierDAO();

    public void init() {
        utilisateurDAO = new UtilisateurDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/vues/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);

       
        Integer tentatives = (Integer) session.getAttribute("loginTentatives");//compteur de tentatif avec mot de passe incorrecte
        Long blocageDepuis = (Long) session.getAttribute("loginBlocageDepuis");//l instant ou on a lancer le blocage de 30 sec

        if (tentatives == null) tentatives = 0;

        //si on a un blockage 
        if (blocageDepuis != null) {
            long secondesEcoulees = (System.currentTimeMillis() - blocageDepuis) / 1000;//calculer les secondes passer
            if (secondesEcoulees < 30) {
                long resteSecondes = 30 - secondesEcoulees;
                request.setAttribute("error", "Trop de tentatives. Réessayez dans " + resteSecondes + " seconde(s).");
                request.setAttribute("bloque", true);
                request.getRequestDispatcher("/WEB-INF/vues/login.jsp").forward(request, response);
                return;
            } else {//si le temps est terminer
                // Blocage terminé → réinitialiser
                session.removeAttribute("loginTentatives");
                session.removeAttribute("loginBlocageDepuis");
                tentatives = 0;
            }
        }

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Utilisateur user = utilisateurDAO.findByEmail(email);

        if (user != null && PasswordUtil.checkPassword(password, user.getMotDePasse())) {
            // ── Succès : réinitialiser les tentatives ──
            session.invalidate();
            session = request.getSession(true);
            session.setAttribute("utilisateur", user);
            Panier panier = panierDAO.getPanierByUserId(user.getId());
            int size = (panier != null && panier.getItems() != null) ? panier.getItems().size() : 0;
            session.setAttribute("cartSize", size);
            response.sendRedirect("catalogue");

        } else {
            //on incremente  nombre de tentatif
            tentatives++;
            session.setAttribute("loginTentatives", tentatives);

            if (tentatives >= 3) {
                session.setAttribute("loginBlocageDepuis", System.currentTimeMillis());
                request.setAttribute("error", "Trop de tentatives. Réessayez dans 30 seconde(s).");
                request.setAttribute("bloque", true);
            } else {
                int restantes = 3 - tentatives;
                request.setAttribute("error", "Email ou mot de passe incorrect. " + restantes + " tentative(s) restante(s).");
            }

            request.getRequestDispatcher("/WEB-INF/vues/login.jsp").forward(request, response);
        }
    }
}
