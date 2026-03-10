<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Utilisateurs - MaBoutique Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body>
            <div class="container-fluid p-0">
                <div class="d-flex">
                    <c:set var="page" value="utilisateurs" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <div class="admin-main flex-grow-1">
                        <div class="admin-topbar">
                            <div>
                                <div class="topbar-title">Gestion des Utilisateurs</div>
                                <div class="topbar-subtitle">Contrôler les rôles et accès des membres</div>
                            </div>
                            <div
                                style="background:#ede9fe;color:#7c3aed;padding:8px 18px;border-radius:10px;font-size:0.85rem;font-weight:700;">
                                ${utilisateurs.size()} membre(s)
                            </div>
                        </div>

                        <div class="admin-content">
                            <div class="content-card animate-in">
                                <div class="content-card-body">
                                    <table class="table admin-table mb-0">
                                        <thead>
                                            <tr>
                                                <th>Utilisateur</th>
                                                <th>Email</th>
                                                <th>Téléphone</th>
                                                <th>Membre depuis</th>
                                                <th>Rôle</th>
                                                <th class="text-end">Accès</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="u" items="${utilisateurs}">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center gap-3">
                                                            <div
                                                                style="width:40px;height:40px;background:${u.role == 'ADMIN' ? 'linear-gradient(135deg,#fee2e2,#fecaca)' : 'linear-gradient(135deg,#ede9fe,#ddd6fe)'};border-radius:11px;display:flex;align-items:center;justify-content:center;color:${u.role == 'ADMIN' ? '#dc2626' : '#7c3aed'};font-size:15px;flex-shrink:0;">
                                                                <i
                                                                    class="fas ${u.role == 'ADMIN' ? 'fa-user-shield' : 'fa-user'}"></i>
                                                            </div>
                                                            <div>
                                                                <div class="fw-bold" style="color:#0f172a;">${u.nom}
                                                                    <c:if
                                                                        test="${sessionScope.utilisateur.email == u.email}">
                                                                        <span
                                                                            style="font-size:0.7rem;background:#ede9fe;color:#7c3aed;padding:2px 8px;border-radius:10px;margin-left:4px;font-weight:600;">Vous</span>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td style="color:#64748b;">${u.email}</td>
                                                    <td style="color:#64748b;">${u.telephone}</td>
                                                    <td style="color:#94a3b8;font-size:0.83rem;">${u.dateCreation}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${u.role == 'ADMIN'}">
                                                                <span class="badge-status badge-annulee">ADMIN</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span
                                                                    class="badge-status badge-preparation">CLIENT</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-end">
                                                        <c:if test="${sessionScope.utilisateur.email != u.email}">
                                                            <a href="utilisateurs?action=toggleRole&email=${u.email}"
                                                                onclick="return confirm('Changer le rôle de ${u.nom} ?')"
                                                                class="btn-action ${u.role == 'ADMIN' ? 'btn-action-edit' : 'btn-action-view'}"
                                                                title="${u.role == 'ADMIN' ? 'Rétrograder en Client' : 'Promouvoir en Admin'}">
                                                                <i
                                                                    class="fas ${u.role == 'ADMIN' ? 'fa-user-minus' : 'fa-user-plus'}"></i>
                                                            </a>
                                                        </c:if>
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
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>