<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Mes Commandes - MaBoutique</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            </head>

            <body>
                <jsp:include page="includes/navbar.jsp" />

                <!-- Profile Header -->
                <div
                    style="background:linear-gradient(160deg,#0f0c29,#302b63);padding:44px 0 72px;position:relative;overflow:hidden;">
                    <div
                        style="position:absolute;inset:0;background:radial-gradient(ellipse at 70% 50%,rgba(124,58,237,0.25),transparent 60%);">
                    </div>
                    <div class="container" style="position:relative;">
                        <div class="d-flex align-items-center gap-4">
                            <div
                                style="width:72px;height:72px;background:linear-gradient(135deg,#7c3aed,#06b6d4);border-radius:18px;display:flex;align-items:center;justify-content:center;color:white;font-size:28px;font-weight:800;box-shadow:0 8px 24px rgba(124,58,237,0.4);flex-shrink:0;">
                                ${sessionScope.utilisateur.nom.substring(0,1).toUpperCase()}
                            </div>
                            <div>
                                <div style="font-size:1.6rem;font-weight:800;color:white;">
                                    ${sessionScope.utilisateur.nom}</div>
                                <div style="color:rgba(255,255,255,0.45);font-size:0.875rem;margin-top:4px;"><i
                                        class="fas fa-box me-1"></i>Historique des commandes</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container pb-5" style="margin-top:-44px;position:relative;z-index:1;">
                    <div class="row g-4">

                        <!-- Account Nav -->
                        <div class="col-lg-3">
                            <div
                                style="background:white;border-radius:18px;border:1px solid #e2e8f0;overflow:hidden;box-shadow:0 4px 20px rgba(0,0,0,0.06);">
                                <div style="padding:20px 20px 12px;">
                                    <div
                                        style="font-size:0.72rem;font-weight:800;text-transform:uppercase;letter-spacing:0.1em;color:#94a3b8;margin-bottom:8px;">
                                        Mon Compte</div>
                                </div>
                                <div style="padding:0 12px 16px;display:flex;flex-direction:column;gap:4px;">
                                    <a href="profil"
                                        style="display:flex;align-items:center;gap:10px;padding:10px 12px;border-radius:10px;text-decoration:none;color:#334155;font-size:0.875rem;font-weight:500;transition:all 0.15s;"
                                        onmouseover="this.style.background='#f8fafc'"
                                        onmouseout="this.style.background='transparent'">
                                        <i class="fas fa-user-circle" style="width:16px;color:#94a3b8;"></i> Mes
                                        Informations
                                    </a>
                                    <a href="historique"
                                        style="display:flex;align-items:center;gap:10px;padding:10px 12px;border-radius:10px;text-decoration:none;color:#7c3aed;font-size:0.875rem;font-weight:700;background:#ede9fe;">
                                        <i class="fas fa-shopping-bag" style="width:16px;color:#7c3aed;"></i> Mes
                                        Commandes
                                    </a>
                                    <div style="height:1px;background:#f1f5f9;margin:6px 0;"></div>
                                    <a href="logout"
                                        style="display:flex;align-items:center;gap:10px;padding:10px 12px;border-radius:10px;text-decoration:none;color:#ef4444;font-size:0.875rem;font-weight:600;transition:all 0.15s;"
                                        onmouseover="this.style.background='#fff1f2'"
                                        onmouseout="this.style.background='transparent'">
                                        <i class="fas fa-sign-out-alt" style="width:16px;"></i> Déconnexion
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Orders Content -->
                        <div class="col-lg-9">
                            <div
                                style="background:white;border-radius:18px;border:1px solid #e2e8f0;box-shadow:0 4px 20px rgba(0,0,0,0.06);">
                                <div
                                    style="padding:20px 24px;border-bottom:1px solid #f1f5f9;display:flex;justify-content:space-between;align-items:center;">
                                    <span style="font-size:1rem;font-weight:800;color:#0f172a;">Mes Commandes</span>
                                    <c:if test="${not empty commandes}">
                                        <span
                                            style="background:#ede9fe;color:#7c3aed;padding:5px 14px;border-radius:20px;font-size:0.78rem;font-weight:700;">${commandes.size()}
                                            commande(s)</span>
                                    </c:if>
                                </div>

                                <c:choose>
                                    <c:when test="${empty commandes}">
                                        <div style="text-align:center;padding:72px 32px;">
                                            <div style="font-size:56px;color:#e2e8f0;margin-bottom:16px;"><i
                                                    class="fas fa-box-open"></i></div>
                                            <h4 style="font-weight:700;color:#334155;margin-bottom:8px;">Aucune commande
                                            </h4>
                                            <p style="color:#94a3b8;margin-bottom:24px;">Vous n'avez pas encore passé de
                                                commande.</p>
                                            <a href="catalogue" class="btn-accent">Découvrir nos produits</a>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div style="padding:8px;">
                                            <c:forEach var="commande" items="${commandes}" varStatus="s">
                                                <div style="border:1px solid #f1f5f9;border-radius:14px;margin:10px;overflow:hidden;transition:all 0.2s;cursor:default;"
                                                    class="fade-in" style="animation-delay:${s.index * 0.06}s;">
                                                    <div
                                                        style="display:flex;justify-content:space-between;align-items:center;padding:16px 20px;background:#fafbff;border-bottom:1px solid #f1f5f9;flex-wrap:wrap;gap:12px;">
                                                        <div
                                                            style="display:flex;align-items:center;gap:16px;flex-wrap:wrap;gap:12px;">
                                                            <span
                                                                style="font-size:1rem;font-weight:800;color:#7c3aed;">#${commande.id}</span>
                                                            <div style="font-size:0.78rem;color:#94a3b8;"><i
                                                                    class="fas fa-calendar-alt me-1"></i>${commande.dateCommande}
                                                            </div>
                                                        </div>
                                                        <div style="display:flex;align-items:center;gap:12px;">
                                                            <c:choose>
                                                                <c:when test="${commande.statut == 'EN_ATTENTE'}"><span
                                                                        class="badge-client badge-attente">EN
                                                                        ATTENTE</span></c:when>
                                                                <c:when test="${commande.statut == 'EN_PREPARATION'}">
                                                                    <span class="badge-client badge-preparation">EN
                                                                        PRÉPARATION</span></c:when>
                                                                <c:when test="${commande.statut == 'EXPEDIEE'}"><span
                                                                        class="badge-client badge-expediee">EXPÉDIÉE</span>
                                                                </c:when>
                                                                <c:when test="${commande.statut == 'LIVREE'}"><span
                                                                        class="badge-client badge-livree">LIVRÉE
                                                                        ✓</span></c:when>
                                                                <c:otherwise><span
                                                                        class="badge-client badge-annulee">ANNULÉE</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <a href="commande-detail?id=${commande.id}"
                                                                class="btn-outline-accent"
                                                                style="padding:7px 16px;font-size:0.8rem;border-radius:8px;">
                                                                <i class="fas fa-eye me-1"></i> Détails
                                                            </a>
                                                        </div>
                                                    </div>
                                                    <div style="padding:16px 20px;">
                                                        <div
                                                            style="display:flex;gap:12px;align-items:center;flex-wrap:wrap;">
                                                            <c:forEach var="item" items="${commande.items}" end="2">
                                                                <div
                                                                    style="display:flex;align-items:center;gap:8px;background:#f8fafc;border-radius:10px;padding:8px 12px;">
                                                                    <img src="${not empty item.produit.imageUrl ? item.produit.imageUrl : 'https://placehold.co/36x36/f3f4f6/94a3b8?text=IMG'}"
                                                                        style="width:36px;height:36px;object-fit:contain;border-radius:6px;"
                                                                        onerror="this.src='https://placehold.co/36x36/f3f4f6/94a3b8?text=IMG'">
                                                                    <div>
                                                                        <div
                                                                            style="font-size:0.78rem;font-weight:600;color:#0f172a;">
                                                                            ${item.produit.nom}</div>
                                                                        <div style="font-size:0.72rem;color:#94a3b8;">
                                                                            ×${item.quantite}</div>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                            <c:if test="${commande.items.size() > 3}">
                                                                <div
                                                                    style="font-size:0.78rem;color:#94a3b8;font-weight:600;">
                                                                    +${commande.items.size() - 3} autre(s)</div>
                                                            </c:if>
                                                            <div style="margin-left:auto;">
                                                                <c:set var="total" value="0" />
                                                                <c:forEach var="item" items="${commande.items}">
                                                                    <c:set var="total"
                                                                        value="${total + (item.prixUnitaire * item.quantite)}" />
                                                                </c:forEach>
                                                                <span
                                                                    style="font-size:1.1rem;font-weight:800;color:#7c3aed;">${total}
                                                                    <small
                                                                        style="font-size:0.7rem;font-weight:500;">MAD</small></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
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