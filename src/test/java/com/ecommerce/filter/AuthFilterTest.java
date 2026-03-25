package com.ecommerce.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class AuthFilterTest {

    @Mock
    private HttpServletRequest request;
    @Mock
    private HttpServletResponse response;
    @Mock
    private HttpSession session;
    @Mock
    private FilterChain chain;

    private final AuthFilter filter = new AuthFilter();

    @Test
    void testDoFilterPassesWhenLoggedIn() throws Exception {
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("utilisateur")).thenReturn(new Object());

        filter.doFilter(request, response, chain);

        verify(chain).doFilter(request, response);
        verify(response, never()).sendRedirect(anyString());
    }

    @Test
    void testDoFilterRedirectsWhenNotLoggedIn() throws Exception {
        when(request.getSession(false)).thenReturn(null);
        when(request.getContextPath()).thenReturn("/shop");

        filter.doFilter(request, response, chain);

        verify(response).sendRedirect("/shop/login");
        verify(chain, never()).doFilter(request, response);
    }
}
