<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Boutique E-commerce</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background-color: #f4f5f7;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        /* Couleur principale style Jumia (Orange) */
        .text-brand { color: #f68b1e !important; }
        .bg-brand { background-color: #f68b1e !important; }
        .btn-brand { 
            background-color: #f68b1e; 
            color: white; 
            border: none; 
            font-weight: bold;
        }
        .btn-brand:hover {
            background-color: #e57a10;
            color: white;
        }
        /* Style des cartes produits */
        .product-card {
            transition: transform 0.2s, box-shadow 0.2s;
            border: none;
            border-radius: 8px;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
        }
        .product-img {
            height: 200px;
            object-fit: contain; /* Empêche l'image d'être déformée */
            padding: 10px;
            background-color: #fff;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }
        /* Tronquer la description sur 2 lignes avec des points de suspension */
        .truncate-text {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            height: 3rem;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold text-brand" href="catalogue">
                <i class="fas fa-shopping-bag me-2"></i>MaBoutique
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <form class="d-flex mx-auto w-50 my-2 my-lg-0">
                    <input class="form-control me-2" type="search" placeholder="Chercher un produit, une marque...">
                    <button class="btn btn-brand" type="submit"><i class="fas fa-search"></i></button>
                </form>
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-user me-1"></i> Se connecter</a>
                    </li>
                    <li class="nav-item ms-3">
                        <a class="nav-link btn btn-outline-light position-relative border-0" href="#">
                            <i class="fas fa-shopping-cart text-brand fs-5"></i>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-brand">
                                0
                            </span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="bg-brand text-white py-4 mb-5 text-center shadow-sm">
        <div class="container">
            <h1 class="display-5 fw-bold">Grandes Promotions !</h1>
            <p class="lead mb-0">Découvrez nos meilleures offres sur une large sélection de produits.</p>
        </div>
    </div>

    <div class="container mb-5">
        <div class="row mb-4">
            <div class="col">
                <h3 class="fw-bold border-bottom pb-2">Nos Produits Populaires</h3>
            </div>
        </div>

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
            
            <c:choose>
                <c:when test="${empty listeProduits}">
                    <div class="col-12 text-center py-5">
                        <i class="fas fa-box-open fa-4x text-muted mb-3"></i>
                        <h4 class="text-muted">Aucun produit n'est disponible pour le moment.</h4>
                    </div>
                </c:when>
                
                <c:otherwise>
                    <c:forEach var="produit" items="${listeProduits}">
                        <div class="col">
                            <div class="card h-100 product-card shadow-sm">
                                
                                <c:set var="imgSrc" value="${not empty produit.imageUrl ? produit.imageUrl : 'https://placehold.co/400x400/eeeeee/999999?text=Image+Non+Disponible'}" />
                                <img src="${imgSrc}" class="card-img-top product-img" alt="${produit.nom}">
                                
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title fw-bold text-dark mb-1"><c:out value="${produit.nom}" /></h5>
                                    
                                    <p class="card-text text-muted small truncate-text mb-3">
                                        <c:out value="${produit.description}" />
                                    </p>
                                    
                                    <div class="mt-auto">
                                        <h4 class="text-brand fw-bold mb-2"><c:out value="${produit.prix}" /> MAD</h4>
                                        
                                        <c:choose>
                                            <c:when test="${produit.stock > 0}">
                                                <div class="d-flex justify-content-between align-items-center mb-3">
                                                    <span class="badge bg-success bg-opacity-10 text-success border border-success">
                                                        <i class="fas fa-check-circle me-1"></i> En stock
                                                    </span>
                                                </div>
                                                <button class="btn btn-brand w-100 shadow-sm">
                                                    <i class="fas fa-cart-plus me-1"></i> Ajouter au panier
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="d-flex justify-content-between align-items-center mb-3">
                                                    <span class="badge bg-danger bg-opacity-10 text-danger border border-danger">
                                                        <i class="fas fa-times-circle me-1"></i> Rupture
                                                    </span>
                                                </div>
                                                <button class="btn btn-secondary w-100" disabled>
                                                    Indisponible
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            
        </div>
    </div>

    <footer class="bg-dark text-white py-4 mt-auto">
        <div class="container text-center">
            <p class="mb-0">&copy; 2026 MaBoutique - Projet Fil Rouge AQL. Tous droits réservés.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>