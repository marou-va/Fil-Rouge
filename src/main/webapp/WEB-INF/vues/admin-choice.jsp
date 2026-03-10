<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Accès Administrateur - MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                rel="stylesheet">
            <style>
                * {
                    font-family: 'Inter', sans-serif;
                }

                body {
                    background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%);
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    position: relative;
                    overflow: hidden;
                }

                /* Animated background blobs */
                .blob {
                    position: absolute;
                    border-radius: 50%;
                    filter: blur(80px);
                    opacity: 0.15;
                    animation: float 8s ease-in-out infinite;
                }

                .blob-1 {
                    width: 400px;
                    height: 400px;
                    background: #7c3aed;
                    top: -100px;
                    left: -100px;
                    animation-delay: 0s;
                }

                .blob-2 {
                    width: 300px;
                    height: 300px;
                    background: #06b6d4;
                    bottom: -80px;
                    right: -60px;
                    animation-delay: 3s;
                }

                .blob-3 {
                    width: 200px;
                    height: 200px;
                    background: #f59e0b;
                    top: 50%;
                    left: 50%;
                    animation-delay: 5s;
                }

                @keyframes float {

                    0%,
                    100% {
                        transform: translate(0, 0) scale(1);
                    }

                    33% {
                        transform: translate(30px, -20px) scale(1.05);
                    }

                    66% {
                        transform: translate(-20px, 30px) scale(0.95);
                    }
                }

                .choice-container {
                    position: relative;
                    z-index: 10;
                    width: 100%;
                    max-width: 680px;
                    padding: 24px;
                }

                .choice-header {
                    text-align: center;
                    margin-bottom: 40px;
                }

                .choice-header .brand-badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 10px;
                    background: rgba(255, 255, 255, 0.08);
                    backdrop-filter: blur(10px);
                    border: 1px solid rgba(255, 255, 255, 0.12);
                    border-radius: 50px;
                    padding: 8px 20px;
                    margin-bottom: 20px;
                }

                .brand-badge .dot {
                    width: 8px;
                    height: 8px;
                    background: #22c55e;
                    border-radius: 50%;
                    box-shadow: 0 0 8px #22c55e;
                    animation: pulse 2s infinite;
                }

                @keyframes pulse {

                    0%,
                    100% {
                        opacity: 1
                    }

                    50% {
                        opacity: 0.4
                    }
                }

                .brand-badge span {
                    color: rgba(255, 255, 255, 0.75);
                    font-size: 0.82rem;
                    font-weight: 600;
                }

                .choice-header h1 {
                    font-size: 2.2rem;
                    font-weight: 800;
                    color: white;
                    margin-bottom: 8px;
                    line-height: 1.2;
                }

                .choice-header p {
                    color: rgba(255, 255, 255, 0.5);
                    font-size: 0.95rem;
                }

                .choice-grid {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 20px;
                }

                .choice-card {
                    background: rgba(255, 255, 255, 0.06);
                    backdrop-filter: blur(20px);
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    border-radius: 20px;
                    padding: 32px 24px;
                    text-decoration: none;
                    transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
                    display: flex;
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 16px;
                    position: relative;
                    overflow: hidden;
                }

                .choice-card::before {
                    content: '';
                    position: absolute;
                    inset: 0;
                    opacity: 0;
                    transition: opacity 0.35s;
                }

                .choice-card-client::before {
                    background: linear-gradient(135deg, rgba(6, 182, 212, 0.15), rgba(124, 58, 237, 0.1));
                }

                .choice-card-admin::before {
                    background: linear-gradient(135deg, rgba(124, 58, 237, 0.2), rgba(245, 158, 11, 0.1));
                }

                .choice-card:hover {
                    transform: translateY(-8px);
                    border-color: rgba(255, 255, 255, 0.25);
                    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
                }

                .choice-card:hover::before {
                    opacity: 1;
                }

                .card-icon-wrap {
                    width: 56px;
                    height: 56px;
                    border-radius: 16px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 24px;
                    position: relative;
                    z-index: 1;
                }

                .icon-client {
                    background: linear-gradient(135deg, #06b6d4, #0891b2);
                    color: white;
                    box-shadow: 0 8px 24px rgba(6, 182, 212, 0.4);
                }

                .icon-admin {
                    background: linear-gradient(135deg, #7c3aed, #a855f7);
                    color: white;
                    box-shadow: 0 8px 24px rgba(124, 58, 237, 0.4);
                }

                .card-content {
                    position: relative;
                    z-index: 1;
                }

                .card-content h3 {
                    font-size: 1.15rem;
                    font-weight: 700;
                    color: white;
                    margin: 0 0 6px;
                }

                .card-content p {
                    font-size: 0.83rem;
                    color: rgba(255, 255, 255, 0.5);
                    margin: 0;
                    line-height: 1.5;
                }

                .card-arrow {
                    margin-top: auto;
                    width: 36px;
                    height: 36px;
                    background: rgba(255, 255, 255, 0.08);
                    border-radius: 10px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: rgba(255, 255, 255, 0.5);
                    font-size: 13px;
                    transition: all 0.25s;
                    position: relative;
                    z-index: 1;
                }

                .choice-card:hover .card-arrow {
                    background: rgba(255, 255, 255, 0.2);
                    color: white;
                    transform: translateX(4px);
                }

                .logout-link {
                    text-align: center;
                    margin-top: 28px;
                    position: relative;
                    z-index: 10;
                }

                .logout-link a {
                    color: rgba(255, 255, 255, 0.35);
                    font-size: 0.82rem;
                    text-decoration: none;
                    transition: color 0.2s;
                }

                .logout-link a:hover {
                    color: rgba(255, 255, 255, 0.7);
                }
            </style>
        </head>

        <body>
            <div class="blob blob-1"></div>
            <div class="blob blob-2"></div>
            <div class="blob blob-3"></div>

            <div class="choice-container">
                <div class="choice-header">
                    <div class="brand-badge">
                        <div class="dot"></div>
                        <span>Session active — ${sessionScope.utilisateur.nom}</span>
                    </div>
                    <h1>Quel espace souhaitez-vous ?</h1>
                    <p>Choisissez entre l'espace boutique et la console d'administration.</p>
                </div>

                <div class="choice-grid">
                    <a href="catalogue" class="choice-card choice-card-client">
                        <div class="card-icon-wrap icon-client">
                            <i class="fas fa-shopping-bag"></i>
                        </div>
                        <div class="card-content">
                            <h3>Espace Boutique</h3>
                            <p>Parcourir les produits, panier et commandes en tant que client.</p>
                        </div>
                        <div class="card-arrow"><i class="fas fa-arrow-right"></i></div>
                    </a>

                    <a href="admin/dashboard" class="choice-card choice-card-admin">
                        <div class="card-icon-wrap icon-admin">
                            <i class="fas fa-chart-pie"></i>
                        </div>
                        <div class="card-content">
                            <h3>Administration</h3>
                            <p>Gérer produits, catégories, commandes et utilisateurs.</p>
                        </div>
                        <div class="card-arrow"><i class="fas fa-arrow-right"></i></div>
                    </a>
                </div>

                <div class="logout-link">
                    <a href="logout"><i class="fas fa-sign-out-alt me-1"></i> Se déconnecter</a>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>