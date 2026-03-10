<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Commandes - MaBoutique Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                .status-select {
                    border: 1.5px solid #e2e8f0;
                    border-radius: 8px;
                    padding: 6px 10px;
                    font-size: 0.78rem;
                    font-weight: 600;
                    background: #f8fafc;
                    color: #334155;
                    cursor: pointer;
                    transition: border-color 0.2s;
                }

                .status-select:focus {
                    border-color: #7c3aed;
                    outline: none;
                }
            </style>
        </head>

        <body>
            <div class="container-fluid p-0">
                <div class="d-flex">
                    <c:set var="page" value="commandes" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <div class="admin-main flex-grow-1">
                        <div class="admin-topbar">
                            <div>
                                <div class="topbar-title">Suivi des Commandes</div>
                                <div class="topbar-subtitle">Gérer le cycle de vie des commandes clients</div>
                            </div>
                            <div class="d-flex gap-3">
                                <div
                                    style="background:#ede9fe;color:#7c3aed;padding:8px 18px;border-radius:10px;font-size:0.85rem;font-weight:700;">
                                    ${commandes.size()} commande(s) au total
                                </div>
                            </div>
                        </div>

                        <div class="admin-content">
                            <div class="content-card animate-in">
                                <div class="content-card-body">
                                    <table class="table admin-table mb-0">
                                        <thead>
                                            <tr>
                                                <th># ID</th>
                                                <th>Client</th>
                                                <th>Date</th>
                                                <th>Total</th>
                                                <th>Statut</th>
                                                <th class="text-end">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="c" items="${commandes}">
                                                <tr>
                                                    <td><span class="fw-bold" style="color:#7c3aed;">#${c.id}</span>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex align-items-center gap-2">
                                                            <div
                                                                style="width:34px;height:34px;background:linear-gradient(135deg,#e0f2fe,#bae6fd);border-radius:9px;display:flex;align-items:center;justify-content:center;color:#0284c7;font-size:13px;flex-shrink:0;">
                                                                <i class="fas fa-user"></i>
                                                            </div>
                                                            <div>
                                                                <div class="fw-bold" style="font-size:0.875rem;">
                                                                    ${c.utilisateur.nom}</div>
                                                                <div class="text-muted" style="font-size:0.73rem;">
                                                                    ${c.utilisateur.email}</div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-muted" style="font-size:0.83rem;">${c.dateCommande}
                                                    </td>
                                                    <td>
                                                        <c:set var="totalC" value="0.0" />
                                                        <c:forEach var="item" items="${c.items}">
                                                            <c:set var="totalC"
                                                                value="${totalC + (item.prixUnitaire * item.quantite)}" />
                                                        </c:forEach>
                                                        <span class="fw-bold" style="color:#0891b2;">${totalC} DH</span>
                                                    </td>
                                                    <td>
                                                        <form action="commandes" method="POST"
                                                            style="display:inline-block;">
                                                            <input type="hidden" name="id" value="${c.id}">
                                                            <select name="statut" class="status-select"
                                                                onchange="this.form.submit()">
                                                                <c:forEach var="s" items="${statuts}">
                                                                    <option value="${s}" ${c.statut==s ? 'selected' : ''
                                                                        }>${s}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </form>
                                                    </td>
                                                    <td class="text-end">
                                                        <a href="commandes?action=view&id=${c.id}"
                                                            class="btn-action btn-action-view" title="Voir les détails">
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
                        </div>
                    </div>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>