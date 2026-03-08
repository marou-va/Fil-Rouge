<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Détails de la Commande - MaBoutique</title>

                <!-- Google Fonts -->
                <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">

                <!-- Font Awesome -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

                <!-- Bootstrap 5 -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

                <style>
                    :root {
                        --brand-color: #f68b1e;
                        --brand-dark: #e57a10;
                        --bg-light: #f8f9fa;
                    }

                    body {
                        font-family: 'Outfit', sans-serif;
                        background-color: var(--bg-light);
                        color: #34495e;
                        display: flex;
                        flex-direction: column;
                        min-height: 100vh;
                    }

                    .text-brand {
                        color: var(--brand-color) !important;
                    }

                    .bg-brand {
                        background-color: var(--brand-color) !important;
                    }

                    .btn-brand {
                        background-color: var(--brand-color);
                        color: white;
                        border: none;
                        font-weight: 600;
                        transition: all 0.3s;
                    }

                    .btn-brand:hover {
                        background-color: var(--brand-dark);
                        color: white;
                        box-shadow: 0 4px 12px rgba(246, 139, 30, 0.3);
                    }

                    /* Profile Header */
                    .profile-hdr {
                        background: linear-gradient(135deg, #232526 0%, #414345 100%);
                        color: white;
                        padding: 60px 0;
                        margin-bottom: -50px;
                    }

                    .avatar-circle {
                        width: 100px;
                        height: 100px;
                        background-color: var(--brand-color);
                        color: white;
                        font-size: 2.5rem;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        border-radius: 50%;
                        border: 4px solid rgba(255, 255, 255, 0.2);
                        font-weight: 700;
                    }

                    /* Sidebar Nav */
                    .acc-nav .nav-link {
                        color: #444;
                        padding: 12px 20px;
                        border-radius: 10px;
                        margin-bottom: 5px;
                        font-weight: 500;
                        transition: all 0.2s;
                    }

                    .acc-nav .nav-link:hover {
                        background-color: rgba(246, 139, 30, 0.1);
                        color: var(--brand-color);
                    }

                    .acc-nav .nav-link.active {
                        background-color: var(--brand-color);
                        color: white;
                        box-shadow: 0 4px 10px rgba(246, 139, 30, 0.2);
                    }

                    .acc-nav .nav-link i {
                        width: 25px;
                    }

                    /* Content Card */
                    .content-card {
                        border: none;
                        border-radius: 15px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                        background: rgba(255, 255, 255, 0.9);
                        backdrop-filter: blur(10px);
                    }

                    .badge-status {
                        padding: 6px 12px;
                        border-radius: 8px;
                        font-weight: 500;
                        font-size: 0.8rem;
                    }

                    .badge-EN_COURS {
                        background-color: #fff3cd;
                        color: #856404;
                    }

                    .badge-VALIDEE {
                        background-color: #d4edda;
                        color: #155724;
                    }

                    .badge-ANNULEE {
                        background-color: #f8d7da;
                        color: #721c24;
                    }

                    .detail-img {
                        width: 60px;
                        height: 60px;
                        object-fit: contain;
                        background-color: #fff;
                        border: 1px solid #eee;
                        border-radius: 8px;
                    }

                    .order-info-label {
                        font-size: 0.75rem;
                        color: #999;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                        margin-bottom: 2px;
                    }

                    .order-info-value {
                        font-weight: 600;
                        color: #333;
                    }
                </style>
            </head>

            <body>

                <jsp:include page="includes/navbar.jsp" />

                <div class="profile-hdr">
                    <div class="container">
                        <div class="d-flex align-items-center">
                            <div class="avatar-circle me-4">
                                ${sessionScope.utilisateur.nom.substring(0,1).toUpperCase()}
                            </div>
                            <div>
                                <h2 class="fw-bold mb-1">${sessionScope.utilisateur.nom}</h2>
                                <p class="mb-0 text-white-50"><i class="fas fa-file-invoice me-2"></i>Détails de la
                                    commande #${commande.id}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container mb-5">
                    <div class="row">
                        <!-- Navigation Latérale -->
                        <div class="col-lg-3">
                            <div class="content-card p-3 mb-4">
                                <nav class="nav flex-column acc-nav">
                                    <a class="nav-link" href="profil"><i class="fas fa-user-circle"></i> Mes
                                        Informations</a>
                                    <a class="nav-link active" href="historique"><i class="fas fa-shopping-bag"></i> Mes
                                        Commandes</a>
                                    <a class="nav-link" href="#"><i class="fas fa-heart"></i> Ma Liste de Souhaits</a>
                                    <a class="nav-link" href="#"><i class="fas fa-map-marker-alt"></i> Mes Adresses</a>
                                    <hr class="my-2">
                                    <a class="nav-link text-danger" href="logout"><i class="fas fa-sign-out-alt"></i>
                                        Déconnexion</a>
                                </nav>
                            </div>
                        </div>

                        <!-- Contenu Principal -->
                        <div class="col-lg-9">
                            <div class="content-card p-4">
                                <div class="d-flex justify-content-between align-items-start mb-4">
                                    <div>
                                        <a href="historique"
                                            class="text-decoration-none text-muted small mb-2 d-inline-block">
                                            <i class="fas fa-arrow-left me-1"></i> Retour à l'historique
                                        </a>
                                        <h4 class="fw-bold mb-0">Commande #${commande.id}</h4>
                                    </div>
                                    <span class="badge-status badge-${commande.statut} fs-6">
                                        <i class="fas fa-circle-check me-2"></i>${commande.statut}
                                    </span>
                                </div>

                                <div class="row g-4 mb-4">
                                    <div class="col-md-4">
                                        <div class="p-3 bg-light rounded-3">
                                            <div class="order-info-label">Date de commande</div>
                                            <div class="order-info-value">
                                                <fmt:parseDate value="${commande.dateCommande}"
                                                    pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                                <fmt:formatDate value="${parsedDate}"
                                                    pattern="dd MMMM yyyy 'à' HH:mm" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="p-3 bg-light rounded-3">
                                            <div class="order-info-label">Mode de paiement</div>
                                            <div class="order-info-value"><i
                                                    class="fas fa-credit-card me-2 text-muted"></i>Carte Bancaire</div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="p-3 bg-light rounded-3">
                                            <div class="order-info-label">Service client</div>
                                            <div class="order-info-value"><i
                                                    class="fas fa-headset me-2 text-muted"></i>Assistance 24/7</div>
                                        </div>
                                    </div>
                                </div>

                                <h6 class="fw-bold mb-3">Récapitulatif des articles</h6>
                                <div class="table-responsive border rounded-3 mb-4">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="bg-light">
                                            <tr>
                                                <th class="ps-4 border-0">Produit</th>
                                                <th class="border-0 text-center">Prix</th>
                                                <th class="border-0 text-center">Qté</th>
                                                <th class="border-0 text-end pe-4">Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:set var="totalGeneral" value="0" />
                                            <c:forEach var="item" items="${commande.items}">
                                                <tr>
                                                    <td class="ps-4">
                                                        <div class="d-flex align-items-center">
                                                            <c:set var="imgSrc"
                                                                value="${not empty item.produit.imageUrl ? item.produit.imageUrl : 'https://placehold.co/60x60/eeeeee/999999?text=IMG'}" />
                                                            <img src="${imgSrc}" class="detail-img me-3"
                                                                alt="${item.produit.nom}">
                                                            <div>
                                                                <div class="fw-bold text-dark">${item.produit.nom}</div>
                                                                <small
                                                                    class="text-muted">${item.produit.categorie.nom}</small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-center">${item.prixUnitaire} MAD</td>
                                                    <td class="text-center">x${item.quantite}</td>
                                                    <td class="text-end pe-4 fw-bold">
                                                        <c:set var="sousTotal"
                                                            value="${item.prixUnitaire * item.quantite}" />
                                                        <c:set var="totalGeneral" value="${totalGeneral + sousTotal}" />
                                                        ${sousTotal} MAD
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="row justify-content-end">
                                    <div class="col-md-5">
                                        <div class="card bg-light border-0">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between mb-2">
                                                    <span class="text-muted">Sous-total</span>
                                                    <span class="fw-bold">${totalGeneral} MAD</span>
                                                </div>
                                                <div class="d-flex justify-content-between mb-2">
                                                    <span class="text-muted">Frais de livraison</span>
                                                    <span class="text-success fw-bold">Gratuit</span>
                                                </div>
                                                <hr>
                                                <div class="d-flex justify-content-between">
                                                    <span class="fw-bold h5 mb-0">Total</span>
                                                    <span class="fw-bold h5 mb-0 text-brand">${totalGeneral} MAD</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-4 pt-4 border-top">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <p class="text-muted small mb-0"><i class="fas fa-shield-halved me-2"></i>Votre
                                            achat est protégé par BioShop Protection.</p>
                                        <button class="btn btn-outline-dark fw-bold rounded-pill px-4">
                                            <i class="fas fa-download me-2"></i>Facture PDF
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="includes/footer.jsp" />
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>