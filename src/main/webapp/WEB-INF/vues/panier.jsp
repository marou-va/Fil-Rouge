<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Mon Panier — MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
            <style>
                .cart-item-img {
                    width: 80px;
                    height: 80px;
                    object-fit: contain;
                    background: #fff;
                    padding: 5px;
                    border-radius: var(--radius);
                    border: 1px solid var(--border-color);
                }

                .qty-ctrl {
                    display: flex;
                    align-items: center;
                    background: var(--bg);
                    border-radius: var(--radius);
                    overflow: hidden;
                    border: 1px solid var(--border-color);
                }

                .qty-ctrl .btn {
                    padding: 4px 12px;
                    border: none;
                    background: transparent;
                    transition: var(--transition);
                }

                .qty-ctrl .btn:hover {
                    background: rgba(142, 153, 121, 0.2);
                    color: var(--primary-dark);
                }

                .qty-ctrl input {
                    width: 40px;
                    border: none;
                    text-align: center;
                    font-weight: 700;
                    background: transparent;
                    outline: none;
                }

                .summary-card {
                    border: 2px solid var(--primary-light);
                    border-radius: var(--radius-lg);
                    background: #fff;
                    padding: 1.5rem;
                }
            </style>
        </head>

        <body>
            <jsp:include page="includes/navbar.jsp" />

            <div class="container py-5">
                <div class="d-flex align-items-center gap-3 mb-4">
                    <i class="fas fa-shopping-bag fa-2x text-brand"></i>
                    <h2 class="fw-bold mb-0 brand-heading">Votre Panier</h2>
                </div>

                <c:if test="${not empty sessionScope.panierErreur}">
                    <div class="alert alert-accent alert-dismissible fade show shadow-sm mb-4" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i> ${sessionScope.panierErreur}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% session.removeAttribute("panierErreur"); %>
                </c:if>

                <c:choose>
                    <c:when test="${empty panier or empty panier.items}">
                        <div class="card-theme p-5 text-center">
                            <i class="fas fa-shopping-basket fa-4x mb-3" style="color:var(--primary-light);"></i>
                            <h4 class="text-muted mb-4">Votre panier se sent bien vide…</h4>
                            <a href="catalogue" class="btn btn-brand px-5 py-2">Parcourir les produits</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-4">
                            <!-- Liste des articles -->
                            <div class="col-lg-8">
                                <div class="card-theme overflow-hidden">
                                    <table class="table align-middle mb-0">
                                        <thead style="background:var(--primary-dark); color:#fff;">
                                            <tr>
                                                <th class="ps-3 py-3 text-uppercase small">Produit</th>
                                                <th class="py-3 text-uppercase small text-center">Quantité</th>
                                                <th class="py-3 text-uppercase small text-end">Sous-total</th>
                                                <th class="pe-3 py-3"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${panier.items}">
                                                <tr class="border-bottom"
                                                    style="border-color:var(--border-color)!important;">
                                                    <td class="ps-3 py-3">
                                                        <div class="d-flex align-items-center gap-3">
                                                            <img src="${not empty item.produit.imageUrl ? item.produit.imageUrl : 'https://placehold.co/80x80/E9E7E8/A6A58C?text=?'}"
                                                                class="cart-item-img" alt="${item.produit.nom}">
                                                            <div>
                                                                <a href="produit-detail?id=${item.produit.id}"
                                                                    class="text-decoration-none text-dark fw-bold">${item.produit.nom}</a>
                                                                <div class="small text-muted">${item.produit.prix} MAD /
                                                                    unité</div>
                                                                <c:if
                                                                    test="${item.produit.stock <= 5 and item.produit.stock > 0}">
                                                                    <div class="badge mt-1"
                                                                        style="background:rgba(163,124,122,0.15); color:var(--accent); font-size:.65rem;">
                                                                        Attention : plus que ${item.produit.stock} !
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-center">
                                                        <div class="d-inline-flex qty-ctrl">
                                                            <a href="update-panier?id=${item.produit.id}&action=minus"
                                                                class="btn btn-sm"><i class="fas fa-minus"></i></a>
                                                            <input type="text" value="${item.quantite}" readonly>
                                                            <a href="update-panier?id=${item.produit.id}&action=plus"
                                                                class="btn btn-sm ${item.quantite >= item.produit.stock ? 'disabled opacity-25' : ''}"><i
                                                                    class="fas fa-plus"></i></a>
                                                        </div>
                                                    </td>
                                                    <td class="text-end fw-bold" style="color:var(--primary-dark);">
                                                        ${item.sousTotal} MAD</td>
                                                    <td class="pe-3 text-end">
                                                        <a href="supprimer-article?id=${item.produit.id}"
                                                            class="btn btn-sm border-0 text-muted hover-accent"
                                                            onclick="return confirm('Retirer ce produit ?')"
                                                            title="Supprimer">
                                                            <i class="fas fa-times"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="mt-3">
                                    <a href="catalogue" class="btn btn-outline-brand btn-sm">
                                        <i class="fas fa-arrow-left me-2"></i>Continuer mes achats
                                    </a>
                                </div>
                            </div>

                            <!-- Résumé -->
                            <div class="col-lg-4">
                                <div class="summary-card shadow-theme">
                                    <h5 class="fw-bold mb-4">Détails de commande</h5>
                                    <div class="d-flex justify-content-between mb-3 text-muted">
                                        <span>Sous-total</span>
                                        <span>${panier.total} MAD</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3">
                                        <span class="text-muted">Frais de port</span>
                                        <span class="text-success fw-bold">Gratuit</span>
                                    </div>
                                    <hr class="my-4">
                                    <div class="d-flex justify-content-between mb-4">
                                        <span class="h5 fw-bold mb-0">Total</span>
                                        <span class="h4 fw-bold mb-0 text-brand">${panier.total} MAD</span>
                                    </div>
                                    <div class="d-grid">
                                        <a href="validercommande" class="btn btn-brand py-3 fw-bold shadow-sm">
                                            <i class="fas fa-lock me-2"></i>Valider mon panier
                                        </a>
                                    </div>
                                    <div class="mt-4 p-3 rounded"
                                        style="background:var(--bg); border:1px dashed var(--border-color);">
                                        <div class="small fw-bold text-center mb-2"><i
                                                class="fas fa-shield-alt me-2 text-brand"></i>SÉCURITÉ GARANTIE</div>
                                        <div class="d-flex justify-content-center gap-3 text-muted">
                                            <i class="fab fa-cc-visa fa-2x"></i>
                                            <i class="fab fa-cc-mastercard fa-2x"></i>
                                            <i class="fab fa-cc-paypal fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <jsp:include page="includes/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>