<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Utilisateurs — Admin MaBoutique</title>
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

                .u-avatar {
                    width: 40px;
                    height: 40px;
                    background: var(--primary-light);
                    color: #fff;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    border-radius: 50%;
                    font-weight: bold;
                }
            </style>
        </head>

        <body>
            <div class="admin-layout">
                <c:set var="page" value="utilisateurs" scope="request" />
                <jsp:include page="sidebar.jsp" />

                <main class="admin-main">
                    <div class="page-header">
                        <h1 class="h3 fw-bold mb-0">Gestion des Utilisateurs</h1>
                        <small class="text-muted">Gérez les accès et les rôles de vos membres</small>
                    </div>

                    <div class="card-theme overflow-hidden">
                        <table class="table table-hover align-middle mb-0">
                            <thead style="background:var(--primary-dark);color:#fff;">
                                <tr>
                                    <th class="ps-3">Utilisateur</th>
                                    <th>Email</th>
                                    <th>Rôle</th>
                                    <th>Date d'inscription</th>
                                    <th class="text-end pe-3">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="u" items="${utilisateurs}">
                                    <tr>
                                        <td class="ps-3">
                                            <div class="d-flex align-items-center gap-3">
                                                <div class="u-avatar">
                                                    ${u.nom.substring(0,1).toUpperCase()}
                                                </div>
                                                <span class="fw-bold">${u.nom}</span>
                                            </div>
                                        </td>
                                        <td class="text-muted">${u.email}</td>
                                        <td>
                                            <span class="badge rounded-pill"
                                                style="${u.role == 'ADMIN' ? 'background:var(--accent);color:#fff;' : 'background:rgba(142,153,121,0.2);color:var(--primary-dark);'}">
                                                <i
                                                    class="fas ${u.role == 'ADMIN' ? 'fa-shield-alt' : 'fa-user'} me-1"></i>
                                                ${u.role}
                                            </span>
                                        </td>
                                        <td class="small text-muted">${u.dateCreation}</td>
                                        <td class="text-end pe-3">
                                            <c:choose>
                                                <c:when test="${sessionScope.utilisateur.email != u.email}">
                                                    <a href="utilisateurs?action=toggleRole&email=${u.email}"
                                                        class="btn btn-sm ${u.role == 'ADMIN' ? 'btn-outline-brand' : 'btn-outline-accent'}"
                                                        onclick="return confirm('Changer le rôle de cet utilisateur ?')">
                                                        <i
                                                            class="fas ${u.role == 'ADMIN' ? 'fa-arrow-down' : 'fa-arrow-up'} me-1"></i>
                                                        ${u.role == 'ADMIN' ? 'Rendre Client' : 'Rendre Admin'}
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-light text-muted border px-3 py-2">C'est
                                                        vous</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty utilisateurs}">
                                    <tr>
                                        <td colspan="5" class="text-center py-5 text-muted">Aucun utilisateur trouvé.
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </main>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>