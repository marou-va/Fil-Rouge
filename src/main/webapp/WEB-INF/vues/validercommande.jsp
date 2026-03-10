<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Validation de commande - MaBoutique</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { background-color: #f4f5f7; font-family: 'Segoe UI', sans-serif; }
        .text-brand   { color: #f68b1e !important; }
        .bg-brand     { background-color: #f68b1e !important; }
        .btn-brand    { background-color: #f68b1e; color: white; border: none; font-weight: bold; }
        .btn-brand:hover { background-color: #e57a10; color: white; }
        .cart-img {
            width: 60px; height: 60px;
            object-fit: contain;
            border: 1px solid #ddd;
            border-radius: 6px;
            background-color: white;
        }
        .info-client-field {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 10px 14px;
            font-weight: 500;
            color: #495057;
        }
        .info-client-field i { width: 20px; color: #f68b1e; }
        .step-badge {
            width: 34px; height: 34px;
            border-radius: 50%;
            background-color: #f68b1e;
            color: white;
            font-weight: bold;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
            flex-shrink: 0;
        }
        .delivery-card {
            border-left: 4px solid #f68b1e;
            border-radius: 8px;
            background: linear-gradient(135deg, #fff8f2 0%, #ffffff 100%);
        }
        .total-box {
            background: linear-gradient(135deg, #fff4e6, #fff);
            border: 2px solid #f68b1e;
            border-radius: 12px;
        }
        .btn-confirmer {
            background: linear-gradient(135deg, #f68b1e, #e57a10);
            color: white;
            border: none;
            font-weight: bold;
            font-size: 1.05rem;
            letter-spacing: 0.5px;
            transition: transform 0.15s, box-shadow 0.15s;
        }
        .btn-confirmer:hover {
            background: linear-gradient(135deg, #e57a10, #cc6a00);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(246,139,30,0.35);
        }
        .divider-brand { border-top: 2px dashed #f68b1e; opacity: 0.4; }
    </style>
</head>
<body>

    <jsp:include page="includes/navbar.jsp" />

    <div class="container py-5">

        <%-- Titre --%>
        <div class="d-flex align-items-center mb-4">
            <i class="fas fa-shield-alt text-brand fa-lg me-2"></i>
            <h2 class="fw-bold mb-0">Validation de la commande</h2>
        </div>

        <%-- Fil d'ariane --%>
        <div class="d-flex align-items-center gap-3 mb-5 flex-wrap">
            <div class="d-flex align-items-center gap-2 text-muted">
                <div class="step-badge" style="background-color:#dee2e6; color:#6c757d;">1</div>
                <span class="small">Panier</span>
            </div>
            <i class="fas fa-chevron-right text-muted small"></i>
            <div class="d-flex align-items-center gap-2 fw-bold">
                <div class="step-badge">2</div>
                <span class="small text-brand">Validation</span>
            </div>
            
        </div>

        <div class="row g-4">

            <%-- ══ COLONNE GAUCHE ══ --%>
            <div class="col-lg-8">

                <%-- 1. Informations client (lecture seule) --%>
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-white py-3 d-flex align-items-center gap-2">
                        <div class="step-badge" style="width:28px;height:28px;font-size:.8rem;">
                            <i class="fas fa-user" style="font-size:.7rem;"></i>
                        </div>
                        <h5 class="mb-0 fw-bold">Informations de livraison</h5>
                        <span class="ms-auto badge bg-secondary bg-opacity-10 text-secondary small">
                            <i class="fas fa-lock me-1"></i>Non modifiable ici
                        </span>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">

                            <div class="col-md-6">
                                <label class="form-label small text-muted fw-semibold mb-1">
                                    <i class="fas fa-user-circle text-brand me-1"></i>Nom complet
                                </label>
                                <div class="info-client-field">
                                    <i class="fas fa-user me-2"></i>${sessionScope.utilisateur.nom}
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label small text-muted fw-semibold mb-1">
                                    <i class="fas fa-envelope text-brand me-1"></i>Email
                                </label>
                                <div class="info-client-field">
                                    <i class="fas fa-envelope me-2"></i>${sessionScope.utilisateur.email}
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label small text-muted fw-semibold mb-1">
                                    <i class="fas fa-phone text-brand me-1"></i>Téléphone
                                </label>
                                <div class="info-client-field">
                                    <i class="fas fa-phone me-2"></i>${sessionScope.utilisateur.telephone}
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label small text-muted fw-semibold mb-1">
                                    <i class="fas fa-map-marker-alt text-brand me-1"></i>Adresse de livraison
                                </label>
                                <div class="info-client-field">
                                    <i class="fas fa-map-marker-alt me-2"></i>${sessionScope.utilisateur.adresse}
                                </div>
                            </div>

                        </div>
                        <div class="mt-3">
                            <a href="profil" class="text-muted small text-decoration-none">
                                <i class="fas fa-pen fa-xs me-1"></i>
                                Modifier mes informations personnelles
                            </a>
                        </div>
                    </div>
                </div>

                <%-- 2. Date estimée de livraison (calculée ici car c'est purement affichage) --%>
                <%
                    java.time.LocalDate dateEstimee = java.time.LocalDate.now().plusWeeks(2);
                    java.time.format.DateTimeFormatter formatter =
                        java.time.format.DateTimeFormatter.ofPattern("EEEE d MMMM yyyy", java.util.Locale.FRENCH);
                    String dateLivraison = dateEstimee.format(formatter);
                    dateLivraison = Character.toUpperCase(dateLivraison.charAt(0)) + dateLivraison.substring(1);
                    request.setAttribute("dateLivraison", dateLivraison);
                %>
                <div class="card border-0 shadow-sm mb-4 delivery-card">
                    <div class="card-body d-flex align-items-start gap-3 py-3">
                        <div class="flex-shrink-0 mt-1">
                            <i class="fas fa-truck text-brand fa-2x"></i>
                        </div>
                        <div>
                            <div class="fw-bold text-dark mb-1">Livraison estimée</div>
                            <div class="fs-5 text-brand fw-bold">${dateLivraison}</div>
                            <div class="text-muted small mt-1">
                                <i class="fas fa-info-circle me-1"></i>
                                Livraison gratuite — délai estimé de 2 semaines après confirmation.
                            </div>
                        </div>
                        <span class="ms-auto badge bg-success bg-opacity-10 text-success fw-semibold align-self-center">
                            <i class="fas fa-check me-1"></i>Gratuite
                        </span>
                    </div>
                </div>

                <%-- 3. Articles — stock déjà vérifié par le servlet, on affiche simplement --%>
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-white py-3 d-flex align-items-center gap-2">
                        <div class="step-badge" style="width:28px;height:28px;font-size:.8rem;">
                            <i class="fas fa-box" style="font-size:.7rem;"></i>
                        </div>
                        <h5 class="mb-0 fw-bold">Articles commandés</h5>
                        <span class="ms-auto text-muted small">${panier.items.size()} article(s)</span>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="bg-light">
                                    <tr>
                                        <th class="ps-4 py-3">Produit</th>
                                        <th class="text-center">Qté</th>
                                        <th class="text-end">Prix unit.</th>
                                        <th class="text-end pe-4">Sous-total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%-- Pas de vérification de stock ici :
                                         le servlet a déjà tout vérifié avant de forwarder --%>
                                    <c:forEach var="item" items="${panier.items}">
                                        <tr>
                                            <td class="ps-4 py-3">
                                                <div class="d-flex align-items-center">
                                                    <c:set var="imgSrc" value="${not empty item.produit.imageUrl
                                                        ? item.produit.imageUrl
                                                        : 'https://placehold.co/60x60/eeeeee/999999?text=IMG'}" />
                                                    <img src="${imgSrc}" class="cart-img me-3" alt="${item.produit.nom}">
                                                    <div class="fw-bold text-dark">${item.produit.nom}</div>
                                                </div>
                                            </td>
                                            <td class="text-center fw-bold">${item.quantite}</td>
                                            <td class="text-end text-muted">${item.produit.prix} MAD</td>
                                            <td class="text-end pe-4 fw-bold text-brand">${item.sousTotal} MAD</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <a href="panier" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Modifier mon panier
                </a>
            </div>

            <%-- ══ COLONNE DROITE — Résumé & Confirmation ══ --%>
            <div class="col-lg-4 mt-4 mt-lg-0">

                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 fw-bold">Récapitulatif</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-2 text-muted">
                            <span>Sous-total (${panier.items.size()} art.)</span>
                            <span>${panier.total} MAD</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2 text-muted">
                            <span>Frais de livraison</span>
                            <span class="text-success fw-bold">Gratuit</span>
                        </div>
                        

                        <hr class="divider-brand my-3">

                        <div class="total-box p-3 mb-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="fs-6 fw-bold text-dark">Total à payer</span>
                                <span class="fs-4 fw-bold text-brand">${panier.total} MAD</span>
                            </div>
                        </div>

                        <%-- Bouton toujours actif : le servlet garantit que le stock est OK --%>
                        <form action="validercommande" method="post">
                            <input type="hidden" name="action" value="confirmer">
                            <button type="submit" class="btn btn-confirmer w-100 py-3 rounded-3 shadow-sm">
                                <i class="fas fa-check-circle me-2"></i>Confirmer ma commande
                            </button>
                        </form>

                        <div class="mt-4 text-center">
                            <div class="text-muted small mb-2">
                                <i class="fas fa-lock me-1"></i>Paiement 100% sécurisé
                            </div>
                            <i class="fab fa-cc-visa fa-2x text-muted mx-1"></i>
                            <i class="fab fa-cc-mastercard fa-2x text-muted mx-1"></i>
                            <i class="fab fa-cc-paypal fa-2x text-muted mx-1"></i>
                        </div>
                    </div>
                </div>

                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <div class="d-flex align-items-center gap-3 mb-3">
                            <i class="fas fa-calendar-check text-brand fa-lg"></i>
                            <div>
                                <div class="fw-bold small">Date de livraison estimée</div>
                                <div class="text-brand fw-bold">${dateLivraison}</div>
                            </div>
                        </div>
                        <hr class="my-2">
                        <div class="d-flex align-items-center gap-3 mb-2">
                            <i class="fas fa-undo text-brand"></i>
                            <span class="small text-muted">Retours gratuits sous 14 jours</span>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <i class="fas fa-headset text-brand"></i>
                            <span class="small text-muted">Support client 7j/7</span>
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
