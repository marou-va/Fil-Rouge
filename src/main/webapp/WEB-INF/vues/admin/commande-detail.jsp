<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Détail Commande #${commande.id} - MaBoutique Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                :root {
                    --brand-color: #f68b1e;
                }

                body {
                    background-color: #f8f9fa;
                }

                .detail-card {
                    background: white;
                    border-radius: 15px;
                    padding: 25px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                    margin-bottom: 20px;
                }

                .text-brand {
                    color: var(--brand-color);
                }
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <c:set var="page" value="commandes" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                        <nav aria-label="breadcrumb" class="mb-4">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="dashboard" class="text-brand">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="commandes" class="text-brand">Commandes</a></li>
                                <li class="breadcrumb-item active">Détail #${commande.id}</li>
                            </ol>
                        </nav>

                        <div class="row">
                            <div class="col-lg-8">
                                <div class="detail-card">
                                    <h4 class="fw-bold mb-4">Articles commandés</h4>
                                    <div class="table-responsive">
                                        <table class="table align-middle">
                                            <thead>
                                                <tr>
                                                    <th>Produit</th>
                                                    <th>Prix Unit.</th>
                                                    <th>Quantité</th>
                                                    <th class="text-end">Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:set var="totalItems" value="0.0" />
                                                <c:forEach var="item" items="${commande.items}">
                                                    <tr>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <img src="${item.produit.imageUrl}"
                                                                    alt="${item.produit.nom}"
                                                                    style="width: 40px; height: 40px; object-fit: cover;"
                                                                    class="rounded me-3">
                                                                <div>${item.produit.nom}</div>
                                                            </div>
                                                        </td>
                                                        <td>${item.prixUnitaire} DH</td>
                                                        <td>x ${item.quantite}</td>
                                                        <td class="text-end fw-bold">${item.prixUnitaire *
                                                            item.quantite} DH</td>
                                                    </tr>
                                                    <c:set var="totalItems"
                                                        value="${totalItems + (item.prixUnitaire * item.quantite)}" />
                                                </c:forEach>
                                            </tbody>
                                            <tfoot class="table-light">
                                                <tr>
                                                    <td colspan="3" class="text-end fw-bold">Total Général :</td>
                                                    <td class="text-end fw-bold text-success h5">${totalItems} DH</td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="detail-card">
                                    <h4 class="fw-bold mb-4">Informations Client</h4>
                                    <div class="mb-3">
                                        <label class="text-muted small text-uppercase d-block">Nom complet</label>
                                        <span class="fw-bold">${commande.utilisateur.nom}</span>
                                    </div>
                                    <div class="mb-3">
                                        <label class="text-muted small text-uppercase d-block">Email</label>
                                        <span>${commande.utilisateur.email}</span>
                                    </div>
                                    <div class="mb-3">
                                        <label class="text-muted small text-uppercase d-block">Téléphone</label>
                                        <span>${commande.utilisateur.telephone}</span>
                                    </div>
                                    <div class="mb-0">
                                        <label class="text-muted small text-uppercase d-block">Adresse de
                                            livraison</label>
                                        <p class="mb-0">${commande.utilisateur.adresse}</p>
                                    </div>
                                </div>
                                <div class="detail-card">
                                    <h4 class="fw-bold mb-4">Statut</h4>
                                    <div
                                        class="alert ${commande.statut == 'LIVREE' ? 'alert-success' : 'alert-warning'}">
                                        <i class="fas fa-info-circle me-2"></i> Statut actuel :
                                        <strong>${commande.statut}</strong>
                                    </div>
                                    <hr>
                                    <form action="commandes" method="POST">
                                        <input type="hidden" name="id" value="${commande.id}">
                                        <label class="form-label small text-uppercase fw-bold">Changer le statut</label>
                                        <div class="input-group">
                                            <select name="statut" class="form-select">
                                                <option value="EN_ATTENTE" ${commande.statut=='EN_ATTENTE' ? 'selected'
                                                    : '' }>EN ATTENTE</option>
                                                <option value="EN_PREPARATION" ${commande.statut=='EN_PREPARATION'
                                                    ? 'selected' : '' }>EN PRÉPARATION</option>
                                                <option value="EXPEDIEE" ${commande.statut=='EXPEDIEE' ? 'selected' : ''
                                                    }>EXPÉDIÉE</option>
                                                <option value="LIVREE" ${commande.statut=='LIVREE' ? 'selected' : '' }>
                                                    LIVRÉE</option>
                                                <option value="ANNULEE" ${commande.statut=='ANNULEE' ? 'selected' : ''
                                                    }>ANNULÉE</option>
                                            </select>
                                            <button class="btn btn-brand" type="submit">Mettre à jour</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>