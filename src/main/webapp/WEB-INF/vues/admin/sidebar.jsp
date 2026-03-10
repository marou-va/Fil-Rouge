<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <div class="col-auto px-0 sidebar-col" id="sidebarWrapper">
            <nav id="sidebar" class="d-flex flex-column min-vh-100">
                <!-- Brand -->
                <div class="sidebar-brand px-4 py-4 d-flex align-items-center gap-3">
                    <div class="brand-icon">
                        <i class="fas fa-bolt"></i>
                    </div>
                    <div>
                        <div class="brand-name">MaBoutique</div>
                        <div class="brand-sub">Admin Console</div>
                    </div>
                </div>

                <hr class="sidebar-divider">

                <!-- User info -->
                <div class="sidebar-user px-4 pb-3 d-flex align-items-center gap-3">
                    <div class="user-avatar">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <div>
                        <div class="user-name">${sessionScope.utilisateur.nom}</div>
                        <div class="user-role"><span class="role-dot"></span>Administrateur</div>
                    </div>
                </div>

                <hr class="sidebar-divider">

                <!-- Navigation -->
                <ul class="nav flex-column flex-grow-1 px-3 pt-2 gap-1">
                    <li class="nav-section-label">Navigation</li>

                    <li class="nav-item">
                        <a class="nav-link sidebar-link ${page == 'dashboard' ? 'active' : ''}"
                            href="${pageContext.request.contextPath}/admin/dashboard">
                            <span class="nav-icon"><i class="fas fa-chart-pie"></i></span>
                            <span class="nav-text">Dashboard</span>
                            <c:if test="${page == 'dashboard'}"><span class="active-indicator"></span></c:if>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link sidebar-link ${page == 'produits' ? 'active' : ''}"
                            href="${pageContext.request.contextPath}/admin/produits">
                            <span class="nav-icon"><i class="fas fa-box-open"></i></span>
                            <span class="nav-text">Produits</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link sidebar-link ${page == 'categories' ? 'active' : ''}"
                            href="${pageContext.request.contextPath}/admin/categories">
                            <span class="nav-icon"><i class="fas fa-layer-group"></i></span>
                            <span class="nav-text">Catégories</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link sidebar-link ${page == 'commandes' ? 'active' : ''}"
                            href="${pageContext.request.contextPath}/admin/commandes">
                            <span class="nav-icon"><i class="fas fa-shopping-bag"></i></span>
                            <span class="nav-text">Commandes</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link sidebar-link ${page == 'utilisateurs' ? 'active' : ''}"
                            href="${pageContext.request.contextPath}/admin/utilisateurs">
                            <span class="nav-icon"><i class="fas fa-users"></i></span>
                            <span class="nav-text">Utilisateurs</span>
                        </a>
                    </li>

                    <li class="nav-section-label mt-3">Accès rapide</li>

                    <li class="nav-item">
                        <a class="nav-link sidebar-link" href="${pageContext.request.contextPath}/admin-choice">
                            <span class="nav-icon"><i class="fas fa-store"></i></span>
                            <span class="nav-text">Voir la boutique</span>
                        </a>
                    </li>
                </ul>

                <!-- Logout -->
                <div class="px-3 pb-4">
                    <a class="nav-link sidebar-link sidebar-logout" href="${pageContext.request.contextPath}/logout">
                        <span class="nav-icon"><i class="fas fa-sign-out-alt"></i></span>
                        <span class="nav-text">Déconnexion</span>
                    </a>
                </div>
            </nav>
        </div>

        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

            :root {
                --sidebar-bg: linear-gradient(160deg, #0f0c29, #302b63, #24243e);
                --sidebar-width: 260px;
                --accent: #7c3aed;
                --accent-light: #a78bfa;
                --accent-glow: rgba(124, 58, 237, 0.35);
                --teal: #06b6d4;
                --amber: #f59e0b;
                --text-muted-sidebar: rgba(255, 255, 255, 0.45);
                --text-sidebar: rgba(255, 255, 255, 0.8);
                --card-bg: #ffffff;
                --body-bg: #f1f5f9;
                --border-radius-lg: 16px;
                --border-radius-md: 12px;
                --shadow-card: 0 4px 24px rgba(0, 0, 0, 0.07);
                --shadow-card-hover: 0 8px 32px rgba(0, 0, 0, 0.12);
            }

            * {
                font-family: 'Inter', sans-serif;
            }

            /* ── Sidebar ── */
            .sidebar-col {
                width: var(--sidebar-width);
                min-width: var(--sidebar-width);
            }

            #sidebar {
                background: var(--sidebar-bg);
                width: var(--sidebar-width);
                position: fixed;
                top: 0;
                left: 0;
                height: 100vh;
                overflow-y: auto;
                z-index: 100;
                box-shadow: 4px 0 24px rgba(0, 0, 0, 0.3);
            }

            #sidebar::-webkit-scrollbar {
                width: 4px;
            }

            #sidebar::-webkit-scrollbar-thumb {
                background: var(--accent);
                border-radius: 4px;
            }

            .sidebar-brand {
                border-bottom: none;
            }

            .brand-icon {
                width: 42px;
                height: 42px;
                background: linear-gradient(135deg, var(--accent), var(--teal));
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 18px;
                color: white;
                box-shadow: 0 0 16px var(--accent-glow);
                flex-shrink: 0;
            }

            .brand-name {
                font-size: 1rem;
                font-weight: 800;
                color: #fff;
                line-height: 1;
            }

            .brand-sub {
                font-size: 0.68rem;
                color: var(--text-muted-sidebar);
                font-weight: 400;
                margin-top: 2px;
            }

            .sidebar-divider {
                border-color: rgba(255, 255, 255, 0.08);
                margin: 4px 20px;
            }

            .sidebar-user {}

            .user-avatar {
                width: 36px;
                height: 36px;
                background: rgba(124, 58, 237, 0.25);
                border: 1px solid rgba(124, 58, 237, 0.5);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--accent-light);
                font-size: 14px;
                flex-shrink: 0;
            }

            .user-name {
                font-size: 0.82rem;
                font-weight: 600;
                color: #fff;
                line-height: 1.2;
            }

            .user-role {
                font-size: 0.7rem;
                color: var(--text-muted-sidebar);
                display: flex;
                align-items: center;
                gap: 5px;
                margin-top: 2px;
            }

            .role-dot {
                width: 6px;
                height: 6px;
                background: #22c55e;
                border-radius: 50%;
                display: inline-block;
                box-shadow: 0 0 6px #22c55e;
                animation: pulse-dot 2s infinite;
            }

            @keyframes pulse-dot {

                0%,
                100% {
                    opacity: 1;
                }

                50% {
                    opacity: 0.4;
                }
            }

            .nav-section-label {
                font-size: 0.62rem;
                font-weight: 700;
                letter-spacing: 0.12em;
                text-transform: uppercase;
                color: var(--text-muted-sidebar);
                padding: 6px 12px 4px;
                list-style: none;
            }

            .sidebar-link {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 10px 14px;
                border-radius: 10px;
                color: var(--text-sidebar);
                font-size: 0.88rem;
                font-weight: 500;
                transition: all 0.22s ease;
                position: relative;
                text-decoration: none;
            }

            .sidebar-link:hover {
                background: rgba(124, 58, 237, 0.18);
                color: #fff;
                padding-left: 18px;
            }

            .sidebar-link.active {
                background: linear-gradient(90deg, rgba(124, 58, 237, 0.4), rgba(6, 182, 212, 0.15));
                color: #fff;
                font-weight: 600;
                box-shadow: inset 0 0 0 1px rgba(124, 58, 237, 0.4);
            }

            .nav-icon {
                width: 32px;
                height: 32px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 8px;
                background: rgba(255, 255, 255, 0.06);
                font-size: 13px;
                flex-shrink: 0;
                transition: all 0.22s;
            }

            .sidebar-link.active .nav-icon {
                background: linear-gradient(135deg, var(--accent), var(--teal));
                box-shadow: 0 0 12px var(--accent-glow);
            }

            .sidebar-link:hover .nav-icon {
                background: rgba(124, 58, 237, 0.3);
            }

            .active-indicator {
                width: 6px;
                height: 6px;
                background: var(--accent-light);
                border-radius: 50%;
                margin-left: auto;
                box-shadow: 0 0 8px var(--accent);
            }

            .sidebar-logout {
                background: rgba(239, 68, 68, 0.08) !important;
                color: #f87171 !important;
                border: 1px solid rgba(239, 68, 68, 0.2);
            }

            .sidebar-logout:hover {
                background: rgba(239, 68, 68, 0.2) !important;
                color: #fca5a5 !important;
            }

            /* ── Global admin page styles ── */
            body {
                background: var(--body-bg);
                font-family: 'Inter', sans-serif;
            }

            .admin-main {
                margin-left: var(--sidebar-width);
                min-height: 100vh;
                padding: 0;
            }

            .admin-topbar {
                background: white;
                border-bottom: 1px solid #e2e8f0;
                padding: 16px 32px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                position: sticky;
                top: 0;
                z-index: 50;
                box-shadow: 0 1px 12px rgba(0, 0, 0, 0.05);
            }

            .topbar-title {
                font-size: 1.25rem;
                font-weight: 800;
                color: #1e293b;
            }

            .topbar-subtitle {
                font-size: 0.78rem;
                color: #94a3b8;
                margin-top: 1px;
            }

            .admin-content {
                padding: 32px;
            }

            .stat-card {
                border: none;
                border-radius: var(--border-radius-lg);
                overflow: hidden;
                box-shadow: var(--shadow-card);
                transition: transform 0.3s, box-shadow 0.3s;
                cursor: default;
            }

            .stat-card:hover {
                transform: translateY(-6px);
                box-shadow: var(--shadow-card-hover);
            }

            .stat-card .card-body {
                padding: 24px;
                position: relative;
            }

            .stat-card-icon {
                width: 52px;
                height: 52px;
                border-radius: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 22px;
                margin-bottom: 16px;
            }

            .stat-card-value {
                font-size: 2rem;
                font-weight: 800;
                line-height: 1;
            }

            .stat-card-label {
                font-size: 0.78rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.06em;
                opacity: 0.7;
                margin-top: 4px;
            }

            .stat-card-bg {
                position: absolute;
                right: -10px;
                bottom: -10px;
                font-size: 80px;
                opacity: 0.07;
            }

            .card-violet {
                background: linear-gradient(135deg, #7c3aed, #a855f7);
                color: white;
            }

            .card-teal {
                background: linear-gradient(135deg, #0891b2, #06b6d4);
                color: white;
            }

            .card-amber {
                background: linear-gradient(135deg, #d97706, #f59e0b);
                color: white;
            }

            .card-rose {
                background: linear-gradient(135deg, #e11d48, #f43f5e);
                color: white;
            }

            .content-card {
                background: white;
                border-radius: var(--border-radius-lg);
                box-shadow: var(--shadow-card);
                border: none;
                overflow: hidden;
            }

            .content-card-header {
                padding: 20px 24px;
                border-bottom: 1px solid #f1f5f9;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .content-card-title {
                font-size: 0.95rem;
                font-weight: 700;
                color: #1e293b;
                margin: 0;
            }

            .content-card-body {
                padding: 0;
            }

            .admin-table {
                margin: 0;
            }

            .admin-table thead th {
                background: #f8fafc;
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.08em;
                color: #64748b;
                padding: 14px 20px;
                border-bottom: 1px solid #e2e8f0;
                border-top: none;
                white-space: nowrap;
            }

            .admin-table tbody td {
                padding: 14px 20px;
                vertical-align: middle;
                font-size: 0.875rem;
                color: #334155;
                border-bottom: 1px solid #f1f5f9;
            }

            .admin-table tbody tr:last-child td {
                border-bottom: none;
            }

            .admin-table tbody tr {
                transition: background 0.15s;
            }

            .admin-table tbody tr:hover {
                background: #fafbff;
            }

            .badge-status {
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 0.72rem;
                font-weight: 600;
                letter-spacing: 0.04em;
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

            .btn-action {
                width: 34px;
                height: 34px;
                border-radius: 8px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-size: 13px;
                transition: all 0.2s;
                border: 1px solid transparent;
            }

            .btn-action-edit {
                background: #ede9fe;
                color: #7c3aed;
            }

            .btn-action-edit:hover {
                background: #7c3aed;
                color: white;
            }

            .btn-action-delete {
                background: #fee2e2;
                color: #ef4444;
            }

            .btn-action-delete:hover {
                background: #ef4444;
                color: white;
            }

            .btn-action-view {
                background: #e0f2fe;
                color: #0284c7;
            }

            .btn-action-view:hover {
                background: #0284c7;
                color: white;
            }

            .btn-primary-admin {
                background: linear-gradient(135deg, #7c3aed, #a855f7);
                color: white;
                border: none;
                border-radius: 10px;
                padding: 10px 22px;
                font-size: 0.875rem;
                font-weight: 600;
                transition: all 0.25s;
                box-shadow: 0 4px 14px rgba(124, 58, 237, 0.35);
            }

            .btn-primary-admin:hover {
                background: linear-gradient(135deg, #6d28d9, #9333ea);
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(124, 58, 237, 0.45);
            }

            .btn-secondary-admin {
                background: white;
                color: #64748b;
                border: 1px solid #e2e8f0;
                border-radius: 10px;
                padding: 10px 22px;
                font-size: 0.875rem;
                font-weight: 500;
                transition: all 0.2s;
            }

            .btn-secondary-admin:hover {
                background: #f8fafc;
                color: #334155;
            }

            .form-control-admin,
            .form-select-admin {
                border: 1.5px solid #e2e8f0;
                border-radius: 10px;
                padding: 10px 16px;
                font-size: 0.875rem;
                color: #334155;
                background: #fff;
                transition: all 0.2s;
            }

            .form-control-admin:focus,
            .form-select-admin:focus {
                border-color: #7c3aed;
                box-shadow: 0 0 0 3px rgba(124, 58, 237, 0.12);
                outline: none;
            }

            .form-label-admin {
                font-size: 0.78rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.06em;
                color: #64748b;
                margin-bottom: 8px;
            }

            .alert-flash {
                border-radius: 12px;
                border: none;
                font-size: 0.875rem;
                font-weight: 500;
                padding: 12px 20px;
            }

            .alert-flash-success {
                background: #f0fdf4;
                color: #166534;
                border-left: 4px solid #22c55e;
            }

            .alert-flash-danger {
                background: #fff1f2;
                color: #9f1239;
                border-left: 4px solid #f43f5e;
            }

            .page-header {
                margin-bottom: 28px;
            }

            .page-header h1 {
                font-size: 1.6rem;
                font-weight: 800;
                color: #0f172a;
                margin: 0 0 4px;
            }

            .page-header p {
                font-size: 0.85rem;
                color: #94a3b8;
                margin: 0;
            }

            .breadcrumb-admin {
                font-size: 0.8rem;
                color: #94a3b8;
            }

            .breadcrumb-admin a {
                color: #7c3aed;
                text-decoration: none;
                font-weight: 500;
            }

            /* Animations */
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

            .animate-in {
                animation: fadeInUp 0.4s ease both;
            }

            .delay-1 {
                animation-delay: 0.05s;
            }

            .delay-2 {
                animation-delay: 0.10s;
            }

            .delay-3 {
                animation-delay: 0.15s;
            }

            .delay-4 {
                animation-delay: 0.20s;
            }
        </style>