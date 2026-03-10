<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Catalogue - MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body>
            <jsp:include page="includes/navbar.jsp" />

            <!-- Hero Banner -->
            <section class="catalogue-hero">
                <div class="container">
                    <div class="hero-inner">
                        <div>
                            <div class="hero-badge"><i class="fas fa-star me-1"></i> Nouveautés disponibles</div>
                            <h1 class="hero-title">Découvrez notre<br><span class="gradient-text">catalogue
                                    complet</span></h1>
                            <p class="hero-sub">Des milliers de produits sélectionnés pour vous, livrés rapidement.</p>
                        </div>
                        <div class="hero-stats">
                            <div class="hero-stat">
                                <div class="hs-value">${totalCount}</div>
                                <div class="hs-label">Produits</div>
                            </div>
                            <div class="hero-stat-sep"></div>
                            <div class="hero-stat">
                                <div class="hs-value">${categories.size()}</div>
                                <div class="hs-label">Catégories</div>
                            </div>
                            <div class="hero-stat-sep"></div>
                            <div class="hero-stat">
                                <div class="hs-value">48h</div>
                                <div class="hs-label">Livraison</div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <div class="container py-5">
                <div class="row g-4">

                    <!-- Sidebar -->
                    <div class="col-lg-3">
                        <div class="filter-card" style="position:sticky;top:85px;">
                            <div class="filter-section">
                                <div class="filter-title"><i class="fas fa-layer-group me-2"
                                        style="color:var(--accent);"></i>Catégories</div>
                                <div class="cat-list">
                                    <a href="catalogue" class="cat-item ${empty param.cid ? 'cat-active' : ''}">
                                        <span>Toutes les catégories</span>
                                        <span class="cat-count">${totalCount}</span>
                                    </a>
                                    <c:forEach var="cat" items="${categories}">
                                        <a href="catalogue?cid=${cat.id}${not empty param.search ? '&search='.concat(param.search) : ''}"
                                            class="cat-item ${param.cid == cat.id ? 'cat-active' : ''}">
                                            <span>${cat.nom}</span>
                                            <span class="cat-count">${categoryCounts[cat.id]}</span>
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="filter-divider"></div>
                            <div class="filter-section">
                                <div class="filter-title"><i class="fas fa-sort-amount-down me-2"
                                        style="color:var(--accent);"></i>Trier par</div>
                                <select class="sort-select"
                                    onchange="window.location.href='catalogue?cid=${param.cid}&search=${param.search}&sort=' + this.value">
                                    <option value="newest" ${param.sort=='newest' ? 'selected' : '' }>⭐ Plus récents
                                    </option>
                                    <option value="price_asc" ${param.sort=='price_asc' ? 'selected' : '' }>↑ Prix
                                        croissant</option>
                                    <option value="price_desc" ${param.sort=='price_desc' ? 'selected' : '' }>↓ Prix
                                        décroissant</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Product Grid -->
                    <div class="col-lg-9">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div>
                                <h2 class="section-heading">
                                    <c:choose>
                                        <c:when test="${not empty param.search}">Résultats pour
                                            «&nbsp;${param.search}&nbsp;»</c:when>
                                        <c:otherwise>Nos Produits</c:otherwise>
                                    </c:choose>
                                </h2>
                                <div class="results-count">${listeProduits.size()} produits trouvés</div>
                            </div>
                        </div>

                        <div class="row row-cols-1 row-cols-sm-2 row-cols-xl-3 g-4">
                            <c:choose>
                                <c:when test="${empty listeProduits}">
                                    <div class="col-12">
                                        <div class="empty-state">
                                            <div class="empty-icon"><i class="fas fa-search"></i></div>
                                            <h4>Aucun produit trouvé</h4>
                                            <p>Modifiez vos filtres ou cherchez un autre terme.</p>
                                            <a href="catalogue" class="btn-accent mt-3">Voir tout le catalogue</a>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="produit" items="${listeProduits}">
                                        <div class="col fade-in">
                                            <div class="product-card-shop">
                                                <div class="product-img-wrap">
                                                    <c:set var="imgSrc"
                                                        value="${not empty produit.imageUrl ? produit.imageUrl : 'https://placehold.co/400x400/f3f4f6/94a3b8?text=IMG'}" />
                                                    <a href="produit-detail?id=${produit.id}">
                                                        <img src="${imgSrc}" class="product-img-shop"
                                                            alt="${produit.nom}"
                                                            onerror="this.src='https://placehold.co/400x400/f3f4f6/94a3b8?text=IMG'">
                                                    </a>
                                                    <c:if test="${produit.stock == 0}">
                                                        <div class="product-badge-wrap"><span
                                                                class="product-badge badge-rupture">Rupture</span></div>
                                                    </c:if>
                                                    <c:if test="${produit.stock > 0 && produit.stock < 10}">
                                                        <div class="product-badge-wrap"><span
                                                                class="product-badge badge-limited">Stock limité</span>
                                                        </div>
                                                    </c:if>
                                                </div>
                                                <div class="product-body">
                                                    <span class="product-cat-tag">${produit.categorie.nom}</span>
                                                    <h3 class="product-name">
                                                        <a href="produit-detail?id=${produit.id}"
                                                            class="product-name-link">
                                                            <c:out value="${produit.nom}" />
                                                        </a>
                                                    </h3>
                                                    <p class="product-desc">
                                                        <c:out value="${produit.description}" />
                                                    </p>
                                                    <div class="product-footer">
                                                        <span class="product-price">${produit.prix}
                                                            <small>MAD</small></span>
                                                        <c:choose>
                                                            <c:when test="${produit.stock > 0}">
                                                                <form action="ajouter-panier" method="POST">
                                                                    <input type="hidden" name="idProduit"
                                                                        value="${produit.id}">
                                                                    <button type="submit" class="add-cart-btn"
                                                                        title="Ajouter au panier">
                                                                        <i class="fas fa-cart-plus"></i>
                                                                    </button>
                                                                </form>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button class="add-cart-btn disabled-cart" disabled><i
                                                                        class="fas fa-ban"></i></button>
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
                </div>
            </div>

            <jsp:include page="includes/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>

        <style>
            /* Hero */
            .catalogue-hero {
                background: linear-gradient(135deg, #0f0c29 0%, #302b63 60%, #1e1b4b 100%);
                padding: 52px 0 48px;
                position: relative;
                overflow: hidden;
            }

            .catalogue-hero::before {
                content: '';
                position: absolute;
                inset: 0;
                background: radial-gradient(ellipse at 70% 50%, rgba(124, 58, 237, 0.3), transparent 60%);
            }

            .hero-inner {
                position: relative;
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 32px;
                flex-wrap: wrap;
            }

            .hero-badge {
                display: inline-flex;
                align-items: center;
                background: rgba(124, 58, 237, 0.3);
                border: 1px solid rgba(124, 58, 237, 0.5);
                color: #c4b5fd;
                border-radius: 20px;
                padding: 6px 16px;
                font-size: 0.78rem;
                font-weight: 600;
                margin-bottom: 16px;
            }

            .hero-title {
                font-size: 2.4rem;
                font-weight: 800;
                color: white;
                line-height: 1.2;
                margin: 0 0 12px;
            }

            .gradient-text {
                background: linear-gradient(90deg, #a78bfa, #06b6d4);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .hero-sub {
                color: rgba(255, 255, 255, 0.55);
                font-size: 1rem;
                margin: 0;
            }

            .hero-stats {
                display: flex;
                align-items: center;
                gap: 24px;
                background: rgba(255, 255, 255, 0.06);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 16px;
                padding: 20px 28px;
            }

            .hero-stat {
                text-align: center;
            }

            .hs-value {
                font-size: 1.8rem;
                font-weight: 800;
                color: white;
            }

            .hs-label {
                font-size: 0.72rem;
                color: rgba(255, 255, 255, 0.4);
                font-weight: 500;
                margin-top: 2px;
            }

            .hero-stat-sep {
                width: 1px;
                height: 40px;
                background: rgba(255, 255, 255, 0.15);
            }

            /* Filter */
            .filter-card {
                background: white;
                border: 1px solid #e2e8f0;
                border-radius: 16px;
                overflow: hidden;
            }

            .filter-section {
                padding: 20px;
            }

            .filter-divider {
                height: 1px;
                background: #f1f5f9;
            }

            .filter-title {
                font-size: 0.82rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.08em;
                color: #334155;
                margin-bottom: 14px;
            }

            .cat-list {
                display: flex;
                flex-direction: column;
                gap: 4px;
            }

            .cat-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 9px 12px;
                border-radius: 10px;
                text-decoration: none;
                font-size: 0.875rem;
                font-weight: 500;
                color: #334155;
                transition: all 0.15s;
            }

            .cat-item:hover {
                background: #f8fafc;
                color: var(--accent);
            }

            .cat-active {
                background: var(--accent-bg) !important;
                color: var(--accent) !important;
                font-weight: 700;
            }

            .cat-count {
                background: #f1f5f9;
                color: #64748b;
                font-size: 0.72rem;
                font-weight: 700;
                padding: 2px 8px;
                border-radius: 10px;
            }

            .cat-active .cat-count {
                background: rgba(124, 58, 237, 0.15);
                color: var(--accent);
            }

            .sort-select {
                width: 100%;
                border: 1.5px solid #e2e8f0;
                border-radius: 10px;
                padding: 10px 14px;
                font-size: 0.875rem;
                color: #334155;
                background: white;
                outline: none;
                transition: border-color 0.2s;
                cursor: pointer;
            }

            .sort-select:focus {
                border-color: var(--accent);
            }

            /* Products */
            .section-heading {
                font-size: 1.4rem;
                font-weight: 800;
                color: #0f172a;
                margin: 0 0 2px;
            }

            .results-count {
                font-size: 0.82rem;
                color: #94a3b8;
            }

            .product-card-shop {
                background: white;
                border: 1px solid #e2e8f0;
                border-radius: 16px;
                overflow: hidden;
                transition: all 0.3s;
                height: 100%;
                display: flex;
                flex-direction: column;
            }

            .product-card-shop:hover {
                transform: translateY(-6px);
                box-shadow: 0 16px 40px rgba(0, 0, 0, 0.1);
                border-color: rgba(124, 58, 237, 0.2);
            }

            .product-img-wrap {
                position: relative;
                background: #f8fafc;
            }

            .product-img-shop {
                width: 100%;
                height: 200px;
                object-fit: contain;
                padding: 16px;
            }

            .product-badge-wrap {
                position: absolute;
                top: 10px;
                left: 10px;
            }

            .product-badge {
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 0.7rem;
                font-weight: 700;
            }

            .badge-rupture {
                background: #fee2e2;
                color: #dc2626;
            }

            .badge-limited {
                background: #fef3c7;
                color: #92400e;
            }

            .product-body {
                padding: 16px;
                flex: 1;
                display: flex;
                flex-direction: column;
            }

            .product-cat-tag {
                background: #f1f5f9;
                color: #64748b;
                font-size: 0.7rem;
                font-weight: 700;
                padding: 3px 10px;
                border-radius: 10px;
                text-transform: uppercase;
                letter-spacing: 0.04em;
            }

            .product-name {
                font-size: 0.92rem;
                font-weight: 700;
                color: #0f172a;
                margin: 10px 0 6px;
                line-height: 1.35;
            }

            .product-name-link {
                text-decoration: none;
                color: inherit;
            }

            .product-name-link:hover {
                color: var(--accent);
            }

            .product-desc {
                font-size: 0.8rem;
                color: #94a3b8;
                line-height: 1.5;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                margin: 0 0 12px;
                flex: 1;
            }

            .product-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: auto;
            }

            .product-price {
                font-size: 1.15rem;
                font-weight: 800;
                color: var(--accent);
            }

            .product-price small {
                font-size: 0.7rem;
                font-weight: 500;
            }

            .add-cart-btn {
                width: 38px;
                height: 38px;
                background: linear-gradient(135deg, var(--accent), #a855f7);
                color: white;
                border: none;
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.2s;
                box-shadow: 0 4px 12px rgba(124, 58, 237, 0.3);
            }

            .add-cart-btn:hover {
                transform: scale(1.1);
                box-shadow: 0 6px 16px rgba(124, 58, 237, 0.5);
            }

            .disabled-cart {
                background: #e2e8f0 !important;
                box-shadow: none !important;
                color: #94a3b8 !important;
                cursor: not-allowed !important;
            }

            .empty-state {
                text-align: center;
                padding: 64px 32px;
                background: white;
                border-radius: 20px;
                border: 1.5px dashed #e2e8f0;
            }

            .empty-icon {
                font-size: 56px;
                color: #e2e8f0;
                margin-bottom: 16px;
            }

            .empty-state h4 {
                font-weight: 700;
                color: #334155;
                margin-bottom: 8px;
            }

            .empty-state p {
                color: #94a3b8;
            }
        </style>