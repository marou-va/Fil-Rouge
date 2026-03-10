<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <div class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse min-vh-100 shadow">
            <div class="position-sticky pt-3">
                <div class="text-center mb-4 px-3">
                    <h5 class="text-brand fw-bold mb-0">MaBoutique Admin</h5>
                    <small class="text-white-50 small">Tableau de Bord</small>
                </div>
                <hr class="text-white-50">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link text-white py-3 px-4 ${page == 'dashboard' ? 'active bg-brand text-dark' : 'text-white-50 transition-all text-decoration-none'}"
                            href="${pageContext.request.contextPath}/admin/dashboard">
                            <i class="fas fa-home me-2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white py-3 px-4 ${page == 'produits' ? 'active bg-brand text-dark' : 'text-white-50 transition-all text-decoration-none'}"
                            href="${pageContext.request.contextPath}/admin/produits">
                            <i class="fas fa-box me-2"></i> Produits
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white py-3 px-4 ${page == 'categories' ? 'active bg-brand text-dark' : 'text-white-50 transition-all text-decoration-none'}"
                            href="${pageContext.request.contextPath}/admin/categories">
                            <i class="fas fa-tags me-2"></i> Catégories
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white py-3 px-4 ${page == 'commandes' ? 'active bg-brand text-dark' : 'text-white-50 transition-all text-decoration-none'}"
                            href="${pageContext.request.contextPath}/admin/commandes">
                            <i class="fas fa-shopping-cart me-2"></i> Commandes
                        </a>
                    </li>
                    <li class="nav-item mt-5">
                        <hr class="text-white-50">
                        <a class="nav-link text-white-50 py-3 px-4 transition-all text-decoration-none"
                            href="${pageContext.request.contextPath}/admin-choice">
                            <i class="fas fa-exchange-alt me-2"></i> Changer d'espace
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-danger py-3 px-4 transition-all text-decoration-none font-weight-bold"
                            href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt me-2"></i> Déconnexion
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <style>
            .transition-all {
                transition: all 0.2s ease;
            }

            .nav-link:hover:not(.active) {
                background: rgba(255, 139, 30, 0.1);
                color: #f68b1e !important;
                padding-left: 2rem !important;
            }

            .bg-brand {
                background-color: #f68b1e !important;
            }

            .text-brand {
                color: #f68b1e !important;
            }
        </style>