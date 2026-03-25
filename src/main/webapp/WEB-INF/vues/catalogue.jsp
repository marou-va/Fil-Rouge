<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Catalogue — MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
        </head>

        <body>
            <jsp:include page="includes/navbar.jsp" />

            <!-- Hero -->
            <div class="hero-banner">
                <div class="container text-center">
                    <h1 class="display-5 fw-bold mb-2">Notre Collection</h1>
                    <p class="lead mb-0" style="color:rgba(255,255,255,0.75);">Des produits soigneusement sélectionnés
                        pour vous.</p>
                </div>
            </div>

            <div class="container py-5">
                <div class="row g-4">

                    <!-- Sidebar Filtres -->
                    <div class="col-lg-3">
                        <div class="card-theme p-3 mb-4">
                            <h6 class="fw-bold mb-3 d-flex align-items-center gap-2">
                                <span
                                    style="width:28px;height:28px;background:var(--primary);border-radius:8px;display:flex;align-items:center;justify-content:center;">
                                    <i class="fas fa-layer-group text-white" style="font-size:.75rem;"></i>
                                </span>
                                Catégories
                            </h6>
                            <div class="list-group cat-list">
                                <a href="catalogue"
                                    class="list-group-item list-group-item-action d-flex justify-content-between align-items-center ${empty param.cid ? 'active' : ''}">
                                    <span>Tout voir</span>
                                    <span
                                        class="badge rounded-pill ${empty param.cid ? 'bg-white text-brand' : 'badge-accent'}">${totalCount}</span>
                                </a>
                                <c:forEach var="cat" items="${categories}">
                                    <a href="catalogue?cid=${cat.id}${not empty param.search ? '&search='.concat(param.search) : ''}"
                                        class="list-group-item list-group-item-action d-flex justify-content-between align-items-center ${param.cid == cat.id ? 'active' : ''}">
                                        <span>${cat.nom}</span>
                                        <span
                                            class="badge rounded-pill ${param.cid == cat.id ? 'bg-white text-brand' : 'badge-accent'}">${categoryCounts[cat.id]}</span>
                                    </a>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="card-theme p-3">
                            <h6 class="fw-bold mb-3 d-flex align-items-center gap-2">
                                <span
                                    style="width:28px;height:28px;background:var(--accent);border-radius:8px;display:flex;align-items:center;justify-content:center;">
                                    <i class="fas fa-sort text-white" style="font-size:.75rem;"></i>
                                </span>
                                Trier par
                            </h6>
                            <select class="form-select"
                                onchange="window.location.href='catalogue?cid=${param.cid}&search=${param.search}&sort=' + this.value">
                                <option value="newest" ${param.sort=='newest' ? 'selected' : '' }>Plus récents</option>
                                <option value="price_asc" ${param.sort=='price_asc' ? 'selected' : '' }>Prix croissant
                                </option>
                                <option value="price_desc" ${param.sort=='price_desc' ? 'selected' : '' }>Prix
                                    décroissant</option>
                            </select>
                        </div>
                    </div>

                    <!-- Produits -->
                    <div class="col-lg-9">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4 class="fw-bold mb-0">
                                <c:choose>
                                    <c:when test="${not empty param.search}">Résultats pour « ${param.search} »</c:when>
                                    <c:otherwise>Nos Produits</c:otherwise>
                                </c:choose>
                            </h4>
                            <small class="text-muted">${listeProduits.size()} produit(s)</small>
                        </div>

                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
                            <c:choose>
                                <c:when test="${empty listeProduits}">
                                    <div class="col-12 text-center py-5">
                                        <i class="fas fa-box-open fa-4x mb-3" style="color:var(--primary-light);"></i>
                                        <h5 class="text-muted">Aucun produit trouvé.</h5>
                                        <a href="catalogue" class="btn btn-brand mt-3">Voir tout le catalogue</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="produit" items="${listeProduits}">
                                        <div class="col">
                                            <div class="product-card h-100 d-flex flex-column">
                                                <a href="produit-detail?id=${produit.id}" class="text-decoration-none">
                                                    <div class="product-img-wrap">
                                                        <img src="${not empty produit.imageUrl ? produit.imageUrl : 'https://placehold.co/400x400/E9E7E8/A6A58C?text=Image'}"
                                                            alt="${produit.nom}">
                                                    </div>
                                                </a>
                                                <div class="p-3 d-flex flex-column flex-grow-1">
                                                    <span
                                                        class="cat-badge d-inline-block mb-2">${produit.categorie.nom}</span>
                                                    <h6 class="fw-bold mb-1 lh-sm">
                                                        <a href="produit-detail?id=${produit.id}"
                                                            class="text-decoration-none text-dark">
                                                            <c:out value="${produit.nom}" />
                                                        </a>
                                                    </h6>
                                                    <p class="small text-muted truncate-2 mb-3">
                                                        <c:out value="${produit.description}" />
                                                    </p>
                                                    <div
                                                        class="mt-auto d-flex justify-content-between align-items-center">
                                                        <span class="product-price">${produit.prix} MAD</span>
                                                        <c:if test="${produit.stock > 0}">
                                                            <form action="panier-action" method="POST" class="m-0">
															    <input type="hidden" name="action" value="ajouter">
															    
															    <input type="hidden" name="idProduit" value="${produit.id}">
															    <button type="submit" class="btn btn-brand btn-sm rounded-circle p-2" title="Ajouter au panier">
															        <i class="fas fa-cart-plus"></i>
															    </button>
															</form>
                                                        </c:if>
                                                        <c:if test="${produit.stock == 0}">
                                                            <span class="badge"
                                                                style="background:var(--accent-light);color:var(--text-dark);">Épuisé</span>
                                                        </c:if>
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