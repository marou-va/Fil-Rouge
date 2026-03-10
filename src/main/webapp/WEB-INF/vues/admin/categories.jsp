<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Catégories - MaBoutique Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body>
            <div class="container-fluid p-0">
                <div class="d-flex">
                    <c:set var="page" value="categories" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <div class="admin-main flex-grow-1">
                        <div class="admin-topbar">
                            <div>
                                <div class="topbar-title">Gestion des Catégories</div>
                                <div class="topbar-subtitle">Organiser les produits par familles</div>
                            </div>
                        </div>

                        <div class="admin-content">
                            <div class="row g-4">

                                <!-- Form -->
                                <div class="col-lg-4 animate-in">
                                    <div class="content-card" style="position:sticky;top:88px;">
                                        <div class="content-card-header">
                                            <span class="content-card-title" id="formTitle">Nouvelle catégorie</span>
                                        </div>
                                        <div class="p-4">
                                            <form action="categories" method="POST" id="catForm">
                                                <input type="hidden" name="id" id="catId">
                                                <div class="mb-3">
                                                    <label class="form-label-admin">Nom *</label>
                                                    <input type="text" name="nom" id="catNom"
                                                        class="form-control-admin w-100" required
                                                        placeholder="Ex: Électronique">
                                                </div>
                                                <div class="mb-4">
                                                    <label class="form-label-admin">Description</label>
                                                    <textarea name="description" id="catDesc"
                                                        class="form-control-admin w-100" rows="3"
                                                        placeholder="Décrivez cette catégorie..."></textarea>
                                                </div>
                                                <div class="d-flex flex-column gap-2">
                                                    <button type="submit"
                                                        class="btn-primary-admin w-100 text-center justify-content-center d-flex">
                                                        <i class="fas fa-save me-2"></i> Enregistrer
                                                    </button>
                                                    <button type="button" id="cancelBtn"
                                                        class="btn-secondary-admin w-100 text-center d-none"
                                                        onclick="resetForm()">
                                                        Annuler la modification
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <!-- List -->
                                <div class="col-lg-8 animate-in delay-1">
                                    <div class="content-card">
                                        <div class="content-card-header">
                                            <span class="content-card-title">Catégories existantes</span>
                                            <span
                                                style="background:#f1f5f9;color:#64748b;padding:5px 12px;border-radius:20px;font-size:0.75rem;font-weight:600;">${categories.size()}
                                                catégorie(s)</span>
                                        </div>
                                        <div class="content-card-body">
                                            <table class="table admin-table mb-0">
                                                <thead>
                                                    <tr>
                                                        <th>Catégorie</th>
                                                        <th>Description</th>
                                                        <th class="text-end">Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="c" items="${categories}">
                                                        <tr>
                                                            <td>
                                                                <div class="d-flex align-items-center gap-3">
                                                                    <div
                                                                        style="width:36px;height:36px;background:linear-gradient(135deg,#ede9fe,#ddd6fe);border-radius:10px;display:flex;align-items:center;justify-content:center;color:#7c3aed;font-size:14px;">
                                                                        <i class="fas fa-layer-group"></i>
                                                                    </div>
                                                                    <div class="fw-bold" style="color:#0f172a;">${c.nom}
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="text-muted" style="max-width:280px;">
                                                                <span
                                                                    style="white-space:nowrap;overflow:hidden;text-overflow:ellipsis;display:block;font-size:0.83rem;">${not
                                                                    empty c.description ? c.description : '—'}</span>
                                                            </td>
                                                            <td class="text-end">
                                                                <div class="d-flex gap-2 justify-content-end">
                                                                    <button class="btn-action btn-action-edit edit-btn"
                                                                        data-id="${c.id}" data-nom="${c.nom}"
                                                                        data-desc="${c.description}" title="Modifier"
                                                                        type="button">
                                                                        <i class="fas fa-pen"></i>
                                                                    </button>
                                                                    <a href="categories?action=delete&id=${c.id}"
                                                                        class="btn-action btn-action-delete"
                                                                        onclick="return confirm('Supprimer «${c.nom}» ?')"
                                                                        title="Supprimer">
                                                                        <i class="fas fa-trash-alt"></i>
                                                                    </a>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty categories}">
                                                        <tr>
                                                            <td colspan="3" class="text-center py-5 text-muted">Aucune
                                                                catégorie créée.</td>
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
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                document.querySelectorAll('.edit-btn').forEach(btn => {
                    btn.addEventListener('click', () => {
                        document.getElementById('catId').value = btn.dataset.id;
                        document.getElementById('catNom').value = btn.dataset.nom;
                        document.getElementById('catDesc').value = btn.dataset.desc;
                        document.getElementById('formTitle').textContent = 'Modifier la catégorie';
                        document.getElementById('cancelBtn').classList.remove('d-none');
                        document.querySelector('.content-card').scrollIntoView({ behavior: 'smooth' });
                    });
                });

                function resetForm() {
                    document.getElementById('catId').value = '';
                    document.getElementById('catNom').value = '';
                    document.getElementById('catDesc').value = '';
                    document.getElementById('formTitle').textContent = 'Nouvelle catégorie';
                    document.getElementById('cancelBtn').classList.add('d-none');
                }
            </script>
        </body>

        </html>