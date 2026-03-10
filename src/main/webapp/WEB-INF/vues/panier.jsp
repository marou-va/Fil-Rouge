<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Mon Panier - MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                .panier-item-img {
                    width: 72px;
                    height: 72px;
                    object-fit: contain;
                    border-radius: 12px;
                    background: #f8fafc;
                    border: 1px solid #e2e8f0;
                    padding: 6px;
                }

                .qty-wrap {
                    display: flex;
                    align-items: center;
                    border: 1.5px solid #e2e8f0;
                    border-radius: 10px;
                    overflow: hidden;
                    width: fit-content;
                }

                .qty-btn-shop {
                    width: 36px;
                    height: 36px;
                    background: #f8fafc;
                    border: none;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 14px;
                    font-weight: 700;
                    color: #334155;
                    transition: all 0.15s;
                }

                .qty-btn-shop:hover {
                    background: #ede9fe;
                    color: #7c3aed;
                }

                .qty-val {
                    width: 44px;
                    height: 36px;
                    text-align: center;
                    font-weight: 700;
                    font-size: 0.9rem;
                    border: none;
                    border-left: 1px solid #e2e8f0;
                    border-right: 1px solid #e2e8f0;
                    background: white;
                    color: #0f172a;
                }

                .remove-btn {
                    width: 36px;
                    height: 36px;
                    background: #fff1f2;
                    border: none;
                    border-radius: 8px;
                    color: #ef4444;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    cursor: pointer;
                    transition: all 0.2s;
                    font-size: 13px;
                }

                .remove-btn:hover {
                    background: #fee2e2;
                    transform: scale(1.1);
                }

                .summary-row {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding: 12px 0;
                    border-bottom: 1px solid #f1f5f9;
                }

                .summary-row:last-of-type {
                    border: none;
                }

                .page-hero {
                    background: linear-gradient(160deg, #0f0c29, #302b63);
                    padding: 36px 0 60px;
                }

                .hero-chip {
                    display: inline-flex;
                    align-items: center;
                    gap: 6px;
                    background: rgba(124, 58, 237, 0.3);
                    border: 1px solid rgba(124, 58, 237, 0.4);
                    color: #c4b5fd;
                    padding: 5px 14px;
                    border-radius: 20px;
                    font-size: 0.78rem;
                    font-weight: 600;
                }
            </style>
        </head>

        <body>
            <jsp:include page="includes/navbar.jsp" />

            <div class="page-hero">
                <div class="container">
                    <div class="hero-chip"><i class="fas fa-shopping-bag"></i> Mon panier</div>
                    <h1 style="font-size:2rem;font-weight:800;color:white;margin-top:12px;margin-bottom:0;">
                        <c:choose>
                            <c:when test="${empty panier or empty panier.items}">Votre panier est vide</c:when>
                            <c:otherwise>${panier.items.size()} article(s) dans votre panier</c:otherwise>
                        </c:choose>
                    </h1>
                </div>
            </div>

            <div class="container pb-5" style="margin-top:-32px; position:relative; z-index:1;">

                <!-- Error alert -->
                <c:if test="${not empty sessionScope.panierErreur}">
                    <div
                        style="background:#fff1f2;border-left:4px solid #f43f5e;border-radius:12px;padding:16px 20px;margin-bottom:24px;display:flex;align-items:center;gap:12px;color:#9f1239;">
                        <i class="fas fa-exclamation-circle fa-lg"></i>
                        <div><strong>Impossible de valider :</strong> ${sessionScope.panierErreur}</div>
                    </div>
                    <% session.removeAttribute("panierErreur"); %>
                </c:if>

                <c:choose>
                    <c:when test="${empty panier or empty panier.items}">
                        <div class="empty-state mt-4">
                            <div class="empty-icon"><i class="fas fa-shopping-basket"></i></div>
                            <h4>Aucun article dans votre panier</h4>
                            <p>Découvrez notre catalogue et ajoutez des produits !</p>
                            <a href="catalogue" class="btn-accent mt-3">Aller au catalogue</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-4 align-items-start">
                            <!-- Items -->
                            <div class="col-lg-8">
                                <div
                                    style="background:white;border-radius:20px;border:1px solid #e2e8f0;overflow:hidden;">
                                    <c:forEach var="item" items="${panier.items}">
                                        <div
                                            style="display:flex;align-items:center;gap:16px;padding:20px;border-bottom:1px solid #f1f5f9;">
                                            <a href="produit-detail?id=${item.produit.id}">
                                                <img src="${not empty item.produit.imageUrl ? item.produit.imageUrl : 'https://placehold.co/72x72/f3f4f6/94a3b8?text=IMG'}"
                                                    class="panier-item-img" alt="${item.produit.nom}"
                                                    onerror="this.src='https://placehold.co/72x72/f3f4f6/94a3b8?text=IMG'">
                                            </a>
                                            <div style="flex:1;">
                                                <a href="produit-detail?id=${item.produit.id}"
                                                    style="text-decoration:none;color:#0f172a;font-weight:700;font-size:0.95rem;">${item.produit.nom}</a>
                                                <div style="font-size:0.78rem;color:#94a3b8;margin-top:3px;">
                                                    ${item.produit.categorie.nom}</div>
                                                <c:choose>
                                                    <c:when test="${item.produit.stock == 0}">
                                                        <span
                                                            style="font-size:0.75rem;color:#dc2626;font-weight:600;"><i
                                                                class="fas fa-times-circle me-1"></i>Épuisé</span>
                                                    </c:when>
                                                    <c:when test="${item.produit.stock <= 5}">
                                                        <span
                                                            style="font-size:0.75rem;color:#f59e0b;font-weight:600;"><i
                                                                class="fas fa-fire me-1"></i>Plus que
                                                            ${item.produit.stock} !</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            style="font-size:0.75rem;color:#16a34a;font-weight:600;"><i
                                                                class="fas fa-check-circle me-1"></i>En stock</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div style="text-align:center;">
                                                <div
                                                    style="font-size:0.72rem;color:#94a3b8;margin-bottom:6px;font-weight:600;text-transform:uppercase;">
                                                    Quantité</div>
                                                <div class="qty-wrap">
                                                    <a href="update-panier?id=${item.produit.id}&action=minus"
                                                        class="qty-btn-shop" style="text-decoration:none;">−</a>
                                                    <div class="qty-val">${item.quantite}</div>
                                                    <c:choose>
                                                        <c:when test="${item.quantite < item.produit.stock}">
                                                            <a href="update-panier?id=${item.produit.id}&action=plus"
                                                                class="qty-btn-shop" style="text-decoration:none;">+</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="qty-btn-shop"
                                                                style="opacity:0.3;cursor:not-allowed;">+</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div style="min-width:90px;text-align:right;">
                                                <div
                                                    style="font-size:0.72rem;color:#94a3b8;font-weight:600;text-transform:uppercase;margin-bottom:4px;">
                                                    Sous-total</div>
                                                <div style="font-size:1.05rem;font-weight:800;color:#7c3aed;">
                                                    ${item.sousTotal} <small
                                                        style="font-size:0.7rem;font-weight:500;">MAD</small></div>
                                            </div>
                                            <a href="supprimer-article?id=${item.produit.id}"
                                                onclick="return confirm('Retirer cet article ?')" class="remove-btn"
                                                title="Supprimer">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </div>
                                    </c:forEach>
                                    <div style="padding:16px 20px;">
                                        <a href="catalogue"
                                            style="text-decoration:none;color:#64748b;font-size:0.875rem;font-weight:600;display:flex;align-items:center;gap:6px;">
                                            <i class="fas fa-arrow-left"></i> Continuer mes achats
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <!-- Summary -->
                            <div class="col-lg-4" style="position:sticky;top:85px;">
                                <div
                                    style="background:white;border-radius:20px;border:1px solid #e2e8f0;overflow:hidden;">
                                    <div style="padding:20px 24px;border-bottom:1px solid #f1f5f9;">
                                        <span style="font-size:1rem;font-weight:800;color:#0f172a;">Résumé de la
                                            commande</span>
                                    </div>
                                    <div style="padding:20px 24px;">
                                        <div class="summary-row">
                                            <span style="color:#64748b;font-size:0.875rem;">Sous-total
                                                (${panier.items.size()} article(s))</span>
                                            <span style="font-weight:600;">${panier.total} MAD</span>
                                        </div>
                                        <div class="summary-row">
                                            <span style="color:#64748b;font-size:0.875rem;">Livraison</span>
                                            <span style="font-weight:700;color:#16a34a;font-size:0.875rem;"><i
                                                    class="fas fa-truck me-1"></i>Gratuite</span>
                                        </div>
                                        <div style="padding:16px 0;margin-top:4px;border-top:2px dashed #e2e8f0;">
                                            <div style="display:flex;justify-content:space-between;align-items:center;">
                                                <span style="font-size:1rem;font-weight:700;color:#0f172a;">Total à
                                                    payer</span>
                                                <span
                                                    style="font-size:1.5rem;font-weight:900;color:#7c3aed;">${panier.total}
                                                    <small style="font-size:0.75rem;font-weight:500;">MAD</small></span>
                                            </div>
                                        </div>
                                        <a href="validercommande" class="btn-accent w-100 justify-content-center py-3"
                                            style="font-size:0.95rem;">
                                            <i class="fas fa-lock"></i> Valider ma commande
                                        </a>
                                        <div style="margin-top:20px;text-align:center;">
                                            <div style="font-size:0.75rem;color:#94a3b8;margin-bottom:10px;">Paiement
                                                100% sécurisé</div>
                                            <div
                                                style="display:flex;justify-content:center;gap:12px;color:#94a3b8;font-size:28px;">
                                                <i class="fab fa-cc-visa"></i>
                                                <i class="fab fa-cc-mastercard"></i>
                                                <i class="fab fa-cc-paypal"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <style>
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

            <jsp:include page="includes/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>