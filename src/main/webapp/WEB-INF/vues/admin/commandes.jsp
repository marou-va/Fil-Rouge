<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Suivi des Commandes — Admin MaBoutique</title>
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

                .statut-select {
                    max-width: 180px;
                }
            </style>
        </head>

        <body>
            <div class="admin-layout">
                <c:set var="page" value="commandes" scope="request" />
                <jsp:include page="sidebar.jsp" />

                <main class="admin-main">
                    <div class="page-header d-flex justify-content-between align-items-center">
                        <div>
                            <h1 class="h3 fw-bold mb-0">Suivi des Commandes</h1>
                            <small class="text-muted">Gérez les expéditions et les statuts</small>
                        </div>
                        <div class="d-flex gap-3 align-items-center">
                            <!-- Filtres -->
                            <form action="commandes" method="GET"
                                class="d-flex gap-2 align-items-center bg-white p-2 rounded shadow-sm border">
                                <select name="status" class="form-select form-select-sm border-0 shadow-none"
                                    style="width: 140px;">
                                    <option value="">Tous les statuts</option>
                                    <c:forEach var="s" items="${statuts}">
                                        <option value="${s}" ${param.status==s ? 'selected' : '' }>${s}</option>
                                    </c:forEach>
                                </select>
                                <input type="date" name="date" class="form-control form-control-sm border-0 shadow-none"
                                    value="${param.date}" style="width: 130px;">
                                <button type="submit" class="btn btn-sm btn-brand rounded-pill">
                                    <i class="fas fa-filter"></i>
                                </button>
                                <c:if test="${not empty param.status || not empty param.date}">
                                    <a href="commandes" class="btn btn-sm btn-link text-muted p-0"><i
                                            class="fas fa-times"></i></a>
                                </c:if>
                            </form>
                            <div class="badge badge-accent px-3 py-2">
                                <i class="fas fa-shipping-fast me-2"></i>${commandes.size()} commande(s)
                            </div>
                        </div>
                    </div>

                        <div class="card-theme overflow-hidden">
                            <table class="table table-hover align-middle mb-0">
                                <caption>Liste des commandes pour le suivi administratif</caption>
                                <thead style="background:var(--primary-dark);color:#fff;">
                                    <tr>
                                        <th class="ps-3"># ID</th>
                                        <th>Client / Email</th>
                                        <th>Date</th>
                                        <th>Montant Total</th>
                                        <th>Statut Actuel</th>
                                        <th>Actions</th>
                                        <th class="text-end pe-3">Détails</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${commandes}">
                                        <tr>
                                            <td class="ps-3 fw-bold">#${c.id}</td>
                                            <td>
                                                <div class="fw-bold text-brand">${c.utilisateur.nom}</div>
                                                <div class="small text-muted">${c.utilisateur.email}</div>
                                            </td>
                                            <td class="text-muted small">${c.dateCommande}</td>
                                            <td class="fw-bold" style="color:var(--primary-dark);">
                                                <c:set var="totalC" value="0.0" />
                                                <c:forEach var="item" items="${c.items}">
                                                    <c:set var="totalC"
                                                        value="${totalC + (item.prixUnitaire * item.quantite)}" />
                                                </c:forEach>
                                                ${totalC} DH
                                            </td>
                                            <td>
                                                <div class="d-flex align-items-center gap-3">
                                                    <c:choose>
                                                        <c:when test="${c.statut == 'VALIDEE'}">
                                                            <span class="badge rounded-pill"
                                                                style="background:rgba(180,194,190,0.25); color:var(--info);">VALIDÉE</span>
                                                            <form action="commandes" method="POST" class="m-0">
                                                                <input type="hidden" name="id" value="${c.id}">
                                                                <input type="hidden" name="action" value="ship">
                                                                <button type="submit"
                                                                    class="btn btn-xs btn-brand rounded-pill px-2 py-1"
                                                                    style="font-size: 0.7rem;">
                                                                    <i class="fas fa-paper-plane me-1"></i>Expédier
                                                                </button>
                                                            </form>
                                                        </c:when>
                                                        <c:when test="${c.statut == 'EN_COURS'}">
                                                            <span class="badge rounded-pill"
                                                                style="background:rgba(142,153,121,0.15); color:var(--primary);">EN
                                                                LIVRAISON</span>
                                                        </c:when>
                                                        <c:when test="${c.statut == 'LIVREE'}">
                                                            <span class="badge rounded-pill"
                                                                style="background:rgba(105,110,91,0.2); color:var(--primary-dark);">LIVRÉE
                                                                ✅</span>
                                                        </c:when>
                                                        <c:when test="${c.statut == 'ANNULEE'}">
                                                            <span class="badge rounded-pill"
                                                                style="background:rgba(163,124,122,0.15); color:var(--accent);">ANNULÉE</span>
                                                        </c:when>
                                                    </c:choose>
                                                </div>
                                            </td>
                                            <td>
                                                <!-- Actions rapides si besoin -->
                                            </td>
                                            <td class="text-end pe-3">
                                                <a href="commandes?action=view&id=${c.id}"
                                                    class="btn btn-sm btn-outline-brand rounded-circle p-2"
                                                    title="Détails">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty commandes}">
                                        <tr>
                                            <td colspan="6" class="text-center py-5 text-muted">Aucune commande
                                                enregistrée.</td>
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