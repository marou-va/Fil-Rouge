<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Connexion - MaBoutique</title>
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
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    padding: 24px;
                    position: relative;
                    overflow: hidden;
                }

                .blob {
                    position: absolute;
                    border-radius: 50%;
                    filter: blur(80px);
                    opacity: 0.12;
                }

                .b1 {
                    width: 400px;
                    height: 400px;
                    background: #7c3aed;
                    top: -80px;
                    left: -60px;
                }

                .b2 {
                    width: 280px;
                    height: 280px;
                    background: #06b6d4;
                    bottom: -60px;
                    right: -40px;
                }

                .auth-card {
                    background: white;
                    border-radius: 24px;
                    padding: 48px;
                    width: 100%;
                    max-width: 440px;
                    position: relative;
                    z-index: 10;
                    box-shadow: 0 24px 80px rgba(0, 0, 0, 0.35);
                    animation: slideUp 0.4s ease;
                }

                @keyframes slideUp {
                    from {
                        opacity: 0;
                        transform: translateY(24px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .auth-logo {
                    text-align: center;
                    margin-bottom: 32px;
                }

                .auth-brand-icon {
                    width: 52px;
                    height: 52px;
                    background: linear-gradient(135deg, #7c3aed, #06b6d4);
                    border-radius: 14px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: white;
                    font-size: 22px;
                    margin: 0 auto 12px;
                    box-shadow: 0 8px 24px rgba(124, 58, 237, 0.35);
                }

                .auth-title {
                    font-size: 1.6rem;
                    font-weight: 800;
                    color: #0f172a;
                    margin-bottom: 4px;
                }

                .auth-sub {
                    font-size: 0.875rem;
                    color: #94a3b8;
                }

                .alert-auth {
                    border-radius: 10px;
                    border: none;
                    font-size: 0.875rem;
                    padding: 12px 16px;
                    margin-bottom: 20px;
                }

                .alert-auth-error {
                    background: #fff1f2;
                    color: #9f1239;
                    border-left: 4px solid #f43f5e;
                }

                .alert-auth-warning {
                    background: #fffbeb;
                    color: #92400e;
                    border-left: 4px solid #f59e0b;
                }

                .divider {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    margin: 24px 0;
                }

                .divider-line {
                    flex: 1;
                    height: 1px;
                    background: #e2e8f0;
                }

                .divider-text {
                    font-size: 0.78rem;
                    color: #94a3b8;
                    font-weight: 500;
                }

                .auth-footer {
                    text-align: center;
                    margin-top: 24px;
                    font-size: 0.875rem;
                    color: #64748b;
                }

                .auth-footer a {
                    color: #7c3aed;
                    font-weight: 700;
                    text-decoration: none;
                }

                .auth-footer a:hover {
                    text-decoration: underline;
                }

                .countdown-display {
                    text-align: center;
                    font-size: 2rem;
                    font-weight: 800;
                    color: #7c3aed;
                }
            </style>
        </head>

        <body>
            <div class="blob b1"></div>
            <div class="blob b2"></div>

            <div class="auth-card">
                <div class="auth-logo">
                    <div class="auth-brand-icon"><i class="fas fa-bolt"></i></div>
                    <div class="auth-title">Bon retour !</div>
                    <div class="auth-sub">Connectez-vous à votre compte MaBoutique</div>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert-auth alert-auth-error">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                    </div>
                </c:if>
                <c:if test="${bloque}">
                    <div class="alert-auth alert-auth-warning" id="countdown-box">
                        <i class="fas fa-clock me-2"></i>⏳ <span id="countdown">30</span> seconde(s) avant de
                        réessayer...
                    </div>
                    <script>
                        let s = 30;
                        const el = document.getElementById('countdown');
                        const btn = document.getElementById('btnLogin');
                        btn.disabled = true;
                        const t = setInterval(() => {
                            el.textContent = --s;
                            if (s <= 0) {
                                clearInterval(t);
                                document.getElementById('countdown-box').innerHTML = '<i class="fas fa-check-circle me-2"></i>✅ Vous pouvez réessayer.';
                                document.getElementById('countdown-box').className = 'alert-auth';
                                document.getElementById('countdown-box').style.background = '#f0fdf4';
                                document.getElementById('countdown-box').style.color = '#166534';
                                document.getElementById('countdown-box').style.borderLeft = '4px solid #22c55e';
                                btn.disabled = false;
                            }
                        }, 1000);
                    </script>
                </c:if>

                <form action="login" method="POST">
                    <div class="form-group-client">
                        <label class="label-client">Adresse email</label>
                        <div style="position:relative;">
                            <i class="fas fa-envelope"
                                style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:#94a3b8;font-size:13px;"></i>
                            <input type="email" name="email" class="input-client" style="padding-left:38px;" required
                                placeholder="vous@exemple.com">
                        </div>
                    </div>
                    <div class="form-group-client">
                        <label class="label-client">Mot de passe</label>
                        <div style="position:relative;">
                            <i class="fas fa-lock"
                                style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:#94a3b8;font-size:13px;"></i>
                            <input type="password" name="password" class="input-client" style="padding-left:38px;"
                                required placeholder="••••••••">
                        </div>
                    </div>
                    <button type="submit" id="btnLogin" class="btn-accent w-100 justify-content-center py-3 mt-2"
                        style="font-size:0.95rem;">
                        <i class="fas fa-sign-in-alt"></i> Se connecter
                    </button>
                </form>

                <div class="auth-footer">
                    Pas encore de compte ? <a href="register">S'inscrire gratuitement</a>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>