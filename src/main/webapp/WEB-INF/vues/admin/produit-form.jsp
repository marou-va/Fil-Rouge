<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${not empty produit ? 'Modifier' : 'Ajouter'} Produit - MaBoutique Admin</title>
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

                .form-card {
                    background: white;
                    border-radius: 20px;
                    padding: 30px;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                    max-width: 900px;
                    margin: 0 auto;
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

                .preview-img {
                    max-width: 200px;
                    border-radius: 10px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                }
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <c:set var="page" value="produits" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                        <nav aria-label="breadcrumb" class="mb-4">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="dashboard" class="text-brand">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="produits" class="text-brand">Produits</a></li>
                                <li class="breadcrumb-item active">${not empty produit ? 'Modifier' : 'Nouveau'}</li>
                            </ol>
                        </nav>

                        <div class="form-card">
                            <h2 class="fw-bold mb-4">${not empty produit ? 'Modifier le produit' : 'Nouveau Produit'}
                            </h2>

                            <form action="produits" method="POST">
                                <input type="hidden" name="id" value="${produit.id}">

                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small text-uppercase">Nom du produit</label>
                                        <input type="text" name="nom" class="form-control" value="${produit.nom}"
                                            required placeholder="Ex: Smartphone XYZ">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small text-uppercase">Catégorie</label>
                                        <select name="categorieId" class="form-select" required>
                                            <option value="">Sélectionner une catégorie</option>
                                            <c:forEach var="cat" items="${categories}">
                                                <option value="${cat.id}" ${produit.categorie.id==cat.id ? 'selected'
                                                    : '' }>
                                                    ${cat.nom}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="col-12">
                                        <label class="form-label fw-bold small text-uppercase">Description</label>
                                        <textarea name="description" class="form-control" rows="4"
                                            placeholder="Description détaillée du produit">${produit.description}</textarea>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="form-label fw-bold small text-uppercase">Prix (DH)</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light text-muted">DH</span>
                                            <input type="number" step="0.01" name="prix" class="form-control"
                                                value="${produit.prix}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label fw-bold small text-uppercase">Stock initial</label>
                                        <input type="number" name="stock" class="form-control"
                                            value="${not empty produit ? produit.stock : 0}" required>
                                    </div>
                                    <div class="col-md-4 d-flex align-items-end">
                                        <div class="form-check form-switch mb-2">
                                            <input class="form-check-input" type="checkbox" name="actif"
                                                id="actifSwitch" ${not empty produit ? (produit.actif ? 'checked' : '' )
                                                : 'checked' }>
                                            <label class="form-check-label fw-bold" for="actifSwitch">Produit
                                                actif</label>
                                        </div>
                                    </div>

                                    <div class="col-md-8">
                                        <label class="form-label fw-bold small text-uppercase">URL de l'image</label>
                                        <input type="text" name="imageUrl" id="imageUrl" class="form-control"
                                            value="${produit.imageUrl}" placeholder="https://exemple.com/image.jpg">
                                        <div class="form-text small">Utilisez une URL d'image valide.</div>
                                    </div>

                                    <div class="col-md-4 text-center">
                                        <div class="p-2 border rounded bg-light mt-4">
                                            <img id="imagePreview"
                                                src="${not empty produit.imageUrl ? produit.imageUrl : 'https://via.placeholder.com/200'}"
                                                alt="Preview" class="preview-img">
                                        </div>
                                    </div>

                                    <div class="col-12 text-end mt-5 pt-3 border-top">
                                        <a href="produits" class="btn btn-light border me-3 fw-bold">Annuler</a>
                                        <button type="submit" class="btn btn-brand px-5">
                                            <i class="fas fa-save me-2"></i> Enregistrer
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </main>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                document.getElementById('imageUrl').addEventListener('input', function (e) {
                    const preview = document.getElementById('imagePreview');
                    if (e.target.value) {
                        preview.src = e.target.value;
                    } else {
                        preview.src = 'https://via.placeholder.com/200';
                    }
                });
            </script>
        </body>

        </html>