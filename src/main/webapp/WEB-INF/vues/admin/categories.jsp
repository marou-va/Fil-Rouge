<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Gestion des Catégories - MaBoutique Admin</title>
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

                .table-responsive,
                .form-card {
                    background: white;
                    border-radius: 15px;
                    padding: 20px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                    margin-bottom: 30px;
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
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <c:set var="page" value="categories" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                        <div
                            class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                            <h1 class="h2">Gestion des Catégories</h1>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-card">
                                    <h4 class="mb-4 fw-bold" id="formTitle">Nouvelle Catégorie</h4>
                                    <form action="categories" method="POST">
                                        <input type="hidden" name="id" id="catId">
                                        <div class="mb-3">
                                            <label class="form-label small text-uppercase">Nom</label>
                                            <input type="text" name="nom" id="catNom" class="form-control" required
                                                placeholder="Ex: Électronique">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label small text-uppercase">Description</label>
                                            <textarea name="description" id="catDesc" class="form-control"
                                                rows="3"></textarea>
                                        </div>
                                        <button type="submit" class="btn btn-brand w-100">
                                            <i class="fas fa-save me-2"></i> Enregistrer
                                        </button>
                                        <button type="button" class="btn btn-light w-100 mt-2 d-none" id="cancelEdit">
                                            Annuler
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>ID</th>
                                                <th>Nom</th>
                                                <th>Description</th>
                                                <th class="text-end">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="c" items="${categories}">
                                                <tr>
                                                    <td>${c.id}</td>
                                                    <td class="fw-bold text-brand">${c.nom}</td>
                                                    <td class="text-muted small text-truncate"
                                                        style="max-width: 250px;">${c.description}</td>
                                                    <td class="text-end">
                                                        <button class="btn btn-sm btn-outline-primary me-2 edit-btn"
                                                            data-id="${c.id}" data-nom="${c.nom}"
                                                            data-desc="${c.description}">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <a href="categories?action=delete&id=${c.id}"
                                                            class="btn btn-sm btn-outline-danger"
                                                            onclick="return confirm('Confirmer la suppression ?')">
                                                            <i class="fas fa-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                document.querySelectorAll('.edit-btn').forEach(btn => {
                    btn.addEventListener('click', () => {
                        document.getElementById('catId').value = btn.dataset.id;
                        document.getElementById('catNom').value = btn.dataset.nom;
                        document.getElementById('catDesc').value = btn.dataset.desc;
                        document.getElementById('formTitle').innerText = 'Modifier la Catégorie';
                        document.getElementById('cancelEdit').classList.remove('d-none');
                    });
                });

                document.getElementById('cancelEdit').addEventListener('click', () => {
                    document.getElementById('catId').value = '';
                    document.getElementById('catNom').value = '';
                    document.getElementById('catDesc').value = '';
                    document.getElementById('formTitle').innerText = 'Nouvelle Catégorie';
                    document.getElementById('cancelEdit').classList.add('d-none');
                });
            </script>
        </body>

        </html>