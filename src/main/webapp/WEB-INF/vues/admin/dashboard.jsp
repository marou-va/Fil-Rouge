<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Dashboard Admin - MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body>
            <div class="container-fluid p-0">
                <div class="d-flex">

                    <c:set var="page" value="dashboard" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <div class="admin-main flex-grow-1">
                        <!-- Topbar -->
                        <div class="admin-topbar">
                            <div>
                                <div class="topbar-title">Dashboard</div>
                                <div class="topbar-subtitle">Vue d'ensemble de votre boutique</div>
                            </div>
                            <div class="d-flex align-items-center gap-3">
                                <div class="topbar-date text-muted small">
                                    <i class="fas fa-calendar-alt me-1"></i> Mis à jour maintenant
                                </div>
                                <a href="produits?action=add" class="btn-primary-admin d-flex align-items-center gap-2">
                                    <i class="fas fa-plus"></i> Nouveau produit
                                </a>
                            </div>
                        </div>

                        <div class="admin-content">

                            <!-- Stats Cards -->
                            <div class="row g-4 mb-4">
                                <div class="col-xl-3 col-md-6 animate-in delay-1">
                                    <div class="stat-card card-violet h-100">
                                        <div class="card-body">
                                            <div class="stat-card-icon" style="background:rgba(255,255,255,0.2);">
                                                <i class="fas fa-shopping-bag"></i>
                                            </div>
                                            <div class="stat-card-value">${totalCommandes}</div>
                                            <div class="stat-card-label">Total Commandes</div>
                                            <div class="stat-card-bg"><i class="fas fa-shopping-bag"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6 animate-in delay-2">
                                    <div class="stat-card card-teal h-100">
                                        <div class="card-body">
                                            <div class="stat-card-icon" style="background:rgba(255,255,255,0.2);">
                                                <i class="fas fa-check-double"></i>
                                            </div>
                                            <div class="stat-card-value">${totalVentes}</div>
                                            <div class="stat-card-label">Ventes Réussies</div>
                                            <div class="stat-card-bg"><i class="fas fa-check-double"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6 animate-in delay-3">
                                    <div class="stat-card card-amber h-100">
                                        <div class="card-body">
                                            <div class="stat-card-icon" style="background:rgba(255,255,255,0.2);">
                                                <i class="fas fa-box-open"></i>
                                            </div>
                                            <div class="stat-card-value">${totalProduits}</div>
                                            <div class="stat-card-label">Produits Actifs</div>
                                            <div class="stat-card-bg"><i class="fas fa-box-open"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6 animate-in delay-4">
                                    <div class="stat-card card-rose h-100">
                                        <div class="card-body">
                                            <div class="stat-card-icon" style="background:rgba(255,255,255,0.2);">
                                                <i class="fas fa-users"></i>
                                            </div>
                                            <div class="stat-card-value">${totalUsers}</div>
                                            <div class="stat-card-label">Utilisateurs</div>
                                            <div class="stat-card-bg"><i class="fas fa-users"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Low Stock Alert -->
                            <c:if test="${not empty lowStockProducts}">
                                <div class="animate-in mb-4">
                                    <div class="content-card">
                                        <div class="content-card-header"
                                            style="background:linear-gradient(90deg,#fffbeb,#fef3c7); border-left: 4px solid #f59e0b;">
                                            <div class="d-flex align-items-center gap-2">
                                                <div
                                                    style="width:32px;height:32px;background:#f59e0b;border-radius:8px;display:flex;align-items:center;justify-content:center;color:white;font-size:14px;">
                                                    <i class="fas fa-exclamation-triangle"></i>
                                                </div>
                                                <span class="content-card-title" style="color:#92400e;">Stocks faibles —
                                                    Action requise</span>
                                            </div>
                                            <span class="badge"
                                                style="background:#f59e0b;color:white;border-radius:20px;font-size:0.72rem;padding:5px 12px;">${lowStockProducts.size()}
                                                produit(s)</span>
                                        </div>
                                        <div class="content-card-body">
                                            <table class="table admin-table mb-0">
                                                <thead>
                                                    <tr>
                                                        <th>Produit</th>
                                                        <th>Stock actuel</th>
                                                        <th class="text-end">Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="p" items="${lowStockProducts}">
                                                        <tr>
                                                            <td class="fw-600">${p.nom}</td>
                                                            <td><span class="badge-status badge-annulee">${p.stock}
                                                                    restant(s)</span></td>
                                                            <td class="text-end">
                                                                <a href="produits?action=edit&id=${p.id}"
                                                                    class="btn-action btn-action-edit">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Recent Orders -->
                            <div class="animate-in">
                                <div class="content-card">
                                    <div class="content-card-header">
                                        <span class="content-card-title">Dernières Commandes</span>
                                        <a href="commandes" class="btn-secondary-admin py-2 px-3"
                                            style="font-size:0.8rem;">Voir tout <i
                                                class="fas fa-arrow-right ms-1"></i></a>
                                    </div>
                                    <div class="content-card-body">
                                        <table class="table admin-table mb-0">
                                            <thead>
                                                <tr>
                                                    <th># ID</th>
                                                    <th>Client</th>
                                                    <th>Date</th>
                                                    <th>Statut</th>
                                                    <th>Total</th>
                                                    <th class="text-end">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="c" items="${recentCommandes}">
                                                    <tr>
                                                        <td><span class="fw-bold" style="color:#7c3aed;">#${c.id}</span>
                                                        </td>
                                                        <td>
                                                            <div class="d-flex align-items-center gap-2">
                                                                <div
                                                                    style="width:32px;height:32px;background:linear-gradient(135deg,#ede9fe,#ddd6fe);border-radius:8px;display:flex;align-items:center;justify-content:center;color:#7c3aed;font-size:12px;">
                                                                    <i class="fas fa-user"></i>
                                                                </div>
                                                                <span class="fw-500">${c.utilisateur.nom}</span>
                                                            </div>
                                                        </td>
                                                        <td class="text-muted">${c.dateCommande}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${c.statut == 'EN_ATTENTE'}"><span
                                                                        class="badge-status badge-attente">EN
                                                                        ATTENTE</span></c:when>
                                                                <c:when test="${c.statut == 'EN_PREPARATION'}"><span
                                                                        class="badge-status badge-preparation">EN
                                                                        PRÉPARATION</span></c:when>
                                                                <c:when test="${c.statut == 'EXPEDIEE'}"><span
                                                                        class="badge-status badge-expediee">EXPÉDIÉE</span>
                                                                </c:when>
                                                                <c:when test="${c.statut == 'LIVREE'}"><span
                                                                        class="badge-status badge-livree">LIVRÉE</span>
                                                                </c:when>
                                                                <c:otherwise><span
                                                                        class="badge-status badge-annulee">ANNULÉE</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:set var="total" value="0.0" />
                                                            <c:forEach var="item" items="${c.items}">
                                                                <c:set var="total"
                                                                    value="${total + (item.prixUnitaire * item.quantite)}" />
                                                            </c:forEach>
                                                            <span class="fw-bold" style="color:#0891b2;">${total}
                                                                DH</span>
                                                        </td>
                                                        <td class="text-end">
                                                            <a href="commandes?action=view&id=${c.id}"
                                                                class="btn-action btn-action-view">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                <c:if test="${empty recentCommandes}">
                                                    <tr>
                                                        <td colspan="6" class="text-center py-5 text-muted">Aucune
                                                            commande pour le moment.</td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                        </div><!-- /admin-content -->
                    </div><!-- /admin-main -->
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>