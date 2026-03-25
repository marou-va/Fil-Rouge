package com.ecommerce.controller;

import com.ecommerce.model.Categorie;
import com.ecommerce.service.CategorieService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class AdminCategorieServlet extends HttpServlet {
    private CategorieService categorieService;

    @Override
    public void init() {
        categorieService = new CategorieService();
    }

    void setCategorieService(CategorieService categorieService) {
        this.categorieService = categorieService;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            try {
                categorieService.delete(request.getParameter("id"));
            } catch (IllegalArgumentException e) {
                request.getSession().setAttribute("err", e.getMessage());
            }
            response.sendRedirect("categories");
        } else {
            List<Categorie> categories = categorieService.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/vues/admin/categories.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            categorieService.saveOrUpdate(
                    request.getParameter("id"),
                    request.getParameter("nom"),
                    request.getParameter("description"));
            response.sendRedirect("categories");
        } catch (IllegalArgumentException e) {
            request.setAttribute("erreur", e.getMessage());
            request.setAttribute("categories", categorieService.getAllCategories());
            request.getRequestDispatcher("/WEB-INF/vues/admin/categories.jsp").forward(request, response);
        }
    }
}
