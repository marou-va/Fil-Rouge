<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${produit.nom} - Détails du Produit</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                body {
                    background-color: #f4f5f7;
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                }

                .text-brand {
                    color: #f68b1e !important;
                }

                .bg-brand {
                    background-color: #f68b1e !important;
                }

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

                .product-detail-container {
                    background: #fff;
                    padding: 30px;
                    border-radius: 8px;
                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                }

                .product-img-detail {
                    max-width: 100%;
                    height: auto;
                    border-radius: 8px;
                    border: 1px solid #eee;
                }

                .breadcrumb-item a {
                    color: #555;
                    text-decoration: none;
                }

                .breadcrumb-item a:hover {
                    color: #f68b1e;
                }

                .price-section {
                    font-size: 2rem;
                    color: #f68b1e;
                    font-weight: bold;
                }

                .stock-badge {
                    padding: 5px 15px;
                    border-radius: 20px;
                    font-size: 0.9rem;
                }

                .suggestion-card {
                    transition: transform 0.3s ease, box-shadow 0.3s ease;
                }

                .suggestion-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1) !important;
                }

                .btn-outline-brand {
                    color: #f68b1e;
                    border-color: #f68b1e;
                    font-weight: 600;
                }

                .btn-outline-brand:hover {
                    background-color: #f68b1e;
                    color: white;
                }
            </style>
        </head>

        <body>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
                <div class="container">
                    <a class="navbar-brand fw-bold text-brand" href="catalogue">
                        <i class="fas fa-shopping-bag me-2"></i>MaBoutique
                    </a>
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item"><a class="nav-link" href="catalogue">Retour au Catalogue</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="container my-5">
                <nav aria-label="breadcrumb" class="mb-4">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="catalogue">Accueil</a></li>
                        <li class="breadcrumb-item"><a href="catalogue">Catalogue</a></li>
                        <li class="breadcrumb-item active" aria-current="page">${produit.nom}</li>
                    </ol>
                </nav>

                <div class="product-detail-container">
                    <div class="row">
                        <div class="col-md-5 text-center mb-4">
                            <c:set var="imgSrc"
                                value="${not empty produit.imageUrl ? produit.imageUrl : 'https://placehold.co/600x600/eeeeee/999999?text=Image+Non+Disponible'}" />
                            <img src="${imgSrc}" class="product-img-detail shadow-sm" alt="${produit.nom}">
                        </div>
                        <div class="col-md-7">
                            <h1 class="fw-bold mb-3">${produit.nom}</h1>

                            <div class="mb-3">
                                <c:choose>
                                    <c:when test="${produit.stock > 0}">
                                        <span
                                            class="stock-badge bg-success bg-opacity-10 text-success border border-success">
                                            <i class="fas fa-check-circle me-1"></i> En Stock (${produit.stock}
                                            disponibles)
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span
                                            class="stock-badge bg-danger bg-opacity-10 text-danger border border-danger">
                                            <i class="fas fa-times-circle me-1"></i> Rupture de stock
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="price-section mb-4">
                                ${produit.prix} <small>MAD</small>
                            </div>

                            <hr>

                            <h5 class="fw-bold mb-3">Description du produit</h5>
                            <p class="text-muted mb-4 lead" style="white-space: pre-wrap;">
                                <c:out value="${produit.description}" />
                            </p>

                            <div class="row g-3 align-items-center mb-4">
                                <c:if test="${produit.stock > 0}">
                                    <div class="col-auto">
                                        <label for="quantity" class="form-label mb-0 fw-bold">Quantité :</label>
                                    </div>
                                    <div class="col-auto">
                                        <input type="number" id="quantity" class="form-control" value="1" min="1"
                                            max="${produit.stock}" style="width: 80px;">
                                    </div>
                                    <div class="col">
                                        <button class="btn btn-brand w-100 py-2 fs-5">
                                            <i class="fas fa-cart-plus me-2"></i> Ajouter au panier
                                        </button>
                                    </div>
                                </c:if>
                                <c:if test="${produit.stock <= 0}">
                                    <div class="col">
                                        <button class="btn btn-secondary w-100 py-2 fs-5" disabled>
                                            Produit Indisponible
                                        </button>
                                    </div>
                                </c:if>
                            </div>

                            <div class="d-flex gap-3 mt-4">
                                <div class="text-center p-3 border rounded shadow-sm flex-fill bg-light">
                                    <i class="fas fa-truck text-brand fs-3 mb-2"></i>
                                    <div class="small fw-bold">Livraison Rapide</div>
                                </div>
                                <div class="text-center p-3 border rounded shadow-sm flex-fill bg-light">
                                    <i class="fas fa-shield-alt text-brand fs-3 mb-2"></i>
                                    <div class="small fw-bold">Paiement Sécurisé</div>
                                </div>
                                <div class="text-center p-3 border rounded shadow-sm flex-fill bg-light">
                                    <i class="fas fa-undo text-brand fs-3 mb-2"></i>
                                    <div class="small fw-bold">Retours 15 jours</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Section Suggestions -->
                <c:if test="${not empty suggestions}">
                    <div class="mt-5">
                        <h3 class="fw-bold mb-4">Produits similaires</h3>
                        <div class="row row-cols-1 row-cols-md-4 g-4">
                            <c:forEach var="item" items="${suggestions}">
                                <div class="col">
                                    <div class="card h-100 border-0 shadow-sm suggestion-card">
                                        <c:set var="itemImg"
                                            value="${not empty item.imageUrl ? item.imageUrl : 'https://placehold.co/400x400/eeeeee/999999?text=Image'}" />
                                        <img src="${itemImg}" class="card-img-top p-3" alt="${item.nom}"
                                            style="height: 200px; object-fit: contain;">
                                        <div class="card-body text-center">
                                            <h6 class="card-title fw-bold text-truncate">${item.nom}</h6>
                                            <p class="text-brand fw-bold mb-3">${item.prix} MAD</p>
                                            <a href="produit-detail?id=${item.id}"
                                                class="btn btn-outline-brand btn-sm">Voir l'article</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </div>

            <footer class="bg-dark text-white py-4 mt-5">
                <div class="container text-center">
                    <p class="mb-0">&copy; 2026 MaBoutique - Projet Fil Rouge AQL. Tous droits réservés.</p>
                </div>
            </footer>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>