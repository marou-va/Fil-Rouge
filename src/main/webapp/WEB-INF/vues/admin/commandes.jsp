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
                        <div class="badge badge-accent px-3 py-2">
                            <i class="fas fa-shipping-fast me-2"></i>${commandes.size()} commande(s) au total
                        </div>
                    </div>

                    <div class="card-theme overflow-hidden">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead style="background:var(--primary-dark);color:#fff;">
                                    <tr>
                                        <th class="ps-3"># ID</th>
                                        <th>Client / Email</th>
                                        <th>Date</th>
                                        <th>Montant Total</th>
                                        <th>Modifier le Statut</th>
                                        <th class="text-end pe-3">Action</th>
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
                                                <form action="commandes" method="POST" class="m-0 statut-select">
                                                    <input type="hidden" name="id" value="${c.id}">
                                                    <select name="statut" class="form-select form-select-sm shadow-none"
                                                        onchange="this.form.submit()"
                                                        style="border-radius:20px; font-weight:600; font-size:.78rem; 
                                                       ${c.statut == 'VALIDEE' ? 'background-color:rgba(180,194,190,0.25); border-color:var(--info);' : ''}
                                                       ${c.statut == 'EN_COURS' ? 'background-color:rgba(142,153,121,0.15); border-color:var(--primary);' : ''}
                                                       ${c.statut == 'LIVREE' ? 'background-color:rgba(105,110,91,0.2); border-color:var(--primary-dark);' : ''}
                                                       ${c.statut == 'ANNULEE' ? 'background-color:rgba(163,124,122,0.15); border-color:var(--accent);' : ''}">
                                                        <c:forEach var="s" items="${statuts}">
                                                            <option value="${s}" ${c.statut==s ? 'selected' : '' }>${s}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </form>
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