<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Utilisateurs - Admin MaBoutique</title>
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
    </style>
</head>
<body>
    <div class="admin-layout">
        <c:set var="page" value="utilisateurs" scope="request" />
        <jsp:include page="sidebar.jsp" />

        <main class="admin-main">
            <div class="page-header">
                <h1 class="h3 fw-bold mb-0">Gestion des Utilisateurs</h1>
                <small class="text-muted">Consultez les comptes et changez leurs droits.</small>
            </div>

            <div class="card-theme overflow-hidden">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead style="background:var(--primary-dark);color:#fff;">
                            <tr>
                                <th class="ps-3">Nom</th>
                                <th>Email</th>
                                <th>Téléphone</th>
                                <th>Rôle</th>
                                <th class="text-end pe-3">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${utilisateurs}">
                                <tr>
                                    <td class="ps-3 fw-bold">${u.nom}</td>
                                    <td>${u.email}</td>
                                    <td>${u.telephone}</td>
                                    <td>
                                        <span class="badge rounded-pill ${u.role == 'ADMIN' ? 'text-bg-dark' : 'text-bg-light'}">
                                            ${u.role}
                                        </span>
                                    </td>
                                    <td class="text-end pe-3">
                                        <a href="utilisateurs?action=toggleRole&email=${u.email}"
                                           class="btn btn-sm btn-outline-brand"
                                           onclick="return confirm('Changer le role de cet utilisateur ?');">
                                            <i class="fas fa-user-shield me-1"></i> Basculer le rôle
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty utilisateurs}">
                                <tr>
                                    <td colspan="5" class="text-center py-5 text-muted">Aucun utilisateur trouvé.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
