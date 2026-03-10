<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${produit.nom} - MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                .product-detail-img {
                    width: 100%;
                    height: 380px;
                    object-fit: contain;
                    border-radius: 16px;
                    background: #f8fafc;
                    padding: 24px;
                }

                .img-container {
                    background: #f8fafc;
                    border-radius: 20px;
                    border: 1px solid #e2e8f0;
                    overflow: hidden;
                }

                .breadcrumb-shop a {
                    color: var(--accent);
                    text-decoration: none;
                    font-weight: 500;
                    font-size: 0.875rem;
                }

                .breadcrumb-shop .bc-sep {
                    color: #94a3b8;
                    margin: 0 8px;
                }

                .breadcrumb-shop .bc-current {
                    color: #94a3b8;
                    font-size: 0.875rem;
                }

                .product-detail-name {
                    font-size: 1.9rem;
                    font-weight: 800;
                    color: #0f172a;
                    margin-bottom: 12px;
                    line-height: 1.25;
                }

                .stock-in {
                    display: inline-flex;
                    align-items: center;
                    gap: 6px;
                    background: #f0fdf4;
                    color: #16a34a;
                    border: 1px solid #bbf7d0;
                    border-radius: 20px;
                    padding: 6px 14px;
                    font-size: 0.82rem;
                    font-weight: 600;
                }

                .stock-out {
                    display: inline-flex;
                    align-items: center;
                    gap: 6px;
                    background: #fff1f2;
                    color: #dc2626;
                    border: 1px solid #fecaca;
                    border-radius: 20px;
                    padding: 6px 14px;
                    font-size: 0.82rem;
                    font-weight: 600;
                }

                .product-price-detail {
                    font-size: 2.2rem;
                    font-weight: 900;
                    color: var(--accent);
                    margin: 20px 0;
                }

                .product-price-detail small {
                    font-size: 1rem;
                    font-weight: 500;
                    color: #94a3b8;
                }

                .qty-spinner {
                    display: flex;
                    align-items: center;
                    gap: 0;
                    border: 1.5px solid #e2e8f0;
                    border-radius: 10px;
                    overflow: hidden;
                }

                .qty-btn {
                    width: 38px;
                    height: 38px;
                    background: #f8fafc;
                    border: none;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    cursor: pointer;
                    font-size: 16px;
                    color: #334155;
                    transition: all 0.2s;
                    font-weight: 700;
                }

                .qty-btn:hover {
                    background: var(--accent-bg);
                    color: var(--accent);
                }

                .qty-input {
                    width: 52px;
                    height: 38px;
                    border: none;
                    border-left: 1px solid #e2e8f0;
                    border-right: 1px solid #e2e8f0;
                    text-align: center;
                    font-size: 0.95rem;
                    font-weight: 700;
                    color: #0f172a;
                    outline: none;
                }

                .trust-strip {
                    display: flex;
                    gap: 12px;
                    flex-wrap: wrap;
                    margin-top: 24px;
                }

                .trust-item {
                    flex: 1;
                    min-width: 100px;
                    background: #f8fafc;
                    border: 1px solid #e2e8f0;
                    border-radius: 12px;
                    padding: 14px 12px;
                    text-align: center;
                }

                .trust-icon {
                    font-size: 20px;
                    color: var(--accent);
                    margin-bottom: 6px;
                }

                .trust-text {
                    font-size: 0.72rem;
                    font-weight: 700;
                    color: #334155;
                }

                .desc-card {
                    background: white;
                    border: 1px solid #e2e8f0;
                    border-radius: 16px;
                    padding: 28px;
                }

                .desc-card h5 {
                    font-weight: 800;
                    font-size: 1rem;
                    color: #0f172a;
                    margin-bottom: 16px;
                }

                .suggestions-section {
                    margin-top: 60px;
                }

                .suggestions-title {
                    font-size: 1.5rem;
                    font-weight: 800;
                    color: #0f172a;
                    margin-bottom: 24px;
                }

                .sugg-card {
                    background: white;
                    border: 1px solid #e2e8f0;
                    border-radius: 14px;
                    overflow: hidden;
                    text-decoration: none;
                    color: inherit;
                    transition: all 0.3s;
                    display: block;
                }

                .sugg-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 12px 32px rgba(0, 0, 0, 0.1);
                    border-color: rgba(124, 58, 237, 0.2);
                }

                .sugg-img {
                    width: 100%;
                    height: 170px;
                    object-fit: contain;
                    padding: 16px;
                    background: #f8fafc;
                }

                .sugg-body {
                    padding: 14px;
                }

                .sugg-name {
                    font-size: 0.875rem;
                    font-weight: 700;
                    color: #0f172a;
                    margin-bottom: 6px;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .sugg-price {
                    font-size: 0.95rem;
                    font-weight: 800;
                    color: var(--accent);
                }
            </style>
        </head>

        <body>
            <jsp:include page="includes/navbar.jsp" />

            <div class="container py-5">
                <!-- Breadcrumb -->
                <div class="breadcrumb-shop mb-4">
                    <a href="catalogue">Accueil</a>
                    <span class="bc-sep">/</span>
                    <a href="catalogue">Catalogue</a>
                    <span class="bc-sep">/</span>
                    <span class="bc-current">${produit.nom}</span>
                </div>

                <!-- Product Detail -->
                <div class="row g-5 fade-in">
                    <!-- Image -->
                    <div class="col-lg-5">
                        <div class="img-container">
                            <c:set var="imgSrc"
                                value="${not empty produit.imageUrl ? produit.imageUrl : 'https://placehold.co/600x600/f3f4f6/94a3b8?text=IMG'}" />
                            <img src="${imgSrc}" class="product-detail-img" alt="${produit.nom}"
                                onerror="this.src='https://placehold.co/600x600/f3f4f6/94a3b8?text=IMG'">
                        </div>
                    </div>

                    <!-- Info -->
                    <div class="col-lg-7">
                        <span class="product-cat-tag">${produit.categorie.nom}</span>
                        <h1 class="product-detail-name mt-3">${produit.nom}</h1>

                        <c:choose>
                            <c:when test="${produit.stock > 0}">
                                <span class="stock-in"><i class="fas fa-check-circle"></i> En stock — ${produit.stock}
                                    unité(s)</span>
                            </c:when>
                            <c:otherwise>
                                <span class="stock-out"><i class="fas fa-times-circle"></i> Rupture de stock</span>
                            </c:otherwise>
                        </c:choose>

                        <div class="product-price-detail">${produit.prix} <small>MAD</small></div>

                        <form action="panier" method="POST">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="produitId" value="${produit.id}">
                            <c:if test="${produit.stock > 0}">
                                <div class="d-flex align-items-center gap-3 mb-4">
                                    <label class="label-client mb-0">Quantité :</label>
                                    <div class="qty-spinner">
                                        <button type="button" class="qty-btn" onclick="changeQty(-1)">−</button>
                                        <input type="number" id="qty" name="quantite" class="qty-input" value="1"
                                            min="1" max="${produit.stock}" readonly>
                                        <button type="button" class="qty-btn" onclick="changeQty(1)">+</button>
                                    </div>
                                </div>
                                <button type="submit" class="btn-accent w-100 justify-content-center py-3"
                                    style="font-size:1rem;">
                                    <i class="fas fa-cart-plus"></i> Ajouter au panier
                                </button>
                            </c:if>
                            <c:if test="${produit.stock <= 0}">
                                <button type="button" class="btn-accent w-100 justify-content-center py-3"
                                    style="opacity:0.5;cursor:not-allowed;pointer-events:none;">
                                    <i class="fas fa-ban"></i> Produit indisponible
                                </button>
                            </c:if>
                        </form>

                        <div class="trust-strip">
                            <div class="trust-item">
                                <div class="trust-icon"><i class="fas fa-truck"></i></div>
                                <div class="trust-text">Livraison 48h</div>
                            </div>
                            <div class="trust-item">
                                <div class="trust-icon"><i class="fas fa-shield-alt"></i></div>
                                <div class="trust-text">Paiement Sécurisé</div>
                            </div>
                            <div class="trust-item">
                                <div class="trust-icon"><i class="fas fa-undo"></i></div>
                                <div class="trust-text">Retours 15j</div>
                            </div>
                            <div class="trust-item">
                                <div class="trust-icon"><i class="fas fa-headset"></i></div>
                                <div class="trust-text">Support 24/7</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Description -->
                <div class="desc-card mt-5 fade-in delay-1">
                    <h5><i class="fas fa-align-left me-2" style="color:var(--accent);"></i>Description du produit</h5>
                    <p style="color:#475569;line-height:1.8;white-space:pre-wrap;margin:0;">
                        <c:out value="${produit.description}" />
                    </p>
                </div>

                <!-- Suggestions -->
                <c:if test="${not empty suggestions}">
                    <div class="suggestions-section fade-in delay-2">
                        <h3 class="suggestions-title">Produits similaires</h3>
                        <div class="row row-cols-2 row-cols-md-4 g-4">
                            <c:forEach var="item" items="${suggestions}">
                                <div class="col">
                                    <a href="produit-detail?id=${item.id}" class="sugg-card">
                                        <img src="${not empty item.imageUrl ? item.imageUrl : 'https://placehold.co/400x400/f3f4f6/94a3b8?text=IMG'}"
                                            class="sugg-img" alt="${item.nom}">
                                        <div class="sugg-body">
                                            <div class="sugg-name">${item.nom}</div>
                                            <div class="sugg-price">${item.prix} MAD</div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </div>

            <jsp:include page="includes/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                const max = ${ produit.stock };
                function changeQty(delta) {
                    const el = document.getElementById('qty');
                    let val = parseInt(el.value) + delta;
                    if (val < 1) val = 1;
                    if (val > max) val = max;
                    el.value = val;
                }
            </script>
        </body>

        </html>