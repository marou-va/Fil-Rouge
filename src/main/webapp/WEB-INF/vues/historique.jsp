<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Mes Commandes — MaBoutique</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
                <style>
                    .profile-hero {
                        background: linear-gradient(rgba(142, 153, 121, 0.9), rgba(122, 132, 106, 0.9)), url('https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&q=80');
                        background-size: cover;
                        background-position: center;
                        color: #fff;
                        padding: 4rem 0;
                        margin-bottom: -3rem;
                    }

                    .u-avatar-lg {
                        width: 100px;
                        height: 100px;
                        background: #fff;
                        color: var(--primary);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        border-radius: 50%;
                        font-size: 2.5rem;
                        font-weight: 700;
                        box-shadow: var(--shadow-md);
                        border: 4px solid var(--primary-light);
                    }

                    .acc-sidebar-link {
                        padding: 12px 20px;
                        border-radius: 12px;
                        color: var(--text);
                        text-decoration: none;
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        transition: var(--transition);
                        margin-bottom: 5px;
                        font-weight: 600;
                    }

                    .acc-sidebar-link:hover {
                        background: var(--bg);
                        color: var(--primary-dark);
                    }

                    .acc-sidebar-link.active {
                        background: var(--primary);
                        color: #fff;
                    }

                    /* Table Styles */
                    .order-row {
                        transition: var(--transition);
                        border-bottom: 1px solid var(--border-color);
                    }

                    .order-row:hover {
                        background: var(--bg);
                    }
                </style>
            </head>

            <body>
                <jsp:include page="includes/navbar.jsp" />

                <header class="profile-hero">
                    <div class="container">
                        <div class="d-flex align-items-center gap-4">
                            <div class="u-avatar-lg">
                                ${sessionScope.utilisateur.nom.substring(0,1).toUpperCase()}
                            </div>
                            <div>
                                <h1 class="display-6 fw-bold mb-1">${sessionScope.utilisateur.nom}</h1>
                                <p class="mb-0 opacity-75"><i class="fas fa-shopping-bag me-2"></i>Mon historique
                                    d'achats</p>
                            </div>
                        </div>
                    </div>
                </header>

                <div class="container mb-5">
                    <div class="row g-4">
                        <!-- Sidebar -->
                        <div class="col-lg-3">
                            <div class="card-theme p-3" style="margin-top:0;">
                                <a href="profil" class="acc-sidebar-link">
                                    <i class="fas fa-user-circle"></i>Mon Profil
                                </a>
                                <a href="historique" class="acc-sidebar-link active">
                                    <i class="fas fa-history"></i>Mes Commandes
                                </a>
                                <a href="#" class="acc-sidebar-link">
                                    <i class="fas fa-heart"></i>Favoris
                                </a>
                                <hr class="my-3">
                                <a href="logout" class="acc-sidebar-link text-accent">
                                    <i class="fas fa-sign-out-alt"></i>Déconnexion
                                </a>
                            </div>
                        </div>

                        <!-- Content -->
                        <div class="col-lg-9">
                            <div class="card-theme p-4">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h1 class="h4 fw-bold mb-0 brand-heading">Mes Commandes</h1>
                                    <div class="d-flex gap-2">
                                        <!-- Filtres -->
                                        <form action="historique" method="GET"
                                            class="d-flex gap-2 align-items-center bg-light p-1 rounded-pill px-3 border">
                                            <select name="status"
                                                class="form-select form-select-sm border-0 bg-transparent shadow-none"
                                                style="width: 140px; font-size: 0.8rem;">
                                                <option value="">Tout</option>
                                                <c:forEach var="s" items="${statuts}">
                                                    <option value="${s}" ${param.status==s ? 'selected' : '' }>${s}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <input type="date" name="date"
                                                class="form-control form-control-sm border-0 bg-transparent shadow-none"
                                                value="${param.date}" style="width: 120px; font-size: 0.8rem;">
                                            <button type="submit" class="btn btn-sm btn-brand rounded-circle p-1"
                                                style="width:28px; height:28px;">
                                                <i class="fas fa-search" style="font-size: 0.7rem;"></i>
                                            </button>
                                        </form>
                                        <span class="badge badge-brand py-2 px-3">${commandes.size()} commande(s)</span>
                                    </div>
                                </div>

                                <c:choose>
                                    <c:when test="${empty commandes}">
                                        <div class="text-center py-5">
                                            <i class="fas fa-box-open fa-4x text-muted mb-4 opacity-25"></i>
                                            <h5 class="text-muted mb-4">Vous n'avez pas encore passé de commande.</h5>
                                            <a href="catalogue" class="btn btn-brand px-5 py-2">Faire mon premier
                                                achat</a>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="table-responsive">
                                            <table class="table align-middle mb-0">
                                                <caption>Liste de mon historique de commandes</caption>
                                                <thead style="background:var(--bg);">
                                                    <tr>
                                                        <th class="ps-3 py-3 small text-muted text-uppercase">N°
                                                            Commande</th>
                                                        <th class="py-3 small text-muted text-uppercase">Date</th>
                                                        <th class="py-3 small text-muted text-uppercase">Statut</th>
                                                        <th class="py-3 small text-muted text-uppercase text-end">Total
                                                        </th>
                                                        <th class="pe-3 text-end"></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="commande" items="${commandes}">
                                                        <tr class="order-row">
                                                            <td class="ps-3 py-3 fw-bold">#${commande.id}</td>
                                                            <td class="text-muted small">
                                                                <fmt:parseDate value="${commande.dateCommande}"
                                                                    pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate"
                                                                    type="both" />
                                                                <fmt:formatDate value="${parsedDate}"
                                                                    pattern="dd MMM yyyy, HH:mm" />
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${commande.statut == 'VALIDEE'}">
                                                                        <span class="badge rounded-pill"
                                                                            style="background:rgba(142,153,121,0.2); color:var(--primary-dark);">
                                                                            VALIDÉE
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${commande.statut == 'EN_COURS'}">
                                                                        <span class="badge rounded-pill"
                                                                            style="background:rgba(180,194,190,0.3); color:var(--text-dark);">
                                                                            EN COURS
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${commande.statut == 'LIVREE'}">
                                                                        <span class="badge rounded-pill"
                                                                            style="background:rgba(105,110,91,0.2); color:var(--primary-dark);">
                                                                            LIVRÉE
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${commande.statut == 'ANNULEE'}">
                                                                        <span class="badge rounded-pill"
                                                                            style="background:rgba(163,124,122,0.2); color:var(--accent);">
                                                                            ANNULÉE
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge rounded-pill bg-secondary">
                                                                            ${commande.statut}
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="text-end fw-bold"
                                                                style="color:var(--primary-dark);">
                                                                <c:set var="totalRow" value="0.0" />
                                                                <c:forEach var="it" items="${commande.items}">
                                                                    <c:set var="totalRow"
                                                                        value="${totalRow + (it.prixUnitaire * it.quantite)}" />
                                                                </c:forEach>
                                                                ${totalRow} MAD
                                                            </td>
                                                            <td class="pe-3 text-end">
                                                                <div class="d-flex justify-content-end gap-2">
                                                                    <c:if test="${commande.statut == 'VALIDEE'}">
                                                                        <form action="historique" method="POST"
                                                                            class="m-0"
                                                                            onsubmit="return confirm('Annuler cette commande ?')">
                                                                            <input type="hidden" name="commandeId"
                                                                                value="${commande.id}">
                                                                            <button type="submit"
                                                                                class="btn btn-sm btn-outline-danger rounded-pill px-3">
                                                                                <i class="fas fa-times me-1"></i>Annuler
                                                                            </button>
                                                                        </form>
                                                                    </c:if>
                                                                    <a href="commande-detail?id=${commande.id}"
                                                                        class="btn btn-sm btn-outline-brand rounded-pill px-3">
                                                                        <i class="fas fa-eye me-1"></i>Détails
                                                                    </a>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="includes/footer.jsp" />
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>