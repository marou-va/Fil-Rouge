<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Produits — Admin MaBoutique</title>
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

                .prod-thumb {
                    width: 46px;
                    height: 46px;
                    object-fit: cover;
                    border-radius: 8px;
                    background: var(--bg);
                }
            </style>
        </head>

        <body>
            <div class="admin-layout">
                <c:set var="page" value="produits" scope="request" />
                <jsp:include page="sidebar.jsp" />

                <main class="admin-main">
                    <div class="page-header d-flex justify-content-between align-items-center flex-wrap gap-2">
                        <h1 class="h3 fw-bold mb-0">Gestion des Produits</h1>
                        <div class="d-flex gap-2">
                            <form action="produits" method="GET" class="d-flex gap-1">
                                <input type="text" name="search" class="form-control form-control-sm"
                                    placeholder="Rechercher…" value="${param.search}" style="width:180px;">
                                <button type="submit" class="btn btn-sm btn-outline-brand"><i
                                        class="fas fa-search"></i></button>
                            </form>
                            <a href="produits?action=add" class="btn btn-brand btn-sm"><i class="fas fa-plus me-1"></i>
                                Nouveau</a>
                        </div>
                    </div>

                    <c:if test="${not empty sessionScope.msg}">
                        <div class="alert alert-brand alert-dismissible fade show py-2" role="alert">
                            <i class="fas fa-check-circle me-2"></i>${sessionScope.msg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="msg" scope="session" />
                    </c:if>
                    <c:if test="${not empty sessionScope.err}">
                        <div class="alert alert-accent alert-dismissible fade show py-2" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.err}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <c:remove var="err" scope="session" />
                    </c:if>

                    <div class="card-theme overflow-hidden">
                        <table class="table table-hover align-middle mb-0">
                            <caption>Gestion de l'inventaire des produits</caption>
                            <thead style="background:var(--primary-dark);color:#fff;">
                                <tr>
                                    <th class="ps-3">Image</th>
                                    <th>Nom</th>
                                    <th>Catégorie</th>
                                    <th>Prix</th>
                                    <th>Stock</th>
                                    <th>Statut</th>
                                    <th class="text-end pe-3">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${produits}">
                                    <tr>
                                        <td class="ps-3">
                                            <img src="${not empty p.imageUrl ? p.imageUrl : 'https://placehold.co/50x50/E9E7E8/A6A58C?text=?'}"
                                                class="prod-thumb" alt="${p.nom}"
                                                onerror="this.src='https://placehold.co/50x50/E9E7E8/A6A58C?text=?'">
                                        </td>
                                        <td class="fw-bold">${p.nom}</td>
                                        <td><span class="cat-badge">${p.categorie.nom}</span></td>
                                        <td class="product-price">${p.prix} DH</td>
                                        <td>
                                            <span class="badge rounded-pill ${p.stock < 10 ? '' : ''}"
                                                style="${p.stock < 10 ? 'background:rgba(163,124,122,0.2);color:var(--accent);' : 'background:var(--bg);color:var(--text-muted);border:1px solid var(--border-color);'}">
                                                ${p.stock}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge rounded-pill"
                                                style="${p.actif ? 'background:rgba(142,153,121,0.2);color:var(--primary-dark);' : 'background:var(--bg);color:var(--text-muted);border:1px solid var(--border-color);'}">
                                                ${p.actif ? 'Actif' : 'Inactif'}
                                            </span>
                                        </td>
                                        <td class="text-end pe-3">
                                            <a href="produits?action=edit&id=${p.id}"
                                                class="btn btn-sm btn-outline-brand me-1" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="produits?action=delete&id=${p.id}" class="btn btn-sm btn-accent"
                                                title="Supprimer" onclick="return confirm('Supprimer ce produit ?')">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty produits}">
                                    <tr>
                                        <td colspan="7" class="text-center py-5 text-muted">Aucun produit trouvé.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </main>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>