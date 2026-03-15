<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Choisir un espace — MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
            <style>
                body {
                    min-height: 100vh;
                    background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary-mid) 55%, var(--info) 100%);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .choice-wrap {
                    max-width: 820px;
                    width: 100%;
                    padding: 1.5rem;
                }

                .choice-card-wrap {
                    background: rgba(255, 255, 255, 0.92);
                    border-radius: var(--radius-lg);
                    box-shadow: var(--shadow-lg);
                    padding: 3rem 2.5rem;
                }

                .space-card {
                    border: 2px solid var(--border-color);
                    border-radius: var(--radius-lg);
                    padding: 2.5rem 2rem;
                    text-align: center;
                    cursor: pointer;
                    transition: var(--transition);
                    text-decoration: none;
                    color: var(--text-dark);
                    display: block;
                }

                .space-card:hover {
                    border-color: var(--primary);
                    box-shadow: var(--shadow-md);
                    transform: translateY(-6px);
                    color: var(--text-dark);
                }

                .space-icon {
                    width: 80px;
                    height: 80px;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 2rem;
                    margin: 0 auto 1.25rem;
                    transition: var(--transition);
                }

                .space-card:hover .icon-client {
                    background: var(--primary);
                    color: #fff;
                }

                .space-card:hover .icon-admin {
                    background: var(--accent);
                    color: #fff;
                }

                .icon-client {
                    background: rgba(142, 153, 121, 0.15);
                    color: var(--primary);
                }

                .icon-admin {
                    background: rgba(163, 124, 122, 0.15);
                    color: var(--accent);
                }

                .logout-btn {
                    position: absolute;
                    top: 1.5rem;
                    right: 1.5rem;
                }
            </style>
        </head>

        <body>
            <a href="logout" class="btn btn-outline-brand logout-btn border-2"
                style="border-color:rgba(255,255,255,0.5);color:#fff;">
                <i class="fas fa-sign-out-alt me-2"></i>Déconnexion
            </a>

            <div class="choice-wrap">
                <div class="choice-card-wrap">
                    <div class="text-center mb-5">
                        <span
                            style="font-family:'Playfair Display',serif;font-size:1.8rem;color:var(--primary-dark);font-weight:700;">
                            <i class="fas fa-leaf me-2" style="color:var(--primary);"></i>MaBoutique
                        </span>
                        <h2 class="mt-3 fw-bold mb-1">Bonjour, ${sessionScope.utilisateur.nom} 👋</h2>
                        <p class="text-muted mb-0">Quel espace souhaitez-vous accéder ?</p>
                    </div>

                    <div class="row g-4">
                        <div class="col-md-6">
                            <a href="catalogue" class="space-card">
                                <div class="space-icon icon-client">
                                    <i class="fas fa-shopping-bag"></i>
                                </div>
                                <h4 class="fw-bold mb-2">Espace Client</h4>
                                <p class="text-muted small mb-0">Parcourir le catalogue, ajouter au panier et passer des
                                    commandes.</p>
                            </a>
                        </div>
                        <div class="col-md-6">
                            <a href="admin/dashboard" class="space-card">
                                <div class="space-icon icon-admin">
                                    <i class="fas fa-sliders-h"></i>
                                </div>
                                <h4 class="fw-bold mb-2">Espace Admin</h4>
                                <p class="text-muted small mb-0">Gérer les produits, catégories, commandes et
                                    utilisateurs.</p>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>