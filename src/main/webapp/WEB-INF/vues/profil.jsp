<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Mon Profil — MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
            <style>
                .profile-hero {
                    background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary-mid) 100%);
                    padding: 3rem 0 5rem;
                    color: #fff;
                }

                .avatar-circle {
                    width: 90px;
                    height: 90px;
                    background: var(--primary);
                    border: 3px solid rgba(255, 255, 255, 0.3);
                    border-radius: 50%;
                    font-size: 2.2rem;
                    font-weight: 700;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: #fff;
                }

                .profile-content {
                    margin-top: -3rem;
                }

                .side-nav .nav-link {
                    color: var(--text-dark);
                    font-weight: 600;
                    padding: 0.65rem 1rem;
                    border-radius: var(--radius);
                    transition: var(--transition);
                    margin-bottom: 3px;
                }

                .side-nav .nav-link i {
                    width: 22px;
                }

                .side-nav .nav-link:hover {
                    background: rgba(142, 153, 121, 0.12);
                    color: var(--primary-dark);
                }

                .side-nav .nav-link.active {
                    background: var(--primary);
                    color: #fff;
                }
            </style>
        </head>

        <body>
            <jsp:include page="includes/navbar.jsp" />

            <div class="profile-hero">
                <div class="container">
                    <div class="d-flex align-items-center gap-4">
                        <div class="avatar-circle">${sessionScope.utilisateur.nom.substring(0,1).toUpperCase()}</div>
                        <div>
                            <h2 class="fw-bold mb-1">${sessionScope.utilisateur.nom}</h2>
                            <p class="mb-0" style="color:rgba(255,255,255,0.70);">
                                <i class="fas fa-envelope me-2"></i>${sessionScope.utilisateur.email}
                            </p>
                            <c:if test="${sessionScope.utilisateur.role == 'ADMIN'}">
                                <span class="badge mt-2" style="background:var(--accent);font-size:.75rem;">
                                    <i class="fas fa-shield-alt me-1"></i>Administrateur
                                </span>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container profile-content pb-5">
                <div class="row g-4">
                    <!-- Nav latérale -->
                    <div class="col-lg-3">
                        <div class="card-theme p-3">
                            <nav class="nav flex-column side-nav">
                                <a class="nav-link active" href="profil"><i class="fas fa-user-circle"></i>Mes
                                    Informations</a>
                                <a class="nav-link" href="historique"><i class="fas fa-receipt"></i>Mes Commandes</a>
                                <a class="nav-link" href="#"><i class="fas fa-heart"></i>Liste de Souhaits</a>
                                <hr class="my-2" style="border-color:var(--border-color);">
                                <a class="nav-link" style="color:var(--accent)!important;" href="logout">
                                    <i class="fas fa-sign-out-alt"></i>Déconnexion
                                </a>
                            </nav>
                        </div>
                    </div>

                    <!-- Contenu -->
                    <div class="col-lg-9">
                        <c:if test="${not empty success}">
                            <div class="alert alert-brand alert-dismissible fade show mb-4" role="alert">
                                <i class="fas fa-check-circle me-2"></i>${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <div class="card-theme p-4 mb-4">
                            <h5 class="fw-bold mb-1">Informations Personnelles</h5>
                            <p class="text-muted small mb-4">Modifiez vos coordonnées et enregistrez.</p>
                            <form action="profil" method="POST">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small text-uppercase"
                                            style="color:var(--text-muted);">Nom complet</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                                            <input type="text" name="nom" class="form-control"
                                                value="${sessionScope.utilisateur.nom}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small text-uppercase"
                                            style="color:var(--text-muted);">Email</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-at"></i></span>
                                            <input type="email" name="email" class="form-control"
                                                value="${sessionScope.utilisateur.email}" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small text-uppercase"
                                            style="color:var(--text-muted);">Téléphone</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                            <input type="tel" name="telephone" class="form-control"
                                                value="${sessionScope.utilisateur.telephone}">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small text-uppercase"
                                            style="color:var(--text-muted);">Adresse</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                            <input type="text" name="adresse" class="form-control"
                                                value="${sessionScope.utilisateur.adresse}">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold small text-uppercase"
                                            style="color:var(--text-muted);">Rôle</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-shield-alt"></i></span>
                                            <input type="text" class="form-control"
                                                value="${sessionScope.utilisateur.role}" readonly
                                                style="background:#faf9f8;">
                                        </div>
                                    </div>
                                    <div class="col-12 text-end mt-2">
                                        <button type="submit" class="btn btn-brand px-5 py-2 fw-bold">
                                            <i class="fas fa-save me-2"></i>Enregistrer les modifications
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="card-theme p-4">
                            <div class="d-flex align-items-center gap-3">
                                <div class="rounded-circle d-flex align-items-center justify-content-center flex-shrink-0"
                                    style="width:52px;height:52px;background:rgba(163,124,122,0.12);">
                                    <i class="fas fa-key fa-lg" style="color:var(--accent);"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <h6 class="fw-bold mb-0">Sécurité du Compte</h6>
                                    <p class="text-muted small mb-0">Modifiez votre mot de passe pour sécuriser vos
                                        données.</p>
                                </div>
                                <button class="btn btn-outline-brand fw-bold px-4">Changer</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="includes/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>