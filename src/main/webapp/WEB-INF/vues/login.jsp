<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Connexion — MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
            <style>
                .login-hero {
                    min-height: 100vh;
                    background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary-mid) 50%, #B4C2BE 100%);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 2rem;
                }

                .login-card {
                    background: #fff;
                    border-radius: var(--radius-lg);
                    box-shadow: var(--shadow-lg);
                    max-width: 420px;
                    width: 100%;
                    padding: 2.5rem;
                }

                .login-logo {
                    font-family: 'Playfair Display', serif;
                    color: var(--primary-dark);
                    font-size: 1.6rem;
                    font-weight: 700;
                }

                .divider-line {
                    border-top: 1px solid var(--border-color);
                    margin: 1.5rem 0;
                }
            </style>
        </head>

        <body style="background:var(--bg);min-height:100vh;">
            <div class="login-hero">
                <div class="login-card">
                    <div class="text-center mb-4">
                        <div class="login-logo"><i class="fas fa-leaf me-2" style="color:var(--primary);"></i>MaBoutique
                        </div>
                        <p class="text-muted small mt-1 mb-0">Bienvenue ! Connectez-vous à votre compte.</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-accent small py-2 mb-3" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>${error}
                        </div>
                    </c:if>
                    <c:if test="${bloque}">
                        <div class="alert alert-brand small text-center mb-3" id="countdown-box">
                            ⏳ <span id="countdown">30</span> seconde(s) avant de réessayer…
                        </div>
                        <script>
                            let s = 30;
                            const el = document.getElementById('countdown');
                            const btn = document.getElementById('btnLogin');
                            btn.disabled = true;
                            const timer = setInterval(() => {
                                s--;
                                el.textContent = s;
                                if (s <= 0) {
                                    clearInterval(timer);
                                    document.getElementById('countdown-box').innerHTML = '<i class="fas fa-check-circle me-1"></i>Vous pouvez réessayer.';
                                    document.getElementById('countdown-box').className = 'alert-brand alert small text-center mb-3';
                                    btn.disabled = false;
                                }
                            }, 1000);
                        </script>
                    </c:if>

                    <form action="login" method="POST">
                        <div class="mb-3">
                            <label class="form-label fw-bold small text-uppercase"
                                style="color:var(--text-muted);">Email</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                <input type="email" name="email" class="form-control" required
                                    placeholder="votre@email.com">
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-bold small text-uppercase" style="color:var(--text-muted);">Mot
                                de passe</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input type="password" name="password" class="form-control" required
                                    placeholder="••••••••">
                            </div>
                        </div>
                        <button type="submit" id="btnLogin" class="btn btn-brand w-100 py-2 fw-bold">
                            <i class="fas fa-sign-in-alt me-2"></i>Se connecter
                        </button>
                    </form>

                    <div class="divider-line"></div>
                    <p class="text-center small mb-0">
                        Pas encore de compte ?
                        <a href="register" class="fw-bold text-decoration-none"
                            style="color:var(--primary);">S'inscrire</a>
                    </p>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>