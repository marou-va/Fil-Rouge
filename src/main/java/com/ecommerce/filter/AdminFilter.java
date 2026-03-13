package com.ecommerce.filter;

import com.ecommerce.model.Role;
import com.ecommerce.model.Utilisateur;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = { "/admin/*", "/admin-choice" })
public class AdminFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        Utilisateur user = (session != null) ? (Utilisateur) session.getAttribute("utilisateur") : null;

        if (user != null && user.getRole() == Role.ADMIN) {
            chain.doFilter(request, response);
        } else {
            // Si pas admin, on redirige vers le catalogue ou login
            if (user == null) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            } else {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/catalogue");
            }
        }
    }

    public void destroy() {
    }
}
