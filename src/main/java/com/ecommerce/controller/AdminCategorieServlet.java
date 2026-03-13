package com.ecommerce.controller;

import com.ecommerce.dao.CategorieDAO;
import com.ecommerce.model.Categorie;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class AdminCategorieServlet extends HttpServlet {
    private CategorieDAO categorieDAO = new CategorieDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            Long id = Long.parseLong(request.getParameter("id"));
            categorieDAO.delete(id);
            response.sendRedirect("categories");
        } else {
            List<Categorie> categories = categorieDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/vues/admin/categories.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String nom = request.getParameter("nom");
        String description = request.getParameter("description");

        Categorie categorie = new Categorie();
        if (idStr != null && !idStr.isEmpty()) {
            categorie = categorieDAO.getCategorieById(Long.parseLong(idStr));
        }

        categorie.setNom(nom);
        categorie.setDescription(description);

        if (categorie.getId() == null) {
            categorieDAO.save(categorie);
        } else {
            categorieDAO.update(categorie);
        }

        response.sendRedirect("categories");
    }
}
