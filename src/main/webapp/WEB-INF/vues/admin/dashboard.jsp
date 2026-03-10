<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Dashboard — Admin MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
            <style>
                body {
                    background: var(--bg);
                }

                .admin-layout {
                    min-height: 100vh;
                    display: flex;
                }

                .admin-main {
                    flex: 1;
                    padding: 2rem;
                    overflow-x: hidden;
                }

                .page-header {
                    border-bottom: 1px solid var(--border-color);
                    padding-bottom: 1rem;
                    margin-bottom: 2rem;
                }

                .stat-badge {
                    font-size: 0.68rem;
                    font-weight: 700;
                    padding: 3px 8px;
                    border-radius: 20px;
                }
            </style>
        </head>

        <body>
            <div class="admin-layout">
                <c:set var="page" value="dashboard" scope="request" />
                <jsp:include page="sidebar.jsp" />

                <main class="admin-main">
                    <div class="page-header d-flex justify-content-between align-items-center">
                        <div>
                            <h1 class="h3 fw-bold mb-0">Tableau de Bord</h1>
                            <small class="text-muted">Vue d'ensemble en temps réel</small>
                        </div>
                        <div class="text-muted small">
                            <i class="fas fa-user-shield me-1" style="color:var(--primary);"></i>
                            ${sessionScope.utilisateur.nom}
                        </div>
                    </div>

                    <!-- Stat Cards -->
                    <div class="row g-3 mb-4">
                        <div class="col-sm-6 col-xl-3">
                            <div class="stat-card stat-green">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <div class="stat-label">Commandes</div>
                                        <div class="stat-value">${totalCommandes}</div>
                                    </div>
                                    <i class="fas fa-receipt stat-icon"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-xl-3">
                            <div class="stat-card stat-rose">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <div class="stat-label">Ventes réussies</div>
                                        <div class="stat-value">${totalVentes}</div>
                                    </div>
                                    <i class="fas fa-check-circle stat-icon"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-xl-3">
                            <div class="stat-card stat-beige">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <div class="stat-label">Produits actifs</div>
                                        <div class="stat-value">${totalProduits}</div>
                                    </div>
                                    <i class="fas fa-box-open stat-icon"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-xl-3">
                            <div class="stat-card stat-teal">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <div class="stat-label">Utilisateurs</div>
                                        <div class="stat-value">${totalUsers}</div>
                                    </div>
                                    <i class="fas fa-users stat-icon"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Alertes stock faible -->
                    <c:if test="${not empty lowStockProducts}">
                        <div class="card-theme mb-4" style="border-left:4px solid var(--accent);">
                            <div class="p-3 border-bottom d-flex align-items-center gap-2"
                                style="border-color:var(--border-color)!important;">
                                <i class="fas fa-exclamation-triangle" style="color:var(--accent);"></i>
                                <span class="fw-bold">Stock faible — action requise</span>
                                <span class="badge"
                                    style="background:var(--accent);color:#fff;">${lowStockProducts.size()}</span>
                            </div>
                            <div class="p-3">
                                <c:forEach var="p" items="${lowStockProducts}">
                                    <div class="d-flex justify-content-between align-items-center py-1 border-bottom"
                                        style="border-color:var(--border-color)!important;">
                                        <span class="small fw-bold">${p.nom}</span>
                                        <div class="d-flex align-items-center gap-2">
                                            <span class="badge"
                                                style="background:rgba(163,124,122,0.18);color:var(--accent);">${p.stock}
                                                restant(s)</span>
                                            <a href="produits?action=edit&id=${p.id}"
                                                class="btn btn-sm btn-brand py-0 px-2"
                                                style="font-size:.75rem;">Gérer</a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>

                    <!-- Commandes récentes -->
                    <div class="card-theme">
                        <div class="p-3 d-flex justify-content-between align-items-center border-bottom"
                            style="border-color:var(--border-color)!important;">
                            <h5 class="fw-bold mb-0">Commandes Récentes</h5>
                            <a href="commandes" class="btn btn-brand btn-sm">Tout voir</a>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead style="background:var(--primary-dark);color:#fff;">
                                    <tr>
                                        <th class="ps-3">#ID</th>
                                        <th>Client</th>
                                        <th>Date</th>
                                        <th>Statut</th>
                                        <th>Total</th>
                                        <th class="text-end pe-3">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${recentCommandes}">
                                        <tr>
                                            <td class="ps-3 fw-bold">#${c.id}</td>
                                            <td>${c.utilisateur.nom}</td>
                                            <td class="text-muted small">${c.dateCommande}</td>
                                            <td>
                                                <span class="badge rounded-pill stat-badge
                                        ${c.statut == 'VALIDEE' ? 'bg-success' : ''}
                                        ${c.statut == 'EN_COURS' ? 'bg-info text-dark' : ''}
                                        ${c.statut == 'ANNULEE' ? 'bg-danger' : ''}"
                                                    style="${c.statut == 'VALIDEE' ? 'background:rgba(142,153,121,0.2); color:var(--primary-dark);' : ''}
                                                           ${c.statut == 'EN_COURS' ? 'background:rgba(180,194,190,0.3); color:var(--text-dark);' : ''}
                                                           ${c.statut == 'ANNULEE' ? 'background:rgba(163,124,122,0.2); color:var(--accent);' : ''}">
                                                    ${c.statut}
                                                </span>
                                            </td>
                                            <td class="fw-bold">
                                                <c:set var="total" value="0.0" />
                                                <c:forEach var="item" items="${c.items}">
                                                    <c:set var="total"
                                                        value="${total + item.prixUnitaire * item.quantite}" />
                                                </c:forEach>
                                                ${total} DH
                                            </td>
                                            <td class="text-end pe-3">
                                                <a href="commandes?action=view&id=${c.id}"
                                                    class="btn btn-sm btn-outline-brand">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty recentCommandes}">
                                        <tr>
                                            <td colspan="6" class="text-center py-4 text-muted">Aucune commande pour
                                                l'instant.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </main>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>