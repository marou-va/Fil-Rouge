<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${not empty produit ? 'Modifier' : 'Ajouter'} Produit - Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body>
            <div class="container-fluid p-0">
                <div class="d-flex">
                    <c:set var="page" value="produits" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <div class="admin-main flex-grow-1">
                        <div class="admin-topbar">
                            <div>
                                <div class="topbar-title">${not empty produit ? 'Modifier le produit' : 'Nouveau
                                    produit'}</div>
                                <nav class="breadcrumb-admin mt-1">
                                    <a href="produits">← Retour aux produits</a>
                                </nav>
                            </div>
                        </div>

                        <div class="admin-content">
                            <div class="row g-4">
                                <!-- Form Card -->
                                <div class="col-lg-8 animate-in">
                                    <div class="content-card">
                                        <div class="content-card-header">
                                            <span class="content-card-title">Informations du produit</span>
                                        </div>
                                        <div class="p-4">
                                            <form action="produits" method="POST">
                                                <input type="hidden" name="id" value="${produit.id}">
                                                <div class="row g-3">
                                                    <div class="col-md-8">
                                                        <label class="form-label-admin">Nom du produit *</label>
                                                        <input type="text" name="nom" class="form-control-admin w-100"
                                                            value="${produit.nom}" required
                                                            placeholder="Ex: Smartphone Galaxy S24">
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label class="form-label-admin">Catégorie *</label>
                                                        <select name="categorieId" class="form-select-admin w-100"
                                                            required>
                                                            <option value="">Choisir...</option>
                                                            <c:forEach var="cat" items="${categories}">
                                                                <option value="${cat.id}" ${produit.categorie.id==cat.id
                                                                    ? 'selected' : '' }>${cat.nom}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="col-12">
                                                        <label class="form-label-admin">Description</label>
                                                        <textarea name="description" class="form-control-admin w-100"
                                                            rows="4"
                                                            placeholder="Description détaillée du produit...">${produit.description}</textarea>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label class="form-label-admin">Prix (DH) *</label>
                                                        <div style="position:relative;">
                                                            <span
                                                                style="position:absolute;left:12px;top:50%;transform:translateY(-50%);color:#94a3b8;font-size:13px;">DH</span>
                                                            <input type="number" step="0.01" name="prix"
                                                                class="form-control-admin w-100"
                                                                style="padding-left:36px;" value="${produit.prix}"
                                                                required>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label class="form-label-admin">Stock *</label>
                                                        <input type="number" name="stock"
                                                            class="form-control-admin w-100"
                                                            value="${not empty produit ? produit.stock : 0}" required
                                                            min="0">
                                                    </div>
                                                    <div class="col-md-4 d-flex flex-column justify-content-end">
                                                        <label class="form-label-admin">Statut</label>
                                                        <div class="d-flex align-items-center gap-3 py-2">
                                                            <label class="toggle-switch"
                                                                style="cursor:pointer;display:flex;align-items:center;gap:10px;">
                                                                <input type="checkbox" name="actif" id="actifToggle"
                                                                    ${not empty produit ? (produit.actif ? 'checked'
                                                                    : '' ) : 'checked' } style="display:none;"
                                                                    onchange="updateToggle()">
                                                                <span id="toggleTrack"
                                                                    style="width:44px;height:24px;background:#e2e8f0;border-radius:12px;position:relative;transition:all 0.3s;display:inline-block;">
                                                                    <span id="toggleThumb"
                                                                        style="width:18px;height:18px;background:white;border-radius:9px;position:absolute;top:3px;left:3px;transition:all 0.3s;box-shadow:0 1px 4px rgba(0,0,0,0.2);"></span>
                                                                </span>
                                                                <span id="toggleLabel"
                                                                    class="form-label-admin mb-0">Actif</span>
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-12">
                                                        <label class="form-label-admin">URL de l'image</label>
                                                        <input type="text" name="imageUrl" id="imageUrl"
                                                            class="form-control-admin w-100" value="${produit.imageUrl}"
                                                            placeholder="https://exemple.com/image.jpg">
                                                    </div>
                                                </div>

                                                <div class="d-flex gap-3 justify-content-end mt-4 pt-4"
                                                    style="border-top:1px solid #f1f5f9;">
                                                    <a href="produits" class="btn-secondary-admin">Annuler</a>
                                                    <button type="submit" class="btn-primary-admin">
                                                        <i class="fas fa-save me-2"></i> Enregistrer le produit
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <!-- Preview Card -->
                                <div class="col-lg-4 animate-in delay-2">
                                    <div class="content-card" style="position:sticky;top:88px;">
                                        <div class="content-card-header">
                                            <span class="content-card-title">Aperçu</span>
                                        </div>
                                        <div class="p-4 text-center">
                                            <div
                                                style="width:100%;height:200px;border-radius:12px;overflow:hidden;background:#f8fafc;display:flex;align-items:center;justify-content:center;margin-bottom:16px;border:2px dashed #e2e8f0;">
                                                <img id="imagePreview"
                                                    src="${not empty produit.imageUrl ? produit.imageUrl : ''}"
                                                    alt="Aperçu"
                                                    style="max-width:100%;max-height:100%;object-fit:contain;display:${not empty produit.imageUrl ? 'block' : 'none'};">
                                                <div id="imagePlaceholder"
                                                    style="display:${not empty produit.imageUrl ? 'none' : 'flex'};flex-direction:column;align-items:center;color:#cbd5e1;">
                                                    <i class="fas fa-image"
                                                        style="font-size:40px;margin-bottom:8px;"></i>
                                                    <span style="font-size:0.8rem;">Entrez une URL d'image</span>
                                                </div>
                                            </div>
                                            <div class="text-muted" style="font-size:0.78rem;">
                                                L'aperçu se met à jour en temps réel depuis l'URL fournie.
                                            </div>
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
                // Image preview
                document.getElementById('imageUrl').addEventListener('input', function () {
                    const preview = document.getElementById('imagePreview');
                    const placeholder = document.getElementById('imagePlaceholder');
                    if (this.value.trim()) {
                        preview.src = this.value;
                        preview.style.display = 'block';
                        placeholder.style.display = 'none';
                    } else {
                        preview.style.display = 'none';
                        placeholder.style.display = 'flex';
                    }
                });

                // Toggle switch
                function updateToggle() {
                    const cb = document.getElementById('actifToggle');
                    const track = document.getElementById('toggleTrack');
                    const thumb = document.getElementById('toggleThumb');
                    const label = document.getElementById('toggleLabel');
                    if (cb.checked) {
                        track.style.background = '#7c3aed';
                        thumb.style.left = '23px';
                        label.textContent = 'Actif';
                    } else {
                        track.style.background = '#e2e8f0';
                        thumb.style.left = '3px';
                        label.textContent = 'Inactif';
                    }
                }
                // Apply initial state
                updateToggle();
                document.querySelector('span[style*="position:relative"]').addEventListener('click', function () {
                    const cb = document.getElementById('actifToggle');
                    cb.checked = !cb.checked;
                    updateToggle();
                });
            </script>
        </body>

        </html>