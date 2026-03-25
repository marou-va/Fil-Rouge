package com.ecommerce.filter;

import com.ecommerce.model.Role;
import com.ecommerce.model.Utilisateur;
import jakarta.servlet.FilterChain;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class AdminFilterTest {

    @Mock
    private HttpServletRequest request;
    @Mock
    private HttpServletResponse response;
    @Mock
    private HttpSession session;
    @Mock
    private FilterChain chain;

    private final AdminFilter filter = new AdminFilter();

    @Test
    void testDoFilterPassesForAdmin() throws Exception {
        Utilisateur admin = new Utilisateur();
        admin.setRole(Role.ADMIN);

        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("utilisateur")).thenReturn(admin);

        filter.doFilter(request, response, chain);

        verify(chain).doFilter(request, response);
    }

    @Test
    void testDoFilterRedirectsClientToCatalogue() throws Exception {
        Utilisateur client = new Utilisateur();
        client.setRole(Role.CLIENT);

        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("utilisateur")).thenReturn(client);
        when(request.getContextPath()).thenReturn("/shop");

        filter.doFilter(request, response, chain);

        verify(response).sendRedirect("/shop/catalogue");
        verify(chain, never()).doFilter(request, response);
    }

    @Test
    void testDoFilterRedirectsAnonymousToLogin() throws Exception {
        when(request.getSession(false)).thenReturn(null);
        when(request.getContextPath()).thenReturn("/shop");

        filter.doFilter(request, response, chain);

        verify(response).sendRedirect("/shop/login");
        verify(chain, never()).doFilter(request, response);
    }
}
