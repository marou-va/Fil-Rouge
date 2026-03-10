<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Produits - MaBoutique Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body>
            <div class="container-fluid p-0">
                <div class="d-flex">
                    <c:set var="page" value="produits" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <div class="admin-main flex-grow-1">
                        <!-- Topbar -->
                        <div class="admin-topbar">
                            <div>
                                <div class="topbar-title">Gestion des Produits</div>
                                <div class="topbar-subtitle">Ajouter, modifier, supprimer des articles</div>
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <form action="produits" method="GET" class="d-flex gap-2 me-2">
                                    <div style="position:relative;">
                                        <i class="fas fa-search"
                                            style="position:absolute;left:12px;top:50%;transform:translateY(-50%);color:#94a3b8;font-size:13px;"></i>
                                        <input type="text" name="search" class="form-control-admin"
                                            style="padding-left:36px;width:220px;"
                                            placeholder="Rechercher un produit..." value="${param.search}">
                                    </div>
                                    <button type="submit" class="btn-secondary-admin px-3">OK</button>
                                </form>
                                <a href="produits?action=add" class="btn-primary-admin d-flex align-items-center gap-2">
                                    <i class="fas fa-plus"></i> Nouveau produit
                                </a>
                            </div>
                        </div>

                        <div class="admin-content">
                            <c:if test="${not empty sessionScope.msg}">
                                <div
                                    class="alert-flash alert-flash-success d-flex align-items-center gap-2 mb-4 animate-in">
                                    <i class="fas fa-check-circle"></i> ${sessionScope.msg}
                                </div>
                                <c:remove var="msg" scope="session" />
                            </c:if>
                            <c:if test="${not empty sessionScope.err}">
                                <div
                                    class="alert-flash alert-flash-danger d-flex align-items-center gap-2 mb-4 animate-in">
                                    <i class="fas fa-exclamation-circle"></i> ${sessionScope.err}
                                </div>
                                <c:remove var="err" scope="session" />
                            </c:if>

                            <div class="content-card animate-in">
                                <div class="content-card-body">
                                    <table class="table admin-table mb-0">
                                        <thead>
                                            <tr>
                                                <th>Produit</th>
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
                                                        <div class="d-flex align-items-center gap-3">
                                                            <img src="${p.imageUrl}" alt="${p.nom}"
                                                                style="width:44px;height:44px;object-fit:cover;border-radius:10px;border:2px solid #f1f5f9;"
                                                                onerror="this.src='https://placehold.co/44x44/f3f4f6/94a3b8?text=IMG'">
                                                            <div>
                                                                <div class="fw-bold" style="color:#0f172a;">${p.nom}
                                                                </div>
                                                                <div class="text-muted" style="font-size:0.75rem;">
                                                                    #${p.id}</div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span
                                                            style="background:#f1f5f9;color:#64748b;padding:4px 10px;border-radius:20px;font-size:0.75rem;font-weight:600;">
                                                            ${p.categorie.nom}
                                                        </span>
                                                    </td>
                                                    <td><span class="fw-bold" style="color:#7c3aed;">${p.prix} DH</span>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${p.stock == 0}">
                                                                <span class="badge-status badge-annulee">Rupture</span>
                                                            </c:when>
                                                            <c:when test="${p.stock < 10}">
                                                                <span class="badge-status badge-attente">${p.stock}
                                                                    unité(s)</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge-status badge-livree">${p.stock}
                                                                    unité(s)</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${p.actif}">
                                                                <span
                                                                    style="display:inline-flex;align-items:center;gap:5px;font-size:0.78rem;color:#16a34a;font-weight:600;">
                                                                    <span
                                                                        style="width:7px;height:7px;background:#22c55e;border-radius:50%;box-shadow:0 0 6px #22c55e;"></span>
                                                                    Actif
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span
                                                                    style="display:inline-flex;align-items:center;gap:5px;font-size:0.78rem;color:#64748b;font-weight:600;">
                                                                    <span
                                                                        style="width:7px;height:7px;background:#94a3b8;border-radius:50%;"></span>
                                                                    Inactif
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-end">
                                                        <div class="d-flex gap-2 justify-content-end">
                                                            <a href="produits?action=edit&id=${p.id}"
                                                                class="btn-action btn-action-edit" title="Modifier">
                                                                <i class="fas fa-pen"></i>
                                                            </a>
                                                            <a href="produits?action=delete&id=${p.id}"
                                                                class="btn-action btn-action-delete"
                                                                onclick="return confirm('Supprimer «${p.nom}» ?')"
                                                                title="Supprimer">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty produits}">
                                                <tr>
                                                    <td colspan="6">
                                                        <div class="text-center py-5">
                                                            <div
                                                                style="font-size:48px;color:#e2e8f0;margin-bottom:12px;">
                                                                <i class="fas fa-box-open"></i></div>
                                                            <div style="color:#94a3b8;font-weight:500;">Aucun produit
                                                                trouvé</div>
                                                        </div>
                                                    </td>
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
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>