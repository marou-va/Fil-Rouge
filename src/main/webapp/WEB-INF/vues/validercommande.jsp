<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Validation de commande — MaBoutique</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
                <style>
                    .step-progress {
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        margin-bottom: 3rem;
                        gap: 1rem;
                    }

                    .step-item {
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        gap: 0.5rem;
                    }

                    .step-num {
                        width: 32px;
                        height: 32px;
                        border-radius: 50%;
                        background: var(--bg);
                        border: 2px solid var(--border-color);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-weight: 700;
                        color: var(--text-muted);
                    }

                    .step-item.active .step-num {
                        background: var(--primary);
                        border-color: var(--primary);
                        color: #fff;
                    }

                    .step-item.done .step-num {
                        background: var(--primary-light);
                        border-color: var(--primary-light);
                        color: #fff;
                    }

                    .step-line {
                        height: 2px;
                        width: 60px;
                        background: var(--border-color);
                        margin-bottom: 1.5rem;
                    }

                    .step-line.done {
                        background: var(--primary-light);
                    }

                    .val-info-box {
                        background: #faf9f8;
                        border: 1px solid var(--border-color);
                        border-radius: var(--radius);
                        padding: 1.25rem;
                    }

                    .val-item-img {
                        width: 50px;
                        height: 50px;
                        object-fit: contain;
                        background: #fff;
                        padding: 2px;
                        border-radius: 6px;
                        border: 1px solid var(--border-color);
                    }
                </style>
            </head>

            <body>
                <jsp:include page="includes/navbar.jsp" />

                <div class="container py-5 text-center">
                    <h2 class="fw-bold mb-5 brand-heading">Confirmation de Commande</h2>

                    <!-- Steps -->
                    <div class="step-progress">
                        <div class="step-item done">
                            <div class="step-num"><i class="fas fa-check"></i></div>
                            <div class="small fw-bold">Panier</div>
                        </div>
                        <div class="step-line done"></div>
                        <div class="step-item active">
                            <div class="step-num">2</div>
                            <div class="small fw-bold">Validation</div>
                        </div>
                        <div class="step-line"></div>
                        <div class="step-item">
                            <div class="step-num">3</div>
                            <div class="small fw-bold">Paiement</div>
                        </div>
                    </div>

                    <div class="row g-4 text-start">
                        <div class="col-lg-8">
                            <!-- Livraison -->
                            <div class="card-theme p-4 mb-4">
                                <h5 class="fw-bold mb-4 d-flex align-items-center gap-2">
                                    <i class="fas fa-truck" style="color:var(--primary);"></i> Détails de livraison
                                </h5>
                                <div class="row g-3">
                                    <div class="col-md-6 text-muted small text-uppercase fw-bold"
                                        style="letter-spacing:1px; font-size:.65rem;">Destinataire</div>
                                    <div class="col-md-6 text-muted small text-uppercase fw-bold"
                                        style="letter-spacing:1px; font-size:.65rem;">Contact</div>
                                    <div class="col-md-6">
                                        <div class="val-info-box fw-bold">
                                            ${sessionScope.utilisateur.nom}
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="val-info-box fw-bold">
                                            <i
                                                class="fas fa-phone fa-xs me-2 text-muted"></i>${sessionScope.utilisateur.telephone}
                                        </div>
                                    </div>
                                    <div class="col-12 mt-3 text-muted small text-uppercase fw-bold"
                                        style="letter-spacing:1px; font-size:.65rem;">Adresse</div>
                                    <div class="col-12">
                                        <div class="val-info-box fw-bold">
                                            <i
                                                class="fas fa-map-marker-alt fa-xs me-2 text-muted"></i>${sessionScope.utilisateur.adresse}
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Livraison Estimée -->
                            <% java.time.LocalDate dateEstimee=java.time.LocalDate.now().plusWeeks(2);
                                java.time.format.DateTimeFormatter
                                formatter=java.time.format.DateTimeFormatter.ofPattern("EEEE d MMMM yyyy",
                                java.util.Locale.FRENCH); String dateLivraison=dateEstimee.format(formatter);
                                dateLivraison=Character.toUpperCase(dateLivraison.charAt(0)) +
                                dateLivraison.substring(1); request.setAttribute("dateLivraison", dateLivraison); %>
                                <div class="card-theme p-3 mb-4 d-flex align-items-center gap-3 border-start-0"
                                    style="border-left:5px solid var(--primary)!important;">
                                    <i class="fas fa-calendar-alt text-brand fa-2x ms-2"></i>
                                    <div>
                                        <div class="small text-muted">Livraison estimée autour du :</div>
                                        <div class="fw-bold" style="color:var(--primary-dark);">${dateLivraison}</div>
                                    </div>
                                    <span class="ms-auto badge badge-brand py-2 px-3">Standard Gratituit</span>
                                </div>

                                <!-- Articles -->
                                <div class="card-theme overflow-hidden mb-4">
                                    <div class="p-3 border-bottom" style="border-color:var(--border-color)!important;">
                                        <h5 class="fw-bold mb-0"> Articles dans ma commande</h5>
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table align-middle mb-0">
                                            <thead style="background:var(--bg);">
                                                <tr>
                                                    <th class="ps-3 py-2 small text-muted text-uppercase">Produit</th>
                                                    <th class="py-2 small text-muted text-uppercase text-center">Qté
                                                    </th>
                                                    <th class="py-2 small text-muted text-uppercase text-end pe-3">
                                                        Sous-total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${panier.items}">
                                                    <tr>
                                                        <td class="ps-3 py-3">
                                                            <div class="d-flex align-items-center gap-3">
                                                                <img src="${not empty item.produit.imageUrl ? item.produit.imageUrl : 'https://placehold.co/50x50/E9E7E8/A6A58C?text=?'}"
                                                                    class="val-item-img">
                                                                <span class="fw-bold small">${item.produit.nom}</span>
                                                            </div>
                                                        </td>
                                                        <td class="text-center fw-bold">x ${item.quantite}</td>
                                                        <td class="text-end pe-3 fw-bold"
                                                            style="color:var(--primary-dark);">${item.sousTotal} MAD
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <a href="panier" class="btn btn-outline-brand btn-sm">
                                    <i class="fas fa-arrow-left me-2"></i>Modifier mon panier
                                </a>
                        </div>

                        <!-- Total -->
                        <div class="col-lg-4">
                            <div class="card-theme p-4 sticky-top" style="top:90px;">
                                <h5 class="fw-bold mb-4">Récapitulatif final</h5>

                                <div class="d-flex justify-content-between mb-3 text-muted small">
                                    <span>Articles (${panier.items.size()})</span>
                                    <span>${panier.total} MAD</span>
                                </div>
                                <div class="d-flex justify-content-between mb-3 text-muted small">
                                    <span>Livraison</span>
                                    <span class="text-success fw-bold">OFFERTE</span>
                                </div>

                                <hr class="my-4">

                                <div class="d-flex justify-content-between mb-4">
                                    <span class="h5 fw-bold mb-0">Total à payer</span>
                                    <span class="h4 fw-bold mb-0 text-brand">${panier.total} MAD</span>
                                </div>

                                <form action="validercommande" method="POST">
                                    <input type="hidden" name="action" value="confirmer">
                                    <button type="submit"
                                        class="btn btn-brand w-100 py-3 fw-bold shadow-theme text-uppercase">
                                        Confirmer la commande <i class="fas fa-lock ms-2"></i>
                                    </button>
                                </form>

                                <div class="mt-4 p-3 rounded text-center" style="background:var(--bg);">
                                    <div class="small text-muted mb-2"><i
                                            class="fas fa-shield-alt me-2 text-brand"></i>Transaction sécurisée 256-bit
                                    </div>
                                    <div class="d-flex justify-content-center gap-2 text-muted opacity-75">
                                        <i class="fab fa-cc-visa fa-2x"></i>
                                        <i class="fab fa-cc-mastercard fa-2x"></i>
                                        <i class="fab fa-cc-paypal fa-2x"></i>
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