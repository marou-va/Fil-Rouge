<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Détail Commande #${commande.id} - Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body>
            <div class="container-fluid p-0">
                <div class="d-flex">
                    <c:set var="page" value="commandes" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <div class="admin-main flex-grow-1">
                        <div class="admin-topbar">
                            <div>
                                <div class="topbar-title">Commande <span style="color:#7c3aed;">#${commande.id}</span>
                                </div>
                                <nav class="breadcrumb-admin mt-1">
                                    <a href="commandes">← Retour aux commandes</a>
                                </nav>
                            </div>
                            <div>
                                <c:choose>
                                    <c:when test="${commande.statut == 'EN_ATTENTE'}"><span
                                            class="badge-status badge-attente"
                                            style="font-size:0.85rem;padding:8px 18px;">EN ATTENTE</span></c:when>
                                    <c:when test="${commande.statut == 'EN_PREPARATION'}"><span
                                            class="badge-status badge-preparation"
                                            style="font-size:0.85rem;padding:8px 18px;">EN PRÉPARATION</span></c:when>
                                    <c:when test="${commande.statut == 'EXPEDIEE'}"><span
                                            class="badge-status badge-expediee"
                                            style="font-size:0.85rem;padding:8px 18px;">EXPÉDIÉE</span></c:when>
                                    <c:when test="${commande.statut == 'LIVREE'}"><span
                                            class="badge-status badge-livree"
                                            style="font-size:0.85rem;padding:8px 18px;">LIVRÉE ✓</span></c:when>
                                    <c:otherwise><span class="badge-status badge-annulee"
                                            style="font-size:0.85rem;padding:8px 18px;">ANNULÉE</span></c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="admin-content">
                            <div class="row g-4">
                                <!-- Items -->
                                <div class="col-lg-8">
                                    <div class="content-card animate-in">
                                        <div class="content-card-header">
                                            <span class="content-card-title"><i class="fas fa-box-open me-2"
                                                    style="color:#7c3aed;"></i>Articles commandés</span>
                                            <span style="font-size:0.8rem;color:#94a3b8;">${commande.items.size()}
                                                article(s)</span>
                                        </div>
                                        <div class="content-card-body">
                                            <table class="table admin-table mb-0">
                                                <thead>
                                                    <tr>
                                                        <th>Produit</th>
                                                        <th>Prix unitaire</th>
                                                        <th>Qté</th>
                                                        <th class="text-end">Sous-total</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:set var="totalItems" value="0.0" />
                                                    <c:forEach var="item" items="${commande.items}">
                                                        <tr>
                                                            <td>
                                                                <div class="d-flex align-items-center gap-3">
                                                                    <img src="${item.produit.imageUrl}"
                                                                        alt="${item.produit.nom}"
                                                                        style="width:44px;height:44px;object-fit:cover;border-radius:10px;"
                                                                        onerror="this.src='https://placehold.co/44x44/f3f4f6/94a3b8?text=IMG'">
                                                                    <div class="fw-bold">${item.produit.nom}</div>
                                                                </div>
                                                            </td>
                                                            <td>${item.prixUnitaire} DH</td>
                                                            <td><span
                                                                    style="background:#f1f5f9;padding:3px 10px;border-radius:6px;font-weight:600;">×${item.quantite}</span>
                                                            </td>
                                                            <td class="text-end fw-bold" style="color:#7c3aed;">
                                                                ${item.prixUnitaire * item.quantite} DH</td>
                                                        </tr>
                                                        <c:set var="totalItems"
                                                            value="${totalItems + (item.prixUnitaire * item.quantite)}" />
                                                    </c:forEach>
                                                </tbody>
                                                <tfoot>
                                                    <tr style="background:#fafbff;">
                                                        <td colspan="3" class="text-end fw-bold py-3"
                                                            style="color:#334155;">TOTAL GÉNÉRAL</td>
                                                        <td class="text-end py-3">
                                                            <span
                                                                style="font-size:1.25rem;font-weight:800;color:#7c3aed;">${totalItems}
                                                                DH</span>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                                <!-- Side Info -->
                                <div class="col-lg-4">
                                    <!-- Client Info -->
                                    <div class="content-card animate-in delay-1 mb-4">
                                        <div class="content-card-header">
                                            <span class="content-card-title"><i class="fas fa-user me-2"
                                                    style="color:#0891b2;"></i>Informations Client</span>
                                        </div>
                                        <div class="p-4">
                                            <div class="d-flex align-items-center gap-3 mb-4">
                                                <div
                                                    style="width:48px;height:48px;background:linear-gradient(135deg,#e0f2fe,#bae6fd);border-radius:12px;display:flex;align-items:center;justify-content:center;color:#0284c7;font-size:20px;flex-shrink:0;">
                                                    <i class="fas fa-user"></i>
                                                </div>
                                                <div>
                                                    <div class="fw-bold" style="color:#0f172a;">
                                                        ${commande.utilisateur.nom}</div>
                                                    <div style="font-size:0.8rem;color:#94a3b8;">Client</div>
                                                </div>
                                            </div>
                                            <div class="d-flex flex-column gap-3">
                                                <div>
                                                    <div class="form-label-admin mb-0">Email</div>
                                                    <div style="font-size:0.875rem;">${commande.utilisateur.email}</div>
                                                </div>
                                                <div>
                                                    <div class="form-label-admin mb-0">Téléphone</div>
                                                    <div style="font-size:0.875rem;">${commande.utilisateur.telephone}
                                                    </div>
                                                </div>
                                                <div>
                                                    <div class="form-label-admin mb-0">Adresse de livraison</div>
                                                    <div style="font-size:0.875rem;color:#334155;line-height:1.5;">
                                                        ${commande.utilisateur.adresse}</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Status Update -->
                                    <div class="content-card animate-in delay-2">
                                        <div class="content-card-header">
                                            <span class="content-card-title"><i class="fas fa-sync me-2"
                                                    style="color:#7c3aed;"></i>Mettre à jour</span>
                                        </div>
                                        <div class="p-4">
                                            <form action="commandes" method="POST">
                                                <input type="hidden" name="id" value="${commande.id}">
                                                <label class="form-label-admin mb-3 d-block">Nouveau statut</label>

                                                <div class="d-flex flex-column gap-2 mb-4">
                                                    <c:set var="statuts"
                                                        value="EN_ATTENTE,EN_PREPARATION,EXPEDIEE,LIVREE,ANNULEE" />
                                                    <label class="d-flex align-items-center gap-2 p-2 rounded"
                                                        style="cursor:pointer;background:${commande.statut == 'EN_ATTENTE' ? '#fef3c7' : 'transparent'};border:1px solid ${commande.statut == 'EN_ATTENTE' ? '#f59e0b' : '#f1f5f9'}">
                                                        <input type="radio" name="statut" value="EN_ATTENTE"
                                                            ${commande.statut=='EN_ATTENTE' ? 'checked' : '' }>
                                                        <span class="badge-status badge-attente">EN ATTENTE</span>
                                                    </label>
                                                    <label class="d-flex align-items-center gap-2 p-2 rounded"
                                                        style="cursor:pointer;background:${commande.statut == 'EN_PREPARATION' ? '#dbeafe' : 'transparent'};border:1px solid ${commande.statut == 'EN_PREPARATION' ? '#3b82f6' : '#f1f5f9'}">
                                                        <input type="radio" name="statut" value="EN_PREPARATION"
                                                            ${commande.statut=='EN_PREPARATION' ? 'checked' : '' }>
                                                        <span class="badge-status badge-preparation">EN
                                                            PRÉPARATION</span>
                                                    </label>
                                                    <label class="d-flex align-items-center gap-2 p-2 rounded"
                                                        style="cursor:pointer;background:${commande.statut == 'EXPEDIEE' ? '#d1fae5' : 'transparent'};border:1px solid ${commande.statut == 'EXPEDIEE' ? '#22c55e' : '#f1f5f9'}">
                                                        <input type="radio" name="statut" value="EXPEDIEE"
                                                            ${commande.statut=='EXPEDIEE' ? 'checked' : '' }>
                                                        <span class="badge-status badge-expediee">EXPÉDIÉE</span>
                                                    </label>
                                                    <label class="d-flex align-items-center gap-2 p-2 rounded"
                                                        style="cursor:pointer;background:${commande.statut == 'LIVREE' ? '#dcfce7' : 'transparent'};border:1px solid ${commande.statut == 'LIVREE' ? '#16a34a' : '#f1f5f9'}">
                                                        <input type="radio" name="statut" value="LIVREE"
                                                            ${commande.statut=='LIVREE' ? 'checked' : '' }>
                                                        <span class="badge-status badge-livree">LIVRÉE</span>
                                                    </label>
                                                    <label class="d-flex align-items-center gap-2 p-2 rounded"
                                                        style="cursor:pointer;background:${commande.statut == 'ANNULEE' ? '#fee2e2' : 'transparent'};border:1px solid ${commande.statut == 'ANNULEE' ? '#ef4444' : '#f1f5f9'}">
                                                        <input type="radio" name="statut" value="ANNULEE"
                                                            ${commande.statut=='ANNULEE' ? 'checked' : '' }>
                                                        <span class="badge-status badge-annulee">ANNULÉE</span>
                                                    </label>
                                                </div>

                                                <button type="submit"
                                                    class="btn-primary-admin w-100 d-flex justify-content-center">
                                                    <i class="fas fa-save me-2"></i> Sauvegarder le statut
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>