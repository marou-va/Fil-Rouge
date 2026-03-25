package com.ecommerce.controller;

import com.ecommerce.model.Produit;
import com.ecommerce.service.ProduitService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class CatalogueServletTest {

    @Mock
    private ProduitService produitService;

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private RequestDispatcher dispatcher;

    @InjectMocks
    private CatalogueServlet servlet;

    @BeforeEach
    void setUp() {
        servlet = new CatalogueServlet();
        // Use reflection to inject the mocked ProduitService since it's initialized in init() natively
        try {
            java.lang.reflect.Field field = CatalogueServlet.class.getDeclaredField("produitService");
            field.setAccessible(true);
            field.set(servlet, produitService);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    void testDoGetWithPaginationAndFilters() throws Exception {
        when(request.getParameter("page")).thenReturn("2");
        when(request.getParameter("minPrice")).thenReturn("50");
        when(request.getParameter("maxPrice")).thenReturn("150");
        when(request.getParameter("search")).thenReturn("laptop");
        when(request.getParameter("cid")).thenReturn("1");
        when(request.getParameter("sort")).thenReturn("price_asc");

        List<Produit> mockList = new ArrayList<>();
        when(produitService.getProduits("laptop", 1L, "price_asc", 50.0, 150.0, 12, 12)).thenReturn(mockList);
        when(produitService.countTotalProduits("laptop", 1L, 50.0, 150.0)).thenReturn(30L);
        when(produitService.getCategories()).thenReturn(new ArrayList<>());
        when(produitService.getCategoryCounts(any())).thenReturn(new HashMap<>());
        when(produitService.getTotalCount()).thenReturn(50L);
        
        when(request.getRequestDispatcher("/WEB-INF/vues/catalogue.jsp")).thenReturn(dispatcher);

        servlet.doGet(request, response);

        verify(request).setAttribute("listeProduits", mockList);
        verify(request).setAttribute("currentPage", 2);
        verify(request).setAttribute("totalPages", 3);
        verify(request).setAttribute("minPrice", 50.0);
        verify(request).setAttribute("maxPrice", 150.0);
        verify(dispatcher).forward(request, response);
    }
}
