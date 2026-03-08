<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Mon Historique - MaBoutique</title>

                <!-- Google Fonts -->
                <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">

                <!-- Font Awesome -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

                <!-- DataTables CSS -->
                <link rel="stylesheet" type="text/css"
                    href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
                <link rel="stylesheet" type="text/css"
                    href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.bootstrap5.min.css">

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

                    .table thead th {
                        background-color: #f8f9fa;
                        color: #333;
                        border-bottom: 2px solid #eee;
                        padding: 15px;
                        font-weight: 600;
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

                    .order-total {
                        font-weight: 700;
                        color: var(--brand-color);
                    }

                    /* DataTables Custom Styling */
                    .dataTables_wrapper .dataTables_paginate .paginate_button.current {
                        background: var(--brand-color) !important;
                        border: none !important;
                        color: white !important;
                        border-radius: 5px;
                    }

                    .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
                        background: var(--brand-dark) !important;
                        color: white !important;
                        border: none !important;
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
                                <p class="mb-0 text-white-50"><i class="fas fa-history me-2"></i>Historique des
                                    commandes</p>
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
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h5 class="fw-bold mb-0">Mes Commandes</h5>
                                    <c:if test="${not empty commandes}">
                                        <span
                                            class="badge bg-light text-brand rounded-pill px-3 py-2 border">${commandes.size()}
                                            commande(s)</span>
                                    </c:if>
                                </div>

                                <c:if test="${empty commandes}">
                                    <div class="text-center py-5">
                                        <i class="fas fa-box-open fa-4x mb-4 text-muted opacity-25"></i>
                                        <h4 class="text-muted">Aucune commande pour le moment.</h4>
                                        <a href="catalogue" class="btn btn-brand mt-3 px-4 py-2">Découvrir nos
                                            produits</a>
                                    </div>
                                </c:if>

                                <c:if test="${not empty commandes}">
                                    <div class="table-responsive">
                                        <table id="orderHistoryTable" class="table table-hover align-middle w-100">
                                            <thead>
                                                <tr>
                                                    <th>N° Commande</th>
                                                    <th>Date</th>
                                                    <th>Statut</th>
                                                    <th class="text-end">Total</th>
                                                    <th class="text-center">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="commande" items="${commandes}">
                                                    <tr>
                                                        <td><span class="fw-bold text-dark">#${commande.id}</span></td>
                                                        <td class="text-muted">
                                                            <small>
                                                                <fmt:parseDate value="${commande.dateCommande}"
                                                                    pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate"
                                                                    type="both" />
                                                                <fmt:formatDate value="${parsedDate}"
                                                                    pattern="dd MMM yyyy HH:mm" />
                                                            </small>
                                                        </td>
                                                        <td>
                                                            <span class="badge-status badge-${commande.statut}">
                                                                <i class="fas fa-circle-info me-1 small"></i>
                                                                ${commande.statut}
                                                            </span>
                                                        </td>
                                                        <td class="text-end">
                                                            <c:set var="total" value="0" />
                                                            <c:forEach var="item" items="${commande.items}">
                                                                <c:set var="total"
                                                                    value="${total + (item.prixUnitaire * item.quantite)}" />
                                                            </c:forEach>
                                                            <span class="order-total fw-bold">${total} MAD</span>
                                                        </td>
                                                        <td class="text-center">
                                                            <a href="commande-detail?id=${commande.id}"
                                                                class="btn btn-outline-dark btn-sm rounded-pill px-3">
                                                                <i class="fas fa-eye me-1"></i> Détails
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="includes/footer.jsp" />

                <!-- Scripts -->
                <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script type="text/javascript"
                    src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
                <script type="text/javascript"
                    src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
                <script type="text/javascript"
                    src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
                <script type="text/javascript"
                    src="https://cdn.datatables.net/responsive/2.5.0/js/responsive.bootstrap5.min.js"></script>

                <script>
                    $(document).ready(function () {
                        $('#orderHistoryTable').DataTable({
                            responsive: true,
                            language: {
                                url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json'
                            },
                            order: [[1, 'desc']],
                            pageLength: 5,
                            lengthMenu: [5, 10, 25],
                            columnDefs: [
                                { orderable: false, targets: [4] }
                            ],
                            dom: '<"d-flex justify-content-between align-items-center mb-3"lf>rt<"d-flex justify-content-between align-items-center mt-3"ip>'
                        });
                    });
                </script>
            </body>

            </html>