<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${produit.nom} — MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
            <style>
                .product-hero-card {
                    background: #fff;
                    border-radius: var(--radius-lg);
                    overflow: hidden;
                    box-shadow: var(--shadow-md);
                }

                .detail-img-wrap {
                    background: #faf9f8;
                    height: 100%;
                    min-height: 400px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 2rem;
                }

                .detail-img-wrap img {
                    max-width: 100%;
                    max-height: 500px;
                    object-fit: contain;
                    transition: var(--transition);
                }

                .breadcrumb-theme .breadcrumb-item a {
                    color: var(--primary);
                    text-decoration: none;
                    font-weight: 600;
                }

                .feature-box {
                    background: var(--bg);
                    border-radius: var(--radius);
                    padding: 1rem;
                    text-align: center;
                    flex: 1;
                    border: 1px solid var(--border-color);
                }

                .feature-box i {
                    color: var(--primary);
                    font-size: 1.5rem;
                    margin-bottom: 0.5rem;
                }
            </style>
        </head>

        <body>
            <jsp:include page="includes/navbar.jsp" />

            <div class="container py-5">
                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb" class="mb-4 breadcrumb-theme">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="catalogue">Accueil</a></li>
                        <li class="breadcrumb-item"><a
                                href="catalogue?cid=${produit.categorie.id}">${produit.categorie.nom}</a></li>
                        <li class="breadcrumb-item active">${produit.nom}</li>
                    </ol>
                </nav>

                <div class="product-hero-card">
                    <div class="row g-0">
                        <!-- Image -->
                        <div class="col-lg-6">
                            <div class="detail-img-wrap">
                                <img src="${not empty produit.imageUrl ? produit.imageUrl : 'https://placehold.co/600x600/E9E7E8/A6A58C?text=Image'}"
                                    alt="${produit.nom}" class="img-fluid">
                            </div>
                        </div>
                        <!-- Content -->
                        <div class="col-lg-6">
                            <div class="p-4 p-md-5 h-100 d-flex flex-column">
                                <div class="mb-2">
                                    <span class="badge badge-accent">${produit.categorie.nom}</span>
                                </div>
                                <h1 class="display-6 fw-bold mb-3 brand-heading">${produit.nom}</h1>

                                <div class="d-flex align-items-center gap-3 mb-4">
                                    <div class="h2 mb-0 fw-bold" style="color:var(--primary-dark);">${produit.prix} MAD
                                    </div>
                                    <c:choose>
                                        <c:when test="${produit.stock > 0}">
                                            <span class="badge"
                                                style="background:rgba(142,153,121,0.15); color:var(--primary-dark); padding:6px 12px; border-radius:20px;">
                                                <i class="fas fa-check-circle me-1"></i>En stock
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge"
                                                style="background:rgba(163,124,122,0.15); color:var(--accent); padding:6px 12px; border-radius:20px;">
                                                <i class="fas fa-times-circle me-1"></i>Rupture de stock
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="mb-4">
                                    <h6 class="fw-bold text-uppercase small"
                                        style="color:var(--text-muted); letter-spacing:1px;">Description</h6>
                                    <p class="text-muted lh-lg">
                                        <c:out value="${produit.description}" />
                                    </p>
                                </div>

                                <c:if test="${produit.stock > 0}">
                                    <form action="panier" method="POST" class="mt-auto">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="produitId" value="${produit.id}">
                                        <div class="row g-3 align-items-end">
                                            <div class="col-auto">
                                                <label class="form-label small fw-bold">Quantité</label>
                                                <input type="number" name="quantite" class="form-control text-center"
                                                    value="1" min="1" max="${produit.stock}" style="width: 80px;">
                                            </div>
                                            <div class="col">
                                                <button type="submit"
                                                    class="btn btn-brand w-100 py-2 fw-bold fs-5 shadow-theme">
                                                    <i class="fas fa-shopping-bag me-2"></i> Ajouter au panier
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </c:if>

                                <div class="d-flex gap-2 mt-5">
                                    <div class="feature-box">
                                        <i class="fas fa-truck"></i>
                                        <div class="small fw-bold">Livraison Express</div>
                                    </div>
                                    <div class="feature-box">
                                        <i class="fas fa-shield-alt"></i>
                                        <div class="small fw-bold">Garantie Qualité</div>
                                    </div>
                                    <div class="feature-box">
                                        <i class="fas fa-lock"></i>
                                        <div class="small fw-bold">Paiement Sûr</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Suggestions -->
                <c:if test="${not empty suggestions}">
                    <div class="mt-5 pt-4">
                        <h3 class="fw-bold mb-4 brand-heading">Vous aimerez aussi</h3>
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
                            <c:forEach var="item" items="${suggestions}">
                                <div class="col">
                                    <div class="product-card h-100 d-flex flex-column">
                                        <a href="produit-detail?id=${item.id}" class="text-decoration-none">
                                            <div class="product-img-wrap" style="height:180px;">
                                                <img src="${not empty item.imageUrl ? item.imageUrl : 'https://placehold.co/400x400/E9E7E8/A6A58C?text=Image'}"
                                                    alt="${item.nom}">
                                            </div>
                                        </a>
                                        <div class="p-3 d-flex flex-column flex-grow-1">
                                            <h6 class="fw-bold mb-1 text-truncate">
                                                <a href="produit-detail?id=${item.id}"
                                                    class="text-decoration-none text-dark">${item.nom}</a>
                                            </h6>
                                            <div class="mt-auto d-flex justify-content-between align-items-center">
                                                <span class="fw-bold text-brand">${item.prix} MAD</span>
                                                <a href="produit-detail?id=${item.id}"
                                                    class="btn btn-sm btn-outline-brand rounded-pill px-3 py-1"
                                                    style="font-size:.7rem;">Voir</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </div>

            <jsp:include page="includes/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>