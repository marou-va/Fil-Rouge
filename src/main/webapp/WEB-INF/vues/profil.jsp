<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Mon Compte - MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body>
            <jsp:include page="includes/navbar.jsp" />

            <!-- Profile Header -->
            <div
                style="background:linear-gradient(160deg,#0f0c29,#302b63);padding:44px 0 72px;position:relative;overflow:hidden;">
                <div
                    style="position:absolute;inset:0;background:radial-gradient(ellipse at 30% 50%,rgba(6,182,212,0.2),transparent 60%);">
                </div>
                <div class="container" style="position:relative;">
                    <div class="d-flex align-items-center gap-4">
                        <div
                            style="width:72px;height:72px;background:linear-gradient(135deg,#7c3aed,#06b6d4);border-radius:18px;display:flex;align-items:center;justify-content:center;color:white;font-size:28px;font-weight:800;box-shadow:0 8px 24px rgba(124,58,237,0.4);flex-shrink:0;">
                            ${sessionScope.utilisateur.nom.substring(0,1).toUpperCase()}
                        </div>
                        <div>
                            <div style="font-size:1.6rem;font-weight:800;color:white;">${sessionScope.utilisateur.nom}
                            </div>
                            <div style="color:rgba(255,255,255,0.45);font-size:0.875rem;margin-top:4px;"><i
                                    class="fas fa-envelope me-1"></i>${sessionScope.utilisateur.email}</div>
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
                                    style="display:flex;align-items:center;gap:10px;padding:10px 12px;border-radius:10px;text-decoration:none;color:#7c3aed;font-size:0.875rem;font-weight:700;background:#ede9fe;">
                                    <i class="fas fa-user-circle" style="width:16px;color:#7c3aed;"></i> Mes
                                    Informations
                                </a>
                                <a href="historique"
                                    style="display:flex;align-items:center;gap:10px;padding:10px 12px;border-radius:10px;text-decoration:none;color:#334155;font-size:0.875rem;font-weight:500;transition:all 0.15s;"
                                    onmouseover="this.style.background='#f8fafc'"
                                    onmouseout="this.style.background='transparent'">
                                    <i class="fas fa-shopping-bag" style="width:16px;color:#94a3b8;"></i> Mes Commandes
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

                    <!-- Main Content -->
                    <div class="col-lg-9">
                        <!-- Success alert -->
                        <c:if test="${not empty success}">
                            <div
                                style="background:#f0fdf4;border-left:4px solid #22c55e;border-radius:12px;padding:14px 20px;margin-bottom:20px;display:flex;align-items:center;gap:10px;color:#166534;font-size:0.875rem;font-weight:500;">
                                <i class="fas fa-check-circle"></i> ${success}
                            </div>
                        </c:if>

                        <!-- Personal Info Card -->
                        <div
                            style="background:white;border-radius:18px;border:1px solid #e2e8f0;box-shadow:0 4px 20px rgba(0,0,0,0.06);margin-bottom:20px;">
                            <div style="padding:24px 28px;border-bottom:1px solid #f1f5f9;">
                                <span style="font-size:1rem;font-weight:800;color:#0f172a;">Informations
                                    personnelles</span>
                                <p style="color:#94a3b8;font-size:0.82rem;margin:4px 0 0;">Gérez vos coordonnées et
                                    préférences de compte.</p>
                            </div>
                            <div style="padding:28px;">
                                <form action="profil" method="POST">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="label-client">Nom complet</label>
                                            <div style="position:relative;">
                                                <i class="fas fa-user"
                                                    style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:#94a3b8;font-size:13px;"></i>
                                                <input type="text" name="nom" class="input-client"
                                                    style="padding-left:38px;width:100%;"
                                                    value="${sessionScope.utilisateur.nom}" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="label-client">Adresse email</label>
                                            <div style="position:relative;">
                                                <i class="fas fa-envelope"
                                                    style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:#94a3b8;font-size:13px;"></i>
                                                <input type="email" name="email" class="input-client"
                                                    style="padding-left:38px;width:100%;"
                                                    value="${sessionScope.utilisateur.email}" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="label-client">Téléphone</label>
                                            <div style="position:relative;">
                                                <i class="fas fa-phone"
                                                    style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:#94a3b8;font-size:13px;"></i>
                                                <input type="tel" name="telephone" class="input-client"
                                                    style="padding-left:38px;width:100%;"
                                                    value="${sessionScope.utilisateur.telephone}">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="label-client">Rôle</label>
                                            <div style="position:relative;">
                                                <i class="fas fa-shield-alt"
                                                    style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:#94a3b8;font-size:13px;"></i>
                                                <input type="text" class="input-client"
                                                    style="padding-left:38px;width:100%;background:#f8fafc;cursor:not-allowed;"
                                                    value="${sessionScope.utilisateur.role}" readonly>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <label class="label-client">Adresse de livraison</label>
                                            <div style="position:relative;">
                                                <i class="fas fa-map-marker-alt"
                                                    style="position:absolute;left:14px;top:14px;color:#94a3b8;font-size:13px;"></i>
                                                <textarea name="adresse" class="input-client"
                                                    style="padding-left:38px;width:100%;resize:vertical;"
                                                    rows="2">${sessionScope.utilisateur.adresse}</textarea>
                                            </div>
                                        </div>
                                        <div class="col-12 text-end">
                                            <button type="submit" class="btn-accent px-5 py-2">
                                                <i class="fas fa-save me-2"></i>Enregistrer les modifications
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Security Card -->
                        <div
                            style="background:white;border-radius:18px;border:1px solid #e2e8f0;box-shadow:0 4px 20px rgba(0,0,0,0.06);">
                            <div
                                style="padding:24px 28px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:16px;">
                                <div style="display:flex;align-items:center;gap:16px;">
                                    <div
                                        style="width:48px;height:48px;background:linear-gradient(135deg,#ede9fe,#ddd6fe);border-radius:12px;display:flex;align-items:center;justify-content:center;color:#7c3aed;font-size:18px;flex-shrink:0;">
                                        <i class="fas fa-key"></i>
                                    </div>
                                    <div>
                                        <div style="font-weight:700;color:#0f172a;font-size:0.95rem;">Sécurité du compte
                                        </div>
                                        <div style="color:#94a3b8;font-size:0.8rem;margin-top:2px;">Modifiez votre mot
                                            de passe régulièrement</div>
                                    </div>
                                </div>
                                <button class="btn-outline-accent"
                                    style="border-radius:10px;padding:9px 22px;font-size:0.85rem;" disabled
                                    title="Bientôt disponible">Changer le mot de passe</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="includes/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>