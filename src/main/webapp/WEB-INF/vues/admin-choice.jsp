<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Choix de l'espace - MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                body {
                    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                    height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                }

                .choice-card {
                    background: rgba(255, 255, 255, 0.9);
                    backdrop-filter: blur(10px);
                    border-radius: 20px;
                    padding: 40px;
                    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                    text-align: center;
                    max-width: 800px;
                    width: 100%;
                }

                .choice-item {
                    cursor: pointer;
                    transition: all 0.3s ease;
                    border: 2px solid transparent;
                    border-radius: 15px;
                    padding: 30px;
                    height: 100%;
                }

                .choice-item:hover {
                    transform: translateY(-10px);
                    background: white;
                    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
                    border-color: #f68b1e;
                }

                .icon-circle {
                    width: 80px;
                    height: 80px;
                    background: #fff3e6;
                    color: #f68b1e;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    border-radius: 50%;
                    margin: 0 auto 20px;
                    font-size: 32px;
                }

                .admin-circle {
                    background: #eef2ff;
                    color: #4f46e5;
                }

                .choice-item:hover .admin-circle {
                    background: #4f46e5;
                    color: white;
                }

                .choice-item:hover .icon-circle:not(.admin-circle) {
                    background: #f68b1e;
                    color: white;
                }

                h1 {
                    font-weight: 800;
                    color: #2d3748;
                    margin-bottom: 30px;
                }

                .btn-logout {
                    position: absolute;
                    top: 20px;
                    right: 20px;
                }
            </style>
        </head>

        <body>
            <a href="logout" class="btn btn-outline-danger btn-logout">
                <i class="fas fa-sign-out-alt me-2"></i>Déconnexion
            </a>

            <div class="container">
                <div class="choice-card mx-auto">
                    <h1 class="mb-5">Bienvenue, ${utilisateur.nom}</h1>
                    <p class="text-muted mb-5">Veuillez choisir l'espace que vous souhaitez accéder :</p>

                    <div class="row g-4">
                        <div class="col-md-6">
                            <a href="catalogue" class="text-decoration-none text-dark">
                                <div class="choice-item">
                                    <div class="icon-circle">
                                        <i class="fas fa-shopping-bag"></i>
                                    </div>
                                    <h3>Espace Client</h3>
                                    <p class="text-muted small">Accéder à la boutique, voir les produits et passer des
                                        commandes.</p>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-6">
                            <a href="admin/dashboard" class="text-decoration-none text-dark">
                                <div class="choice-item">
                                    <div class="icon-circle admin-circle">
                                        <i class="fas fa-user-shield"></i>
                                    </div>
                                    <h3>Espace Admin</h3>
                                    <p class="text-muted small">Gérer les produits, les catégories, suivre les commandes
                                        et les utilisateurs.</p>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>