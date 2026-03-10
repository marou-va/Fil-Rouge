<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Gestion des Utilisateurs - MaBoutique Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                :root {
                    --brand-color: #f68b1e;
                }

                body {
                    background-color: #f8f9fa;
                }

                .table-responsive {
                    background: white;
                    border-radius: 15px;
                    padding: 20px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                }

                .avatar-ui {
                    width: 40px;
                    height: 40px;
                    background: #e9ecef;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    border-radius: 50%;
                    color: #6c757d;
                }
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <c:set var="page" value="utilisateurs" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                        <div
                            class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                            <h1 class="h2">Gestion des Utilisateurs</h1>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Utilisateur</th>
                                        <th>Email</th>
                                        <th>Date d'inscription</th>
                                        <th>Rôle</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="u" items="${utilisateurs}">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar-ui me-3">
                                                        <i class="fas fa-user"></i>
                                                    </div>
                                                    <div class="fw-bold">${u.nom}</div>
                                                </div>
                                            </td>
                                            <td>${u.email}</td>
                                            <td>${u.dateCreation}</td>
                                            <td>
                                                <span class="badge ${u.role == 'ADMIN' ? 'bg-danger' : 'bg-primary'}">
                                                    ${u.role}
                                                </span>
                                            </td>
                                            <td class="text-end">
                                                <c:if test="${sessionScope.utilisateur.email != u.email}">
                                                    <a href="utilisateurs?action=toggleRole&email=${u.email}"
                                                        class="btn btn-sm ${u.role == 'ADMIN' ? 'btn-outline-primary' : 'btn-outline-danger'}"
                                                        onclick="return confirm('Changer le rôle de cet utilisateur ?')">
                                                        <i
                                                            class="fas ${u.role == 'ADMIN' ? 'fa-user-tag' : 'fa-user-shield'} me-1"></i>
                                                        ${u.role == 'ADMIN' ? 'Rendre Client' : 'Rendre Admin'}
                                                    </a>
                                                </c:if>
                                                <c:if test="${sessionScope.utilisateur.email == u.email}">
                                                    <span class="text-muted small italic">C'est vous</span>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </main>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>