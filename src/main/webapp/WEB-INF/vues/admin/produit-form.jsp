<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${empty produit ? 'Nouveau Produit' : 'Modifier Produit'} — Admin MaBoutique</title>
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

                #imgPreview {
                    width: 100%;
                    height: 200px;
                    object-fit: contain;
                    background: var(--bg);
                    border-radius: var(--radius);
                    padding: 10px;
                }
            </style>
        </head>

        <body>
            <div class="admin-layout">
                <c:set var="page" value="produits" scope="request" />
                <jsp:include page="sidebar.jsp" />

                <main class="admin-main">
                    <div class="page-header d-flex align-items-center gap-2">
                        <a href="produits" class="btn btn-sm btn-outline-brand"><i class="fas fa-arrow-left"></i></a>
                        <div>
                            <h1 class="h3 fw-bold mb-0">${empty produit ? 'Nouveau Produit' : 'Modifier :
                                '.concat(produit.nom)}</h1>
                            <small class="text-muted">Renseignez les informations du produit</small>
                        </div>
                    </div>

                    <div class="row g-4">
                        <div class="col-lg-8">
                            <div class="card-theme p-4">
                                <form action="produits" method="POST">
                                    <input type="hidden" name="id" value="${produit.id}">

                                    <div class="mb-3">
                                        <label class="form-label fw-bold small text-uppercase"
                                            style="color:var(--text-muted);">Nom du produit</label>
                                        <input type="text" name="nom" class="form-control" required
                                            value="${produit.nom}" placeholder="Ex: Sac en cuir naturel">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label fw-bold small text-uppercase"
                                            style="color:var(--text-muted);">Description</label>
                                        <textarea name="description" class="form-control" rows="4"
                                            placeholder="Description complète du produit…">${produit.description}</textarea>
                                    </div>
                                    <div class="row g-3 mb-3">
                                        <div class="col-md-4">
                                            <label class="form-label fw-bold small text-uppercase"
                                                style="color:var(--text-muted);">Prix (DH)</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-tag"></i></span>
                                                <input type="number" name="prix" step="0.01" min="0"
                                                    class="form-control" required value="${produit.prix}">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label fw-bold small text-uppercase"
                                                style="color:var(--text-muted);">Stock</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-cubes"></i></span>
                                                <input type="number" name="stock" min="0" class="form-control" required
                                                    value="${produit.stock}">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label fw-bold small text-uppercase"
                                                style="color:var(--text-muted);">Catégorie</label>
                                            <select name="categorieId" class="form-select" required>
                                                <c:forEach var="cat" items="${categories}">
                                                    <option value="${cat.id}" ${produit.categorie.id==cat.id
                                                        ? 'selected' : '' }>${cat.nom}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label fw-bold small text-uppercase"
                                            style="color:var(--text-muted);">URL de l'image</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-image"></i></span>
                                            <input type="url" name="imageUrl" id="imageUrl" class="form-control"
                                                value="${produit.imageUrl}" placeholder="https://…"
                                                oninput="updatePreview(this.value)">
                                        </div>
                                    </div>
                                    <div class="mb-4">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" name="actif" id="actifCheck"
                                                ${produit.actif ? 'checked' : '' }
                                                style="background-color:${produit.actif ? 'var(--primary)' : ''};border-color:var(--primary);">
                                            <label class="form-check-label fw-bold" for="actifCheck">Produit actif
                                                (visible dans le catalogue)</label>
                                        </div>
                                    </div>
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-brand fw-bold px-5">
                                            <i class="fas fa-save me-2"></i>${empty produit.id ? 'Créer le produit' :
                                            'Enregistrer les modifications'}
                                        </button>
                                        <a href="produits" class="btn btn-outline-brand">Annuler</a>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="card-theme p-4 text-center">
                                <p class="fw-bold small text-uppercase mb-2" style="color:var(--text-muted);">Aperçu de
                                    l'image</p>
                                <img id="imgPreview"
                                    src="${not empty produit.imageUrl ? produit.imageUrl : 'https://placehold.co/400x400/E9E7E8/A6A58C?text=Aperçu'}"
                                    alt="Aperçu">
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                function updatePreview(url) {
                    const img = document.getElementById('imgPreview');
                    img.src = url || 'https://placehold.co/400x400/E9E7E8/A6A58C?text=Aperçu';
                    img.onerror = () => img.src = 'https://placehold.co/400x400/E9E7E8/A6A58C?text=Aperçu';
                }
            </script>
        </body>

        </html>