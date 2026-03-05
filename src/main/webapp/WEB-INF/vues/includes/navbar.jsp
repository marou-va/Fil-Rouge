<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold text-brand" href="catalogue">
            <i class="fas fa-shopping-bag me-2"></i>MaBoutique
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            
            <form action="catalogue" method="GET" class="d-flex mx-auto w-50 my-2 my-lg-0">
                <div class="input-group">
                    <input class="form-control border-end-0 shadow-none" type="search" name="search"
                        value="${param.search}" placeholder="Chercher un produit..." aria-label="Search">
                    <button class="btn btn-brand border-start-0" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>

            <ul class="navbar-nav ms-auto align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.utilisateur}">
                        
                        <li class="nav-item me-3">
                            <a class="nav-link btn btn-outline-light position-relative border-0" href="panier">
                                <i class="fas fa-shopping-cart text-brand fs-5"></i>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-brand">
                                    ${not empty sessionScope.panier ? sessionScope.panier.items.size() : 0}
                                </span>
                            </a>
                        </li>
                        
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-bs-toggle="dropdown">
                                <i class="fas fa-user-circle me-1"></i> ${sessionScope.utilisateur.nom}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="profil"><i class="fas fa-cog me-2"></i>Mon Profil</a></li>
                                <li><a class="dropdown-item" href="commandes"><i class="fas fa-list me-2"></i>Mes Commandes</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="logout"><i class="fas fa-sign-out-alt me-2"></i>Déconnexion</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="login"><i class="fas fa-user me-1"></i> Se connecter</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>