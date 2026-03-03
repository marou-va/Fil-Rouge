<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

                /* Style des cartes produits */
                .product-card {
                    transition: transform 0.2s, box-shadow 0.2s;
                    border: none;
                    border-radius: 8px;
                }

                .product-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
                }

                .product-img {
                    height: 200px;
                    object-fit: contain;
                    /* Empêche l'image d'être déformée */
                    padding: 10px;
                    background-color: #fff;
                    border-top-left-radius: 8px;
                    border-top-right-radius: 8px;
                }

                /* Tronquer la description sur 2 lignes avec des points de suspension */
                .truncate-text {
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    line-clamp: 2;
                    -webkit-box-orient: vertical;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    height: 3rem;
                }
            </style>
        </head>

        <body>

            <jsp:include page="includes/navbar.jsp" />

            <div class="bg-brand text-white py-4 mb-5 text-center shadow-sm">
                <div class="container">
                    <h1 class="display-5 fw-bold">Grandes Promotions !</h1>
                    <p class="lead mb-0">Découvrez nos meilleures offres sur une large sélection de produits.</p>
                </div>
            </div>

            <div class="container mb-5">
                <div class="row">
                    <!-- Sidebar Filtres -->
                    <div class="col-lg-3 mb-4">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body">
                                <h5 class="fw-bold mb-3"><i class="fas fa-filter text-brand me-2"></i>Catégories</h5>
                                <div class="list-group list-group-flush">
                                    <a href="catalogue"
                                        class="list-group-item list-group-item-action border-0 ${empty param.cid ? 'active bg-brand' : ''}">
                                        Toutes les catégories
                                    </a>
                                    <c:forEach var="cat" items="${categories}">
                                        <a href="catalogue?cid=${cat.id}${not empty param.search ? '&search='.concat(param.search) : ''}"
                                            class="list-group-item list-group-item-action border-0 ${param.cid == cat.id ? 'active bg-brand' : ''}">
                                            ${cat.nom}
                                        </a>
                                    </c:forEach>
                                </div>

                                <hr class="my-4">

                                <h5 class="fw-bold mb-3"><i class="fas fa-sort-amount-down text-brand me-2"></i>Trier
                                    par</h5>
                                <select class="form-select border-0 bg-light"
                                    onchange="window.location.href='catalogue?cid=${param.cid}&search=${param.search}&sort=' + this.value">
                                    <option value="newest" ${param.sort=='newest' ? 'selected' : '' }>Plus récents
                                    </option>
                                    <option value="price_asc" ${param.sort=='price_asc' ? 'selected' : '' }>Prix :
                                        Croissant</option>
                                    <option value="price_desc" ${param.sort=='price_desc' ? 'selected' : '' }>Prix :
                                        Décroissant</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Liste Produits -->
                    <div class="col-lg-9">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h3 class="fw-bold mb-0">
                                <c:choose>
                                    <c:when test="${not empty param.search}">Résultats pour "${param.search}"</c:when>
                                    <c:otherwise>Nos Produits</c:otherwise>
                                </c:choose>
                            </h3>
                            <span class="text-muted">${listeProduits.size()} produits trouvés</span>
                        </div>

                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
                            <c:choose>
                                <c:when test="${empty listeProduits}">
                                    <div class="col-12 text-center py-5">
                                        <i class="fas fa-search fa-4x text-muted mb-3"></i>
                                        <h4 class="text-muted">Aucun produit ne correspond à votre recherche.</h4>
                                        <a href="catalogue" class="btn btn-brand mt-3">Voir tout le catalogue</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="produit" items="${listeProduits}">
                                        <div class="col">
                                            <div class="card h-100 product-card shadow-sm border-0">
                                                <c:set var="imgSrc"
                                                    value="${not empty produit.imageUrl ? produit.imageUrl : 'https://placehold.co/400x400/eeeeee/999999?text=Image'}" />
                                                <a href="produit-detail?id=${produit.id}">
                                                    <img src="${imgSrc}" class="card-img-top product-img"
                                                        alt="${produit.nom}">
                                                </a>
                                                <div class="card-body d-flex flex-column">
                                                    <div class="mb-2">
                                                        <span
                                                            class="badge bg-light text-muted fw-normal">${produit.categorie.nom}</span>
                                                    </div>
                                                    <h6 class="card-title fw-bold mb-1">
                                                        <a href="produit-detail?id=${produit.id}"
                                                            class="text-decoration-none text-dark">
                                                            <c:out value="${produit.nom}" />
                                                        </a>
                                                    </h6>
                                                    <p class="card-text text-muted small truncate-text mb-3">
                                                        <c:out value="${produit.description}" />
                                                    </p>
                                                    <div class="mt-auto">
                                                        <div class="d-flex justify-content-between align-items-center">
                                                            <span class="fs-5 fw-bold text-brand">${produit.prix}
                                                                MAD</span>
                                                            <c:if test="${produit.stock > 0}">
                                                                <button class="btn btn-brand btn-sm rounded-circle p-2"
                                                                    title="Ajouter au panier">
                                                                    <i class="fas fa-cart-plus"></i>
                                                                </button>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="includes/footer.jsp" />

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>