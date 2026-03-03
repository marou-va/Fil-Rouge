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
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap"
                rel="stylesheet">
            <style>
                :root {
                    --brand-color: #f68b1e;
                    --brand-dark: #e57a10;
                    --bg-light: #f8f9fa;
                }

                body {
                    background-color: var(--bg-light);
                    font-family: 'Outfit', sans-serif;
                    display: flex;
                    flex-direction: column;
                    min-height: 100vh;
                }

                .text-brand {
                    color: var(--brand-color) !important;
                }

                .bg-brand {
                    background-color: var(--brand-color) !important;
                }

                .btn-brand {
                    background-color: var(--brand-color);
                    color: white;
                    border: none;
                    font-weight: 600;
                    transition: all 0.3s;
                }

                .btn-brand:hover {
                    background-color: var(--brand-dark);
                    color: white;
                    box-shadow: 0 4px 12px rgba(246, 139, 30, 0.3);
                }

                /* Profile Header */
                .profile-hdr {
                    background: linear-gradient(135deg, #232526 0%, #414345 100%);
                    color: white;
                    padding: 60px 0;
                    margin-bottom: -50px;
                }

                .avatar-circle {
                    width: 100px;
                    height: 100px;
                    background-color: var(--brand-color);
                    color: white;
                    font-size: 2.5rem;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    border-radius: 50%;
                    border: 4px solid rgba(255, 255, 255, 0.2);
                    font-weight: 700;
                }

                /* Sidebar Nav */
                .acc-nav .nav-link {
                    color: #444;
                    padding: 12px 20px;
                    border-radius: 10px;
                    margin-bottom: 5px;
                    font-weight: 500;
                    transition: all 0.2s;
                }

                .acc-nav .nav-link:hover {
                    background-color: rgba(246, 139, 30, 0.1);
                    color: var(--brand-color);
                }

                .acc-nav .nav-link.active {
                    background-color: var(--brand-color);
                    color: white;
                    box-shadow: 0 4px 10px rgba(246, 139, 30, 0.2);
                }

                .acc-nav .nav-link i {
                    width: 25px;
                }

                /* Content Card */
                .content-card {
                    border: none;
                    border-radius: 15px;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                    background: rgba(255, 255, 255, 0.9);
                    backdrop-filter: blur(10px);
                }

                .form-control:focus {
                    border-color: var(--brand-color);
                    box-shadow: 0 0 0 0.25rem rgba(246, 139, 30, 0.1);
                }
            </style>
        </head>

        <body>
            <jsp:include page="includes/navbar.jsp" />

            <div class="profile-hdr">
                <div class="container">
                    <div class="d-flex align-items-center">
                        <div class="avatar-circle me-4">
                            ${sessionScope.utilisateur.nom.substring(0,1).toUpperCase()}
                        </div>
                        <div>
                            <h2 class="fw-bold mb-1">${sessionScope.utilisateur.nom}</h2>
                            <p class="mb-0 text-white-50"><i
                                    class="fas fa-envelope me-2"></i>${sessionScope.utilisateur.email}</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container mb-5">
                <div class="row">
                    <!-- Navigation Latérale -->
                    <div class="col-lg-3">
                        <div class="content-card p-3 mb-4">
                            <nav class="nav flex-column acc-nav">
                                <a class="nav-link active" href="profil"><i class="fas fa-user-circle"></i> Mes
                                    Informations</a>
                                <a class="nav-link" href="#"><i class="fas fa-shopping-bag"></i> Mes Commandes</a>
                                <a class="nav-link" href="#"><i class="fas fa-heart"></i> Ma Liste de Souhaits</a>
                                <a class="nav-link" href="#"><i class="fas fa-map-marker-alt"></i> Mes Adresses</a>
                                <hr class="my-2">
                                <a class="nav-link text-danger" href="logout"><i class="fas fa-sign-out-alt"></i>
                                    Déconnexion</a>
                            </nav>
                        </div>
                    </div>

                    <!-- Contenu Principal -->
                    <div class="col-lg-9">
                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible border-0 shadow-sm mb-4 fade show"
                                role="alert">
                                <i class="fas fa-check-circle me-2"></i> ${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"
                                    aria-label="Close"></button>
                            </div>
                        </c:if>

                        <div class="content-card">
                            <div class="card-header bg-transparent border-0 pt-4 px-4">
                                <h5 class="fw-bold mb-0">Informations Personnelles</h5>
                                <p class="text-muted small">Gérez vos coordonnées et préferences de compte.</p>
                            </div>
                            <div class="card-body p-4 pt-2">
                                <form action="profil" method="POST">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label fw-600">Nom complet</label>
                                            <div class="input-group">
                                                <span class="input-group-text bg-light border-end-0"><i
                                                        class="fas fa-user text-muted"></i></span>
                                                <input type="text" name="nom"
                                                    class="form-control border-start-0 bg-light"
                                                    value="${sessionScope.utilisateur.nom}" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-600">Adresse Email</label>
                                            <div class="input-group">
                                                <span class="input-group-text bg-light border-end-0"><i
                                                        class="fas fa-at text-muted"></i></span>
                                                <input type="email" name="email"
                                                    class="form-control border-start-0 bg-light"
                                                    value="${sessionScope.utilisateur.email}" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-600 text-muted">Statut du Compte</label>
                                            <div class="input-group">
                                                <span class="input-group-text bg-light border-end-0"><i
                                                        class="fas fa-shield-alt text-muted text-success"></i></span>
                                                <input type="text" class="form-control border-start-0 bg-light"
                                                    value="${sessionScope.utilisateur.role}" readonly>
                                            </div>
                                        </div>
                                        <div class="col-12 mt-4 text-end">
                                            <button type="submit" class="btn btn-brand px-5 py-2">
                                                Sauvegarder les changements
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Section Sécurité -->
                        <div class="content-card mt-4">
                            <div class="card-body p-4 d-flex align-items-center">
                                <div class="flex-shrink-0 bg-light p-3 rounded-circle me-3">
                                    <i class="fas fa-key fa-2x text-brand"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <h6 class="fw-bold mb-1">Sécurité du Compte</h6>
                                    <p class="text-muted small mb-0">Modifiez votre mot de passe pour assurer la
                                        sécurité de vos données.</p>
                                </div>
                                <button class="btn btn-outline-dark fw-bold px-4">Changer</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="includes/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>