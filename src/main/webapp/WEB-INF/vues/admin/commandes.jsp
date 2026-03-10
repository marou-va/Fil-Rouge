<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Suivi des Commandes - MaBoutique Admin</title>
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
                    <c:set var="page" value="commandes" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                        <div
                            class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                            <h1 class="h2">Suivi des Commandes</h1>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
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
                                            <td class="fw-bold">#${c.id}</td>
                                            <td>
                                                <div class="fw-bold">${c.utilisateur.nom}</div>
                                                <small class="text-muted">${c.utilisateur.email}</small>
                                            </td>
                                            <td>${c.dateCommande}</td>
                                            <td class="fw-bold text-success">
                                                <c:set var="totalC" value="0.0" />
                                                <c:forEach var="item" items="${c.items}">
                                                    <c:set var="totalC"
                                                        value="${totalC + (item.prixUnitaire * item.quantite)}" />
                                                </c:forEach>
                                                ${totalC} DH
                                            </td>
                                            <td>
                                                <form action="commandes" method="POST" style="display:inline;">
                                                    <input type="hidden" name="id" value="${c.id}">
                                                    <select name="statut" class="form-select form-select-sm"
                                                        onchange="this.form.submit()">
                                                        <c:forEach var="s" items="${statuts}">
                                                            <option value="${s}" ${c.statut==s ? 'selected' : '' }>${s}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </form>
                                            </td>
                                            <td class="text-end">
                                                <a href="commandes?action=view&id=${c.id}"
                                                    class="btn btn-sm btn-outline-info">
                                                    <i class="fas fa-eye"></i>
                                                </a>
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