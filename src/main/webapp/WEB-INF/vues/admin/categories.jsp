<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Gestion des Catégories — Admin MaBoutique</title>
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
                <c:set var="page" value="categories" scope="request" />
                <jsp:include page="sidebar.jsp" />

                <main class="admin-main">
                    <div class="page-header">
                        <h1 class="h3 fw-bold mb-0">Gestion des Catégories</h1>
                        <small class="text-muted">Organisez vos produits par groupes thématiques</small>
                    </div>

                    <div class="row g-4">
                        <div class="col-lg-4">
                            <div class="card-theme p-4">
                                <h5 class="fw-bold mb-3" id="formTitle">Nouvelle Catégorie</h5>
                                <form action="categories" method="POST">
                                    <input type="hidden" name="id" id="catId">
                                    <div class="mb-3">
                                        <label class="form-label fw-bold small text-uppercase"
                                            style="color:var(--text-muted);">Nom</label>
                                        <input type="text" name="nom" id="catNom" class="form-control" required
                                            placeholder="Ex: Électronique">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label fw-bold small text-uppercase"
                                            style="color:var(--text-muted);">Description</label>
                                        <textarea name="description" id="catDesc" class="form-control" rows="4"
                                            placeholder="Description de la catégorie…"></textarea>
                                    </div>
                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-brand fw-bold py-2">
                                            <i class="fas fa-save me-2"></i> Enregistrer
                                        </button>
                                        <button type="button" class="btn btn-outline-brand btn-sm d-none"
                                            id="cancelEdit">
                                            Annuler la modification
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="col-lg-8">
                            <div class="card-theme overflow-hidden">
                                <table class="table table-hover align-middle mb-0">
                                    <thead style="background:var(--primary-dark);color:#fff;">
                                        <tr>
                                            <th class="ps-3">ID</th>
                                            <th>Nom</th>
                                            <th>Description</th>
                                            <th class="text-end pe-3">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="c" items="${categories}">
                                            <tr>
                                                <td class="ps-3 text-muted small">#${c.id}</td>
                                                <td class="fw-bold" style="color:var(--primary-dark);">${c.nom}</td>
                                                <td class="text-muted small">
                                                    <div class="text-truncate" style="max-width: 300px;">
                                                        ${c.description}</div>
                                                </td>
                                                <td class="text-end pe-3">
                                                    <button class="btn btn-sm btn-outline-brand me-1 edit-btn"
                                                        data-id="${c.id}" data-nom="${c.nom}"
                                                        data-desc="${c.description}" title="Modifier">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <a href="categories?action=delete&id=${c.id}"
                                                        class="btn btn-sm btn-accent"
                                                        onclick="return confirm('Confirmer la suppression ?')"
                                                        title="Supprimer">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty categories}">
                                            <tr>
                                                <td colspan="4" class="text-center py-5 text-muted">Aucune catégorie
                                                    définie.</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
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

                        // Scroll to form on mobile
                        if (window.innerWidth < 992) {
                            document.getElementById('catNom').scrollIntoView({ behavior: 'smooth' });
                        }
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