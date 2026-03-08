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
            <style>
                body {
                    background-color: #f4f5f7;
                    display: flex;
                    flex-direction: column;
                    min-height: 100vh;
                }

                .text-brand {
                    color: #f68b1e !important;
                }

                .btn-brand {
                    background-color: #f68b1e;
                    color: white;
                    border: none;
                    font-weight: bold;
                }

                .btn-brand:hover {
                    background-color: #e57a10;
                    color: white;
                }
            </style>
        </head>

        <body>
            <jsp:include page="includes/navbar.jsp" />

            <div class="container flex-grow-1 py-5">
                <div class="row justify-content-center">
                    <div class="col-md-6 col-lg-5">
                        <div class="card border-0 shadow-lg">
                            <div class="card-body p-5">
                                <h2 class="text-center fw-bold mb-4">Créer un compte</h2>

                                <c:if test="${not empty erreur}">
                                    <div class="alert alert-danger small">
                                        <i class="fa fa-exclamation-triangle me-1"></i>
                                        <c:out value="${erreur}" />
                                    </div>
                                </c:if>
                                <c:if test="${not empty succes}">
                                    <div class="alert alert-success small">
                                        <i class="fa fa-check-circle me-1"></i>
                                        <c:out value="${succes}" />
                                    </div>
                                </c:if>

                                <form action="register" method="post">
                                    <input type="hidden" name="action" value="inscrire" />

                                    <div class="mb-3">
                                        <label class="form-label">Nom complet</label>
                                        <input type="text" name="nom" class="form-control" required
                                            placeholder="Jean Dupont" value="${param.nom}" />
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Adresse e-mail</label>
                                        <input type="email" name="email" class="form-control" required
                                            placeholder="email@exemple.com" value="${param.email}" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Téléphone</label>
                                        <input type="tel" name="telephone" class="form-control"
                                            placeholder="06 12 34 56 78" value="${param.telephone}" />
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Adresse</label>
                                        <input type="text" name="adresse" class="form-control"
                                            placeholder="12 rue des Fleurs, Paris" value="${param.adresse}" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Mot de passe</label>
                                        <input type="password" name="motDePasse" class="form-control" required
                                            oncopy="return false" onpaste="return false" oncut="return false"
                                            autocomplete="off" placeholder="Créez un mot de passe fort" />
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Confirmer le mot de passe</label>
                                        <input type="password" name="confirmerMDP" class="form-control" required
                                            oncopy="return false" onpaste="return false" oncut="return false"
                                            autocomplete="off" placeholder="Répétez le mot de passe" />
                                    </div>

                                    <div class="alert alert-warning small mb-4 py-2">
                                        <div class="fw-bold mb-1"><i class="fa fa-lock me-1"></i> Le mot de passe doit
                                            contenir :</div>
                                        <ul class="mb-0 ps-3">
                                            <li>Au moins <strong>8 caractères</strong></li>
                                            <li>Au moins <strong>une lettre</strong> (a-z ou A-Z)</li>
                                            <li>Au moins <strong>un chiffre</strong> (0-9)</li>
                                            <li>Un <strong>symbole</strong> ( ! @ # $ … ) <span
                                                    class="text-warning fw-bold">★ recommandé</span></li>
                                        </ul>
                                    </div>

                                    <button type="submit" class="btn btn-brand w-100 py-2 mb-3">
                                        Créer mon compte
                                    </button>

                                    <div class="text-center small">
                                        Déjà inscrit ? <a href="login"
                                            class="text-brand text-decoration-none fw-bold">Se connecter</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="includes/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>