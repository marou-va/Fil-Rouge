<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Inscription - MaBoutique</title>
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
                    padding: 40px 24px;
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
                    right: -60px;
                }

                .b2 {
                    width: 280px;
                    height: 280px;
                    background: #06b6d4;
                    bottom: -60px;
                    left: -40px;
                }

                .auth-card {
                    background: white;
                    border-radius: 24px;
                    padding: 44px;
                    width: 100%;
                    max-width: 520px;
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

                .alert-auth-success {
                    background: #f0fdf4;
                    color: #166534;
                    border-left: 4px solid #22c55e;
                }

                .password-rules {
                    background: #f8fafc;
                    border: 1.5px solid #e2e8f0;
                    border-radius: 12px;
                    padding: 14px 16px;
                    font-size: 0.8rem;
                    color: #64748b;
                    margin-bottom: 20px;
                }

                .password-rules li {
                    margin-bottom: 4px;
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
            </style>
        </head>

        <body>
            <div class="blob b1"></div>
            <div class="blob b2"></div>

            <div class="auth-card">
                <div class="auth-logo">
                    <div class="auth-brand-icon"><i class="fas fa-bolt"></i></div>
                    <div class="auth-title">Créer un compte</div>
                    <div class="auth-sub">Rejoignez MaBoutique et commencez à commander</div>
                </div>

                <c:if test="${not empty erreur}">
                    <div class="alert-auth alert-auth-error"><i class="fas fa-exclamation-circle me-2"></i>
                        <c:out value="${erreur}" />
                    </div>
                </c:if>
                <c:if test="${not empty succes}">
                    <div class="alert-auth alert-auth-success"><i class="fas fa-check-circle me-2"></i>
                        <c:out value="${succes}" />
                    </div>
                </c:if>

                <form action="register" method="post">
                    <input type="hidden" name="action" value="inscrire" />
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="label-client">Nom complet *</label>
                            <div style="position:relative;">
                                <i class="fas fa-user"
                                    style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:#94a3b8;font-size:13px;"></i>
                                <input type="text" name="nom" class="input-client" style="padding-left:38px;width:100%;"
                                    required placeholder="Jean Dupont" value="${param.nom}">
                            </div>
                        </div>
                        <div class="col-12">
                            <label class="label-client">Email *</label>
                            <div style="position:relative;">
                                <i class="fas fa-envelope"
                                    style="position:absolute;left:14px;top:50%;transform:translateY(-50%);color:#94a3b8;font-size:13px;"></i>
                                <input type="email" name="email" class="input-client"
                                    style="padding-left:38px;width:100%;" required placeholder="email@exemple.com"
                                    value="${param.email}">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="label-client">Téléphone</label>
                            <input type="tel" name="telephone" class="input-client" style="width:100%;"
                                placeholder="06 12 34 56 78" value="${param.telephone}">
                        </div>
                        <div class="col-md-6">
                            <label class="label-client">Adresse</label>
                            <input type="text" name="adresse" class="input-client" style="width:100%;"
                                placeholder="12 rue des Fleurs" value="${param.adresse}">
                        </div>
                        <div class="col-md-6">
                            <label class="label-client">Mot de passe *</label>
                            <input type="password" name="motDePasse" class="input-client" style="width:100%;" required
                                placeholder="••••••••" autocomplete="off">
                        </div>
                        <div class="col-md-6">
                            <label class="label-client">Confirmer *</label>
                            <input type="password" name="confirmerMDP" class="input-client" style="width:100%;" required
                                placeholder="••••••••" autocomplete="off">
                        </div>
                    </div>

                    <div class="password-rules mt-3">
                        <div style="font-weight:700;color:#475569;margin-bottom:6px;"><i class="fas fa-lock me-1"
                                style="color:#7c3aed;"></i>Le mot de passe doit contenir :</div>
                        <ul class="ps-3 mb-0">
                            <li>Au moins <strong>8 caractères</strong></li>
                            <li>Au moins une <strong>lettre</strong> et un <strong>chiffre</strong></li>
                            <li>Un <strong>symbole</strong> ( ! @ # $ ) — recommandé</li>
                        </ul>
                    </div>

                    <button type="submit" class="btn-accent w-100 justify-content-center py-3"
                        style="font-size:0.95rem;">
                        <i class="fas fa-user-plus"></i> Créer mon compte
                    </button>
                </form>

                <div class="auth-footer">
                    Déjà inscrit ? <a href="login">Se connecter</a>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>