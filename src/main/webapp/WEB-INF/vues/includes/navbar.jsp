<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">
        <nav class="shop-navbar sticky-top" id="shopNav">
            <div class="container">
                <div class="nav-inner">
                    <!-- Brand -->
                    <a class="shop-brand" href="catalogue">
                        <span class="brand-icon-shop"><i class="fas fa-bolt"></i></span>
                        <span class="brand-text-shop">MaBoutique</span>
                    </a>

                    <!-- Search -->
                    <form action="catalogue" method="GET" class="shop-search-form">
                        <div class="search-wrap">
                            <i class="fas fa-search search-icon"></i>
                            <input type="text" name="search" class="shop-search-input" value="${param.search}"
                                placeholder="Rechercher un produit, une marque...">
                            <button type="submit" class="search-btn">Chercher</button>
                        </div>
                    </form>

                    <!-- Actions -->
                    <div class="nav-actions">
                        <c:choose>
                            <c:when test="${not empty sessionScope.utilisateur}">
                                <a href="panier" class="cart-btn">
                                    <i class="fas fa-shopping-bag"></i>
                                    <c:if test="${not empty sessionScope.cartSize && sessionScope.cartSize > 0}">
                                        <span class="cart-badge">${sessionScope.cartSize}</span>
                                    </c:if>
                                </a>
                                <div class="user-menu-wrap">
                                    <button class="user-btn" id="userMenuBtn">
                                        <span class="user-avatar-nav"><i class="fas fa-user"></i></span>
                                        <span class="user-name-nav">${sessionScope.utilisateur.nom.split(' ')[0]}</span>
                                        <i class="fas fa-chevron-down chevron-icon"></i>
                                    </button>
                                    <div class="user-dropdown" id="userDropdown">
                                        <div class="dropdown-header">
                                            <div class="dh-name">${sessionScope.utilisateur.nom}</div>
                                            <div class="dh-email">${sessionScope.utilisateur.email}</div>
                                        </div>
                                        <c:if test="${sessionScope.utilisateur.role == 'ADMIN'}">
                                            <a href="admin-choice" class="dropdown-item-shop admin-link">
                                                <i class="fas fa-user-shield"></i> Administration
                                            </a>
                                            <div class="dropdown-sep"></div>
                                        </c:if>
                                        <a href="profil" class="dropdown-item-shop"><i class="fas fa-user-circle"></i>
                                            Mon Profil</a>
                                        <a href="historique" class="dropdown-item-shop"><i class="fas fa-box"></i> Mes
                                            Commandes</a>
                                        <div class="dropdown-sep"></div>
                                        <a href="logout" class="dropdown-item-shop danger-item"><i
                                                class="fas fa-sign-out-alt"></i> Déconnexion</a>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="login" class="btn-login-nav">Se connecter</a>
                                <a href="register" class="btn-register-nav">S'inscrire</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>

        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

            :root {
                --accent: #7c3aed;
                --accent-light: #a78bfa;
                --accent-bg: #ede9fe;
                --teal: #06b6d4;
                --amber: #f59e0b;
                --text-primary: #0f172a;
                --text-secondary: #64748b;
                --border: #e2e8f0;
                --surface: #ffffff;
                --bg: #f8fafc;
            }

            * {
                font-family: 'Inter', sans-serif;
                box-sizing: border-box;
            }

            .shop-navbar {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(20px);
                border-bottom: 1px solid var(--border);
                z-index: 1000;
                box-shadow: 0 1px 20px rgba(0, 0, 0, 0.06);
            }

            .nav-inner {
                display: flex;
                align-items: center;
                gap: 24px;
                padding: 12px 0;
            }

            .shop-brand {
                display: flex;
                align-items: center;
                gap: 10px;
                text-decoration: none;
                flex-shrink: 0;
            }

            .brand-icon-shop {
                width: 36px;
                height: 36px;
                background: linear-gradient(135deg, var(--accent), var(--teal));
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 15px;
                box-shadow: 0 4px 12px rgba(124, 58, 237, 0.3);
            }

            .brand-text-shop {
                font-size: 1.15rem;
                font-weight: 800;
                color: var(--text-primary);
            }

            .shop-search-form {
                flex: 1;
                max-width: 520px;
            }

            .search-wrap {
                display: flex;
                align-items: center;
                background: var(--bg);
                border: 1.5px solid var(--border);
                border-radius: 12px;
                padding: 0 6px 0 16px;
                transition: border-color 0.2s, box-shadow 0.2s;
            }

            .search-wrap:focus-within {
                border-color: var(--accent);
                box-shadow: 0 0 0 3px rgba(124, 58, 237, 0.1);
            }

            .search-icon {
                color: #94a3b8;
                font-size: 13px;
            }

            .shop-search-input {
                flex: 1;
                border: none;
                background: transparent;
                padding: 10px 12px;
                font-size: 0.875rem;
                color: var(--text-primary);
                outline: none;
            }

            .search-btn {
                background: linear-gradient(135deg, var(--accent), #a855f7);
                color: white;
                border: none;
                border-radius: 8px;
                padding: 8px 18px;
                font-size: 0.82rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s;
            }

            .search-btn:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(124, 58, 237, 0.3);
            }

            .nav-actions {
                display: flex;
                align-items: center;
                gap: 12px;
                flex-shrink: 0;
            }

            .cart-btn {
                position: relative;
                width: 42px;
                height: 42px;
                background: var(--bg);
                border: 1.5px solid var(--border);
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--text-primary);
                font-size: 16px;
                text-decoration: none;
                transition: all 0.2s;
            }

            .cart-btn:hover {
                border-color: var(--accent);
                color: var(--accent);
                background: var(--accent-bg);
            }

            .cart-badge {
                position: absolute;
                top: -6px;
                right: -6px;
                background: linear-gradient(135deg, var(--accent), #a855f7);
                color: white;
                font-size: 10px;
                font-weight: 700;
                width: 18px;
                height: 18px;
                border-radius: 9px;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 2px solid white;
            }

            .user-menu-wrap {
                position: relative;
            }

            .user-btn {
                display: flex;
                align-items: center;
                gap: 8px;
                background: var(--bg);
                border: 1.5px solid var(--border);
                border-radius: 10px;
                padding: 8px 14px;
                cursor: pointer;
                font-size: 0.875rem;
                font-weight: 500;
                color: var(--text-primary);
                transition: all 0.2s;
            }

            .user-btn:hover {
                border-color: var(--accent);
            }

            .user-avatar-nav {
                width: 26px;
                height: 26px;
                background: var(--accent-bg);
                border-radius: 6px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--accent);
                font-size: 12px;
            }

            .user-name-nav {
                font-size: 0.82rem;
                font-weight: 600;
            }

            .chevron-icon {
                font-size: 10px;
                color: #94a3b8;
                transition: transform 0.2s;
            }

            .user-btn.open .chevron-icon {
                transform: rotate(180deg);
            }

            .user-dropdown {
                position: absolute;
                top: calc(100% + 10px);
                right: 0;
                background: white;
                border: 1.5px solid var(--border);
                border-radius: 14px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
                min-width: 220px;
                padding: 8px;
                z-index: 1001;
                display: none;
                animation: dropIn 0.2s ease;
            }

            @keyframes dropIn {
                from {
                    opacity: 0;
                    transform: translateY(-8px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .user-dropdown.open {
                display: block;
            }

            .dropdown-header {
                padding: 10px 12px 12px;
                border-bottom: 1px solid var(--border);
                margin-bottom: 6px;
            }

            .dh-name {
                font-size: 0.875rem;
                font-weight: 700;
                color: var(--text-primary);
            }

            .dh-email {
                font-size: 0.75rem;
                color: #94a3b8;
                margin-top: 2px;
            }

            .dropdown-item-shop {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 9px 12px;
                border-radius: 8px;
                text-decoration: none;
                font-size: 0.85rem;
                font-weight: 500;
                color: var(--text-primary);
                transition: all 0.15s;
            }

            .dropdown-item-shop i {
                width: 16px;
                text-align: center;
                color: #94a3b8;
            }

            .dropdown-item-shop:hover {
                background: var(--bg);
            }

            .admin-link {
                color: var(--accent) !important;
                font-weight: 600;
            }

            .admin-link i {
                color: var(--accent) !important;
            }

            .admin-link:hover {
                background: var(--accent-bg) !important;
            }

            .danger-item {
                color: #ef4444 !important;
            }

            .danger-item i {
                color: #ef4444 !important;
            }

            .danger-item:hover {
                background: #fff1f2 !important;
            }

            .dropdown-sep {
                height: 1px;
                background: var(--border);
                margin: 6px 0;
            }

            .btn-login-nav {
                padding: 9px 20px;
                border: 1.5px solid var(--border);
                border-radius: 10px;
                text-decoration: none;
                font-size: 0.875rem;
                font-weight: 600;
                color: var(--text-primary);
                transition: all 0.2s;
            }

            .btn-login-nav:hover {
                border-color: var(--accent);
                color: var(--accent);
            }

            .btn-register-nav {
                padding: 9px 20px;
                background: linear-gradient(135deg, var(--accent), #a855f7);
                color: white;
                border: none;
                border-radius: 10px;
                text-decoration: none;
                font-size: 0.875rem;
                font-weight: 600;
                transition: all 0.25s;
                box-shadow: 0 4px 14px rgba(124, 58, 237, 0.3);
            }

            .btn-register-nav:hover {
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(124, 58, 237, 0.4);
            }

            /* ── Shared Client CSS ── */
            body {
                background: var(--bg);
                font-family: 'Inter', sans-serif;
                color: var(--text-primary);
            }

            .btn-accent {
                background: linear-gradient(135deg, var(--accent), #a855f7);
                color: white;
                border: none;
                border-radius: 12px;
                padding: 12px 28px;
                font-size: 0.95rem;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.25s;
                box-shadow: 0 4px 16px rgba(124, 58, 237, 0.3);
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-accent:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 24px rgba(124, 58, 237, 0.45);
                color: white;
            }

            .btn-accent:disabled {
                opacity: 0.55;
                cursor: not-allowed;
                transform: none;
            }

            .btn-outline-accent {
                background: transparent;
                color: var(--accent);
                border: 2px solid var(--accent);
                border-radius: 12px;
                padding: 11px 24px;
                font-size: 0.9rem;
                font-weight: 600;
                transition: all 0.2s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                text-decoration: none;
            }

            .btn-outline-accent:hover {
                background: var(--accent);
                color: white;
            }

            .client-card {
                background: white;
                border: 1px solid var(--border);
                border-radius: 16px;
                box-shadow: 0 2px 16px rgba(0, 0, 0, 0.05);
                transition: transform 0.3s, box-shadow 0.3s;
                overflow: hidden;
            }

            .client-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 12px 36px rgba(0, 0, 0, 0.1);
            }

            .form-group-client {
                margin-bottom: 20px;
            }

            .label-client {
                font-size: 0.78rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.06em;
                color: var(--text-secondary);
                margin-bottom: 8px;
                display: block;
            }

            .input-client {
                width: 100%;
                border: 1.5px solid var(--border);
                border-radius: 10px;
                padding: 11px 16px;
                font-size: 0.875rem;
                color: var(--text-primary);
                background: white;
                transition: all 0.2s;
                outline: none;
                font-family: 'Inter', sans-serif;
            }

            .input-client:focus {
                border-color: var(--accent);
                box-shadow: 0 0 0 3px rgba(124, 58, 237, 0.1);
            }

            .badge-client {
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 0.72rem;
                font-weight: 600;
            }

            .badge-attente {
                background: #fef3c7;
                color: #92400e;
            }

            .badge-preparation {
                background: #dbeafe;
                color: #1e40af;
            }

            .badge-expediee {
                background: #d1fae5;
                color: #065f46;
            }

            .badge-livree {
                background: #dcfce7;
                color: #14532d;
            }

            .badge-annulee {
                background: #fee2e2;
                color: #991b1b;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .fade-in {
                animation: fadeInUp 0.45s ease both;
            }

            .delay-1 {
                animation-delay: 0.07s;
            }

            .delay-2 {
                animation-delay: 0.14s;
            }

            .delay-3 {
                animation-delay: 0.21s;
            }
        </style>

        <script>
            // Dropdown toggle
            document.addEventListener('DOMContentLoaded', () => {
                const btn = document.getElementById('userMenuBtn');
                const dropdown = document.getElementById('userDropdown');
                if (btn && dropdown) {
                    btn.addEventListener('click', (e) => {
                        e.stopPropagation();
                        btn.classList.toggle('open');
                        dropdown.classList.toggle('open');
                    });
                    document.addEventListener('click', () => {
                        btn.classList.remove('open');
                        dropdown.classList.remove('open');
                    });
                }
                // Navbar scroll effect
                const nav = document.getElementById('shopNav');
                window.addEventListener('scroll', () => {
                    nav.style.boxShadow = window.scrollY > 10 ? '0 4px 24px rgba(0,0,0,0.1)' : '0 1px 20px rgba(0,0,0,0.06)';
                });
            });
        </script>