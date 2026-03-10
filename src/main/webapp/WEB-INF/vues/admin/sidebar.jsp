<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <div class="col-auto admin-sidebar p-0 d-flex flex-column" style="width:230px;min-width:230px;">
            <div class="px-3 py-4 text-center border-bottom" style="border-color:rgba(255,255,255,0.10)!important;">
                <div class="sidebar-brand">
                    <i class="fas fa-leaf me-1" style="color:var(--primary);"></i>MaBoutique
                </div>
                <small class="sidebar-brand d-block mt-1">Panneau Admin</small>
            </div>

            <nav class="nav flex-column py-3 flex-grow-1">
                <a class="nav-link ${page == 'dashboard'    ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-home"></i> Dashboard
                </a>
                <a class="nav-link ${page == 'produits'     ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/admin/produits">
                    <i class="fas fa-box-open"></i> Produits
                </a>
                <a class="nav-link ${page == 'categories'   ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/admin/categories">
                    <i class="fas fa-tags"></i> Catégories
                </a>
                <a class="nav-link ${page == 'utilisateurs' ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/admin/utilisateurs">
                    <i class="fas fa-users"></i> Utilisateurs
                </a>
                <a class="nav-link ${page == 'commandes'    ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/admin/commandes">
                    <i class="fas fa-receipt"></i> Commandes
                </a>

                <div class="mt-auto px-2 py-3 border-top" style="border-color:rgba(255,255,255,0.10)!important;">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin-choice">
                        <i class="fas fa-exchange-alt"></i> Changer d'espace
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/logout"
                        style="color:#CCAEA1!important;">
                        <i class="fas fa-sign-out-alt"></i> Déconnexion
                    </a>
                </div>
            </nav>
        </div>