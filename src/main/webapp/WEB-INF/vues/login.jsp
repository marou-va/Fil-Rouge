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
            <style>
                body {
                    background-color: #f4f5f7;
                    display: flex;
                    flex-direction: column;
                    min-height: 100vh;
                }

                .login-container {
                    max-width: 400px;
                    margin: 100px auto;
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

            <div class="container flex-grow-1">
                <div class="login-container">
                    <div class="card border-0 shadow-lg">
                        <div class="card-body p-5">
                            <h2 class="text-center fw-bold mb-4">Connexion</h2>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger small">${error}</div>
                            </c:if>

                            <form action="login" method="POST">
                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" name="email" class="form-control" required
                                        placeholder="votre@email.com">
                                </div>
                                <div class="mb-4">
                                    <label class="form-label">Mot de passe</label>
                                    <input type="password" name="password" class="form-control" required
                                        placeholder="••••••••">
                                </div>
                                <button type="submit" class="btn btn-brand w-100 py-2 mb-3">Se connecter</button>
                                <div class="text-center small">
                                    Pas encore de compte ? <a href="register"
                                        class="text-brand text-decoration-none fw-bold">S'inscrire</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="includes/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>