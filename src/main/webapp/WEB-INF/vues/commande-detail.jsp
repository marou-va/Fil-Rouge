<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Détails Commande #${commande.id} — MaBoutique</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
                <style>
                    .profile-hero {
                        background: linear-gradient(rgba(142, 153, 121, 0.9), rgba(122, 132, 106, 0.9)), url('https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&q=80');
                        background-size: cover;
                        background-position: center;
                        color: #fff;
                        padding: 3rem 0;
                        margin-bottom: -3rem;
                    }

                    .u-avatar-lg {
                        width: 80px;
                        height: 80px;
                        background: #fff;
                        color: var(--primary);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        border-radius: 50%;
                        font-size: 2rem;
                        font-weight: 700;
                    }

                    .acc-sidebar-link {
                        padding: 12px 20px;
                        border-radius: 12px;
                        color: var(--text);
                        text-decoration: none;
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        transition: var(--transition);
                        margin-bottom: 5px;
                        font-weight: 600;
                    }

                    .acc-sidebar-link:hover {
                        background: var(--bg);
                        color: var(--primary-dark);
                    }

                    .acc-sidebar-link.active {
                        background: var(--primary);
                        color: #fff;
                    }

                    .box-info {
                        background: var(--bg);
                        border: 1px solid var(--border-color);
                        border-radius: var(--radius);
                        padding: 1rem;
                    }

                    .box-info-label {
                        font-size: .65rem;
                        color: var(--text-muted);
                        font-weight: 700;
                        text-uppercase: small;
                        letter-spacing: 1px;
                        margin-bottom: 4px;
                    }

                    .box-info-val {
                        font-weight: 700;
                        color: var(--text);
                    }

                    .detail-item-img {
                        width: 50px;
                        height: 50px;
                        object-fit: contain;
                        background: #fff;
                        border-radius: 6px;
                        border: 1px solid var(--border-color);
                    }
                </style>
            </head>

            <body>
                <jsp:include page="includes/navbar.jsp" />

                <header class="profile-hero">
                    <div class="container">
                        <div class="d-flex align-items-center gap-4">
                            <div class="u-avatar-lg">
                                ${sessionScope.utilisateur.nom.substring(0,1).toUpperCase()}
                            </div>
                            <div>
                                <h1 class="h2 fw-bold mb-1">Détails de commande</h1>
                                <p class="mb-0 opacity-75">Commande #${commande.id}</p>
                            </div>
                            <div class="ms-auto">
                                <c:choose>
                                    <c:when test="${commande.statut == 'VALIDEE'}">
                                        <span class="badge rounded-pill py-2 px-3 fs-6"
                                            style="background:rgba(142,153,121,0.2); color:var(--primary-dark);">VALIDÉE</span>
                                    </c:when>
                                    <c:when test="${commande.statut == 'EN_COURS'}">
                                        <span class="badge rounded-pill py-2 px-3 fs-6"
                                            style="background:rgba(180,194,190,0.3); color:var(--text-dark);">EN
                                            COURS</span>
                                    </c:when>
                                    <c:when test="${commande.statut == 'ANNULEE'}">
                                        <span class="badge rounded-pill py-2 px-3 fs-6"
                                            style="background:rgba(163,124,122,0.2); color:var(--accent);">ANNULÉE</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary py-2 px-3 fs-6">${commande.statut}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </header>

                <div class="container mb-5">
                    <div class="row g-4">
                        <!-- Sidebar -->
                        <div class="col-lg-3">
                            <div class="card-theme p-3" style="margin-top:0;">
                                <a href="profil" class="acc-sidebar-link">
                                    <i class="fas fa-user-circle"></i>Mon Profil
                                </a>
                                <a href="historique" class="acc-sidebar-link active">
                                    <i class="fas fa-history"></i>Mes Commandes
                                </a>
                                <a href="#" class="acc-sidebar-link">
                                    <i class="fas fa-heart"></i>Favoris
                                </a>
                                <hr class="my-3">
                                <a href="logout" class="acc-sidebar-link text-accent">
                                    <i class="fas fa-sign-out-alt"></i>Déconnexion
                                </a>
                            </div>
                        </div>

                        <!-- Content -->
                        <div class="col-lg-9">
                            <div class="card-theme p-4 shadow-theme">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <a href="historique" class="text-brand text-decoration-none small fw-bold">
                                        <i class="fas fa-arrow-left me-2"></i>Retour à l'historique
                                    </a>
                                    <button class="btn btn-sm btn-outline-brand rounded-pill px-3">
                                        <i class="fas fa-file-pdf me-2"></i>Facture
                                    </button>
                                </div>

                                <div class="row g-3 mb-5">
                                    <div class="col-md-4">
                                        <div class="box-info h-100">
                                            <div class="box-info-label">Date d'achat</div>
                                            <div class="box-info-val">
                                                <fmt:parseDate value="${commande.dateCommande}"
                                                    pattern="yyyy-MM-dd'T'HH:mm" var="pDate" type="both" />
                                                <fmt:formatDate value="${pDate}" pattern="dd MMMM yyyy" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="box-info h-100">
                                            <div class="box-info-label">Mode de paiement</div>
                                            <div class="box-info-val"><i
                                                    class="fas fa-credit-card me-2 text-muted"></i>Carte de débit</div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="box-info h-100">
                                            <div class="box-info-label">Aide & Support</div>
                                            <div class="box-info-val"><i
                                                    class="fas fa-headset me-2 text-muted"></i>Besoin d'aide ?</div>
                                        </div>
                                    </div>
                                </div>

                                <h6 class="fw-bold mb-3 brand-heading">Articles commandés</h6>
                                <div class="card-theme overflow-hidden mb-5" style="border-radius:var(--radius);">
                                    <table class="table align-middle mb-0">
                                        <thead style="background:var(--bg);">
                                            <tr>
                                                <th class="ps-3 py-2 small text-muted text-uppercase">Produit</th>
                                                <th class="py-2 small text-muted text-uppercase text-center">Qté</th>
                                                <th class="py-2 small text-muted text-uppercase text-end pe-3">Prix
                                                    Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:set var="totalPrice" value="0" />
                                            <c:forEach var="item" items="${commande.items}">
                                                <tr class="border-bottom"
                                                    style="border-color:var(--border-color)!important;">
                                                    <td class="ps-3 py-3">
                                                        <div class="d-flex align-items-center gap-3">
                                                            <img src="${not empty item.produit.imageUrl ? item.produit.imageUrl : 'https://placehold.co/50x50/E9E7E8/A6A58C?text=?'}"
                                                                class="detail-item-img">
                                                            <div>
                                                                <div class="fw-bold small">${item.produit.nom}</div>
                                                                <div class="text-muted" style="font-size:.7rem;">
                                                                    ${item.prixUnitaire} MAD / unité</div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-center fw-bold">x${item.quantite}</td>
                                                    <td class="text-end pe-3 fw-bold"
                                                        style="color:var(--primary-dark);">
                                                        <c:set var="sTotal"
                                                            value="${item.prixUnitaire * item.quantite}" />
                                                        <c:set var="totalPrice" value="${totalPrice + sTotal}" />
                                                        ${sTotal} MAD
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="row flex-column align-items-end">
                                    <div class="col-md-5">
                                        <div class="p-4 rounded"
                                            style="background:var(--bg); border: 2px solid var(--border-color);">
                                            <div class="d-flex justify-content-between mb-2">
                                                <span class="text-muted small">Sous-total</span>
                                                <span class="fw-bold fs-6">${totalPrice} MAD</span>
                                            </div>
                                            <div class="d-flex justify-content-between mb-3">
                                                <span class="text-muted small">Livraison</span>
                                                <span class="text-success fw-bold small">OFFERTE</span>
                                            </div>
                                            <hr class="my-3">
                                            <div class="d-flex justify-content-between">
                                                <span class="h5 fw-bold mb-0">Total payé</span>
                                                <span class="h4 fw-bold mb-0 text-brand">${totalPrice} MAD</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-5 p-3 text-center border-top"
                                    style="border-color:var(--border-color)!important;">
                                    <p class="text-muted small mb-0"><i
                                            class="fas fa-check-shield me-2 text-brand"></i>Transaction protégée par
                                        MaBoutique Secure™</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="includes/footer.jsp" />
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>