<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <nav class="navbar navbar-expand-lg navbar-theme sticky-top">
            <div class="container">
                <a class="navbar-brand d-flex align-items-center gap-2" href="catalogue">
                    <i class="fas fa-leaf"></i> MaBoutique
                </a>
                <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">

                    <form action="catalogue" method="GET" class="d-flex mx-auto my-2 my-lg-0" style="width:46%">
                        <div class="input-group">
                            <input class="form-control shadow-none" type="search" name="search" value="${param.search}"
                                placeholder="Rechercher un produit…" aria-label="Search">
                            <button class="btn btn-brand px-3" type="submit">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </form>

                    <ul class="navbar-nav ms-auto align-items-center gap-1">
                        <c:choose>
                            <c:when test="${not empty sessionScope.utilisateur}">

                                <li class="nav-item">
                                    <a class="nav-link position-relative" href="panier">
                                        <i class="fas fa-shopping-bag fs-5"></i>
                                        <span
                                            class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-accent"
                                            style="font-size:.65rem;">
                                            ${not empty sessionScope.cartSize ? sessionScope.cartSize : 0}
                                        </span>
                                    </a>
                                </li>

                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" href="#"
                                        id="userDropdown" role="button" data-bs-toggle="dropdown">
                                        <span
                                            class="rounded-circle d-inline-flex align-items-center justify-content-center fw-bold text-white"
                                            style="width:32px;height:32px;background:var(--primary);font-size:.85rem;">
                                            ${sessionScope.utilisateur.nom.substring(0,1).toUpperCase()}
                                        </span>
                                        <span class="d-none d-lg-inline">${sessionScope.utilisateur.nom}</span>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end border-0 shadow"
                                        style="min-width:200px;">
                                        <c:if test="${sessionScope.utilisateur.role == 'ADMIN'}">
                                            <li>
                                                <a class="dropdown-item fw-bold" href="admin-choice"
                                                    style="color:var(--primary-dark);">
                                                    <i class="fas fa-user-shield me-2"
                                                        style="color:var(--primary);"></i>Administration
                                                </a>
                                            </li>
                                            <li>
                                                <hr class="dropdown-divider">
                                            </li>
                                        </c:if>
                                        <li><a class="dropdown-item" href="profil"><i
                                                    class="fas fa-user-circle me-2 text-muted"></i>Mon Profil</a></li>
                                        <li><a class="dropdown-item" href="historique"><i
                                                    class="fas fa-receipt me-2 text-muted"></i>Mes Commandes</a></li>
                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>
                                        <li><a class="dropdown-item text-danger" href="logout"><i
                                                    class="fas fa-sign-out-alt me-2"></i>Déconnexion</a></li>
                                    </ul>
                                </li>

                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="btn btn-outline-brand btn-sm px-3" href="login">
                                        <i class="fas fa-sign-in-alt me-1"></i> Connexion
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="btn btn-brand btn-sm px-3" href="register">
                                        <i class="fas fa-user-plus me-1"></i> S'inscrire
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>