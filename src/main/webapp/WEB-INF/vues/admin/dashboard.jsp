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
            <style>
                :root {
                    --brand-color: #f68b1e;
                    --brand-dark: #e57a10;
                }

                body {
                    background-color: #f8f9fa;
                }

                .stats-card {
                    border: none;
                    border-radius: 15px;
                    transition: transform 0.3s;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                }

                .stats-card:hover {
                    transform: translateY(-5px);
                }

                .bg-gradient-primary {
                    background: linear-gradient(45deg, #4e73df, #224abe);
                    color: white;
                }

                .bg-gradient-success {
                    background: linear-gradient(45deg, #1cc88a, #13855c);
                    color: white;
                }

                .bg-gradient-warning {
                    background: linear-gradient(45deg, #f6c23e, #dda20a);
                    color: white;
                }

                .bg-gradient-info {
                    background: linear-gradient(45deg, #36b9cc, #258391);
                    color: white;
                }

                .table-responsive {
                    background: white;
                    border-radius: 15px;
                    padding: 20px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                }
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- Sidebar -->
                    <c:set var="page" value="dashboard" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <!-- Main content -->
                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                        <div
                            class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                            <h1 class="h2">Tableau de Bord</h1>
                            <div class="btn-toolbar mb-2 mb-md-0">
                                <button type="button" class="btn btn-sm btn-outline-secondary dropdown-toggle">
                                    <i class="fas fa-calendar-alt me-1"></i> Aujourd'hui
                                </button>
                            </div>
                        </div>

                        <!-- Stats Cards -->
                        <div class="row g-4 mb-5">
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-gradient-primary stats-card h-100">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <div class="text-white-50 small text-uppercase fw-bold">Commandes
                                                    Totales</div>
                                                <div class="h3 fw-bold mb-0">${totalCommandes}</div>
                                            </div>
                                            <i class="fas fa-shopping-cart fa-2x text-white-50"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-gradient-success stats-card h-100">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <div class="text-white-50 small text-uppercase fw-bold">Ventes Réussies
                                                </div>
                                                <div class="h3 fw-bold mb-0">${totalVentes}</div>
                                            </div>
                                            <i class="fas fa-check-circle fa-2x text-white-50"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-gradient-warning stats-card h-100">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <div class="text-white-50 small text-uppercase fw-bold">Produits en
                                                    Stock</div>
                                                <div class="h3 fw-bold mb-0">${totalProduits}</div>
                                            </div>
                                            <i class="fas fa-box fa-2x text-white-50"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-gradient-info stats-card h-100">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <div class="text-white-50 small text-uppercase fw-bold">Utilisateurs
                                                </div>
                                                <div class="h3 fw-bold mb-0">--</div>
                                            </div>
                                            <i class="fas fa-users fa-2x text-white-50"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Low Stock Alerts -->
                        <c:if test="${not empty lowStockProducts}">
                            <div class="row mb-5">
                                <div class="col-12">
                                    <div class="card border-warning shadow-sm">
                                        <div class="card-header bg-warning text-dark fw-bold">
                                            <i class="fas fa-exclamation-triangle me-2"></i> Alertes Stock Faible
                                        </div>
                                        <div class="card-body p-0">
                                            <div class="table-responsive border-0 shadow-none">
                                                <table class="table table-sm table-hover mb-0 align-middle">
                                                    <thead>
                                                        <tr>
                                                            <th class="ps-3">Produit</th>
                                                            <th>Stock Actuel</th>
                                                            <th class="text-end pe-3">Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="p" items="${lowStockProducts}">
                                                            <tr>
                                                                <td class="ps-3">${p.nom}</td>
                                                                <td><span
                                                                        class="badge bg-danger text-white">${p.stock}</span>
                                                                </td>
                                                                <td class="text-end pe-3">
                                                                    <a href="produits?action=edit&id=${p.id}"
                                                                        class="btn btn-sm btn-link text-brand">Gérer</a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Recent Orders -->
                        <div class="row">
                            <div class="col-12">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h4 class="mb-0">Dernières Commandes</h4>
                                    <a href="commandes" class="btn btn-sm btn-brand text-white fw-bold">Tout voir</a>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th>ID</th>
                                                <th>Client</th>
                                                <th>Date</th>
                                                <th>Statut</th>
                                                <th>Total</th>
                                                <th class="text-end">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="c" items="${recentCommandes}">
                                                <tr>
                                                    <td class="fw-bold">#${c.id}</td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <div class="avatar-sm bg-light text-brand rounded-circle me-3 d-flex align-items-center justify-content-center"
                                                                style="width: 32px; height: 32px;">
                                                                <i class="fas fa-user small"></i>
                                                            </div>
                                                            <div>${c.utilisateur.nom}</div>
                                                        </div>
                                                    </td>
                                                    <td>${c.dateCommande}</td>
                                                    <td>
                                                        <span
                                                            class="badge ${c.statut == 'LIVREE' ? 'bg-success' : (c.statut == 'EN_PREPARATION' ? 'bg-primary' : (c.statut == 'ANNULEE' ? 'bg-danger' : 'bg-warning'))}">
                                                            ${c.statut}
                                                        </span>
                                                    </td>
                                                    <td class="fw-bold">
                                                        <c:set var="total" value="0.0" />
                                                        <c:forEach var="item" items="${c.items}">
                                                            <c:set var="total"
                                                                value="${total + (item.prixUnitaire * item.quantite)}" />
                                                        </c:forEach>
                                                        ${total} DH
                                                    </td>
                                                    <td class="text-end">
                                                        <a href="commande-detail?id=${c.id}"
                                                            class="btn btn-sm btn-light border">
                                                            <i class="fas fa-eye text-muted"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty recentCommandes}">
                                                <tr>
                                                    <td colspan="6" class="text-center py-4 text-muted">Aucune commande
                                                        récente.</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>