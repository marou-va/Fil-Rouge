<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Inscription — MaBoutique</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
            <style>
                .register-wrap {
                    background: linear-gradient(160deg, var(--primary-dark) 0%, var(--primary-mid) 40%, var(--info) 100%);
                    min-height: 100vh;
                    display: flex;
                    align-items: flex-start;
                    justify-content: center;
                    padding: 3rem 1rem;
                }

                .register-card {
                    background: #fff;
                    border-radius: var(--radius-lg);
                    box-shadow: var(--shadow-lg);
                    padding: 2.5rem 2rem;
                    width: 100%;
                    max-width: 520px;
                }

                .pwd-rule {
                    font-size: 0.78rem;
                    color: var(--text-muted);
                }
            </style>
        </head>

        <body>
            <div class="register-wrap">
                <div class="register-card">
                    <div class="text-center mb-4">
                        <a href="catalogue" class="text-decoration-none">
                            <span
                                style="font-family:'Playfair Display',serif;font-size:1.5rem;color:var(--primary-dark);font-weight:700;">
                                <i class="fas fa-leaf me-2" style="color:var(--primary);"></i>MaBoutique
                            </span>
                        </a>
                        <h2 class="mt-3 fw-bold" style="font-size:1.4rem;">Créer un compte</h2>
                        <p class="text-muted small mb-0">Rejoignez notre communauté de clients.</p>
                    </div>

                    <c:if test="${not empty erreur}">
                        <div class="alert alert-accent small py-2 mb-3" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            <c:out value="${erreur}" />
                        </div>
                    </c:if>
                    <c:if test="${not empty succes}">
                        <div class="alert alert-brand small py-2 mb-3" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            <c:out value="${succes}" />
                        </div>
                    </c:if>

                    <form action="register" method="post">
                        <input type="hidden" name="action" value="inscrire" />
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label fw-bold small text-uppercase"
                                    style="color:var(--text-muted);">Nom complet</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                    <input type="text" name="nom" class="form-control" required
                                        placeholder="Jean Dupont" value="${param.nom}" />
                                </div>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-bold small text-uppercase"
                                    style="color:var(--text-muted);">Email</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                    <input type="email" name="email" class="form-control" required
                                        placeholder="email@exemple.com" value="${param.email}" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold small text-uppercase"
                                    style="color:var(--text-muted);">Téléphone</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                    <input type="tel" name="telephone" class="form-control" placeholder="06 12 34 56 78"
                                        value="${param.telephone}" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold small text-uppercase"
                                    style="color:var(--text-muted);">Adresse</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                    <input type="text" name="adresse" class="form-control"
                                        placeholder="12 rue des Fleurs" value="${param.adresse}" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold small text-uppercase"
                                    style="color:var(--text-muted);">Mot de passe</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    <input type="password" name="motDePasse" class="form-control" required
                                        oncopy="return false" onpaste="return false" oncut="return false"
                                        autocomplete="off" placeholder="••••••••" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold small text-uppercase"
                                    style="color:var(--text-muted);">Confirmer</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    <input type="password" name="confirmerMDP" class="form-control" required
                                        oncopy="return false" onpaste="return false" oncut="return false"
                                        autocomplete="off" placeholder="••••••••" />
                                </div>
                            </div>

                            <div class="col-12">
                                <div class="p-3 rounded"
                                    style="background:var(--bg);border:1px solid var(--border-color);">
                                    <p class="small fw-bold mb-1" style="color:var(--primary-dark);"><i
                                            class="fas fa-shield-alt me-2"></i>Règles du mot de passe :</p>
                                    <ul class="mb-0 ps-3 pwd-rule">
                                        <li>Au moins 8 caractères</li>
                                        <li>Au moins une lettre (a-z / A-Z)</li>
                                        <li>Au moins un chiffre (0-9)</li>
                                        <li>Un symbole recommandé (! @ # $…)</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="col-12 mt-2">
                                <button type="submit" class="btn btn-brand w-100 py-2 fw-bold">
                                    <i class="fas fa-user-plus me-2"></i>Créer mon compte
                                </button>
                                <p class="text-center small mt-3 mb-0">
                                    Déjà inscrit ?
                                    <a href="login" class="fw-bold text-decoration-none"
                                        style="color:var(--primary);">Se connecter</a>
                                </p>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>