<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Détail Commande #${commande.id} — Admin MaBoutique</title>
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

                .item-thumb {
                    width: 48px;
                    height: 48px;
                    object-fit: cover;
                    border-radius: 8px;
                    background: var(--bg);
                }
            </style>
        </head>

        <body>
            <div class="admin-layout">
                <c:set var="page" value="commandes" scope="request" />
                <jsp:include page="sidebar.jsp" />

                <main class="admin-main">
                    <div class="page-header d-flex align-items-center gap-3">
                        <a href="commandes" class="btn btn-sm btn-outline-brand"><i class="fas fa-arrow-left"></i></a>
                        <div>
                            <h1 class="h3 fw-bold mb-0">Commande #${commande.id}</h1>
                            <small class="text-muted">Passée le ${commande.dateCommande}</small>
                        </div>
                    </div>

                    <div class="row g-4">
                        <!-- Articles -->
                        <div class="col-lg-8">
                            <div class="card-theme overflow-hidden mb-4">
                                <div class="p-3 border-bottom" style="border-color:var(--border-color)!important;">
                                    <h5 class="fw-bold mb-0">Articles commandés</h5>
                                </div>
                                <div class="table-responsive">
                                    <table class="table align-middle mb-0">
                                        <caption>Détails des articles de la commande</caption>
                                        <thead style="background:var(--primary-dark);color:#fff;">
                                            <tr>
                                                <th class="ps-3 text-uppercase small fw-bold">Produit</th>
                                                <th class="text-uppercase small fw-bold">Prix Unit.</th>
                                                <th class="text-uppercase small fw-bold">Quantité</th>
                                                <th class="text-end pe-3 text-uppercase small fw-bold">Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:set var="totalItems" value="0.0" />
                                            <c:forEach var="item" items="${commande.items}">
                                                <tr>
                                                    <td class="ps-3 text-brand">
                                                        <div class="d-flex align-items-center gap-3">
                                                            <img src="${not empty item.produit.imageUrl ? item.produit.imageUrl : 'https://placehold.co/50x50/E9E7E8/A6A58C?text=?'}"
                                                                class="item-thumb" alt="${item.produit.nom}">
                                                            <span class="fw-bold">${item.produit.nom}</span>
                                                        </div>
                                                    </td>
                                                    <td class="text-muted">${item.prixUnitaire} DH</td>
                                                    <td class="fw-bold">x ${item.quantite}</td>
                                                    <td class="text-end pe-3 fw-bold"
                                                        style="color:var(--primary-dark);">${item.prixUnitaire *
                                                        item.quantite} DH</td>
                                                </tr>
                                                <c:set var="totalItems"
                                                    value="${totalItems + (item.prixUnitaire * item.quantite)}" />
                                            </c:forEach>
                                        </tbody>
                                        <tfoot style="background:var(--bg);">
                                            <tr>
                                                <td colspan="3" class="text-end fw-bold py-3">Total Général :</td>
                                                <td class="text-end pe-3 fw-bold py-3 h5 mb-0"
                                                    style="color:var(--primary-dark);">${totalItems} DH</td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Sidebar Info -->
                        <div class="col-lg-4">
                            <div class="card-theme p-4 mb-4">
                                <h5 class="fw-bold mb-4 d-flex align-items-center gap-2">
                                    <i class="fas fa-user-circle" style="color:var(--primary);"></i> Client
                                </h5>
                                <div class="mb-3">
                                    <label class="small text-uppercase fw-bold"
                                        style="color:var(--text-muted); font-size:.65rem; letter-spacing:1px;">Nom
                                        complet</label>
                                    <div class="fw-bold">${commande.utilisateur.nom}</div>
                                </div>
                                <div class="mb-3">
                                    <label class="small text-uppercase fw-bold"
                                        style="color:var(--text-muted); font-size:.65rem; letter-spacing:1px;">Email</label>
                                    <div class="text-muted">${commande.utilisateur.email}</div>
                                </div>
                                <div class="mb-3">
                                    <label class="small text-uppercase fw-bold"
                                        style="color:var(--text-muted); font-size:.65rem; letter-spacing:1px;">Téléphone</label>
                                    <div class="text-muted">${commande.utilisateur.telephone}</div>
                                </div>
                                <div class="mb-0">
                                    <label class="small text-uppercase fw-bold"
                                        style="color:var(--text-muted); font-size:.65rem; letter-spacing:1px;">Adresse
                                        de livraison</label>
                                    <p class="mb-0 small">${commande.utilisateur.adresse}</p>
                                </div>
                            </div>

                            <div class="card-theme p-4">
                                <h5 class="fw-bold mb-4 d-flex align-items-center gap-2">
                                    <i class="fas fa-tasks" style="color:var(--accent);"></i> Suivi
                                </h5>
                                <div class="alert alert-brand border-0 small mb-4">
                                    Statut actuel : <strong>${commande.statut}</strong>
                                </div>

                                <form action="commandes" method="POST">
                                    <input type="hidden" name="id" value="${commande.id}">
                                    <label class="form-label small fw-bold text-uppercase"
                                        style="color:var(--text-muted); font-size:.65rem;">Changer le statut</label>
                                    <div class="d-grid gap-2">
                                        <select name="statut" class="form-select shadow-none"
                                            style="border-radius:var(--radius);">
                                            <c:forEach var="s" items="${statuts}">
                                                <option value="${s}" ${commande.statut==s ? 'selected' : '' }>${s}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <button class="btn btn-brand fw-bold" type="submit">
                                            <i class="fas fa-sync-alt me-2"></i>Mettre à jour
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>