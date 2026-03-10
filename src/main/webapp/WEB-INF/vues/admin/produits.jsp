<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Gestion des Produits - MaBoutique Admin</title>
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

                .btn-brand {
                    background-color: var(--brand-color);
                    color: white;
                    border: none;
                    font-weight: bold;
                }

                .btn-brand:hover {
                    background-color: var(--brand-dark);
                    color: white;
                }

                .product-img {
                    width: 50px;
                    height: 50px;
                    object-fit: cover;
                    border-radius: 8px;
                }
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <c:set var="page" value="produits" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                        <div
                            class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                            <h1 class="h2">Gestion des Produits</h1>
                            <a href="produits?action=add" class="btn btn-brand">
                                <i class="fas fa-plus me-2"></i> Nouveau Produit
                            </a>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Image</th>
                                        <th>Nom</th>
                                        <th>Catégorie</th>
                                        <th>Prix</th>
                                        <th>Stock</th>
                                        <th>Statut</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${produits}">
                                        <tr>
                                            <td>
                                                <img src="${p.imageUrl}" alt="${p.nom}" class="product-img"
                                                    onerror="this.src='https://via.placeholder.com/50'">
                                            </td>
                                            <td class="fw-bold">${p.nom}</td>
                                            <td>${p.categorie.nom}</td>
                                            <td>${p.prix} DH</td>
                                            <td>
                                                <span
                                                    class="badge ${p.stock < 10 ? 'bg-danger' : 'bg-light text-dark border'}">
                                                    ${p.stock}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge ${p.actif ? 'bg-success' : 'bg-secondary'}">
                                                    ${p.actif ? 'Actif' : 'Inactif'}
                                                </span>
                                            </td>
                                            <td class="text-end">
                                                <a href="produits?action=edit&id=${p.id}"
                                                    class="btn btn-sm btn-outline-primary me-2">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="produits?action=delete&id=${p.id}"
                                                    class="btn btn-sm btn-outline-danger"
                                                    onclick="return confirm('Supprimer ce produit ?')">
                                                    <i class="fas fa-trash"></i>
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