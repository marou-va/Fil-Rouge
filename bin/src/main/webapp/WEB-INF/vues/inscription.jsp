<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Inscription</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
        --orange:        #FF6B00;
        --orange-light:  #FF8C38;
        --orange-dark:   #CC5500;
        --orange-glow:   rgba(255, 107, 0, 0.18);
        --black:         #0D0D0D;
        --dark:          #161616;
        --dark2:         #1F1F1F;
        --dark3:         #2A2A2A;
        --border:        #333333;
        --text:          #F0F0F0;
        --muted:         #888888;
        --error:         #FF4D4D;
        --success:       #2ECC71;
        --gold:          #FFD700;
    }

body {
    background: white ;
    color: var(--text);
    font-family: 'Outfit', sans-serif;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

    /* Fond décoratif */
    body::before {
        content: '';
        position: fixed;
        top: -150px; right: -150px;
        
        background: radial-gradient(circle, rgba(255,107,0,0.12) 0%, transparent 70%);
        pointer-events: none;
    }
    body::after {
        content: '';
        position: fixed;
        bottom: -100px; left: -100px;
        width: 400px; height: 400px;
        background: radial-gradient(circle, rgba(255,107,0,0.07) 0%, transparent 70%);
        pointer-events: none;
    }

    /* ── Carte principale ── */
    .card {
    
        background: var(--dark);
        border: 1px solid var(--border);
        border-top: 3px solid var(--orange);
        border-radius: 16px;
        padding: 2.5rem 2.8rem;
        width: 100%;
        max-width: 500px;
        position: relative;
        box-shadow: 0 25px 60px rgba(0,0,0,0.5), 0 0 40px rgba(255,107,0,0.05);
    }

    /* ── Logo / Icône ── */
    .logo-wrap {
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 1.5rem;
    }
    .logo-icon {
        width: 190px; height: 60px;
        background: linear-gradient(135deg, var(--orange), var(--orange-dark));
        border-radius: 16px;
        display: flex; align-items: center; justify-content: center;
        font-size: 1.6rem;
        box-shadow: 0 8px 24px rgba(255,107,0,0.35);
    }

    /* ── Titres ── */
    h1 {
        font-size: 1.75rem;
        font-weight: 700;
        text-align: center;
        letter-spacing: -0.02em;
        color: var(--text);
    }
    h1 span { color: var(--orange); }

    .subtitle {
        text-align: center;
        color: var(--muted);
        font-size: 0.875rem;
        margin-top: 0.3rem;
        margin-bottom: 1.8rem;
    }

    /* ── Divider décoratif ── */
    .divider-line {
        display: flex; align-items: center; gap: 0.75rem;
        margin-bottom: 1.8rem;
    }
    .divider-line::before, .divider-line::after {
        content: ''; flex: 1; height: 1px; background: var(--border);
    }
    .divider-line span {
        font-size: 0.7rem; color: var(--muted);
        letter-spacing: 0.1em; text-transform: uppercase;
    }

    /* ── Alertes ── */
    .alert {
        border-radius: 10px;
        padding: 0.8rem 1rem;
        font-size: 0.85rem;
        margin-bottom: 1.2rem;
        display: flex; align-items: flex-start; gap: 0.5rem;
    }
    .alert-error {
        background: rgba(255,77,77,0.1);
        border: 1px solid rgba(255,77,77,0.3);
        color: var(--error);
    }
    .alert-success {
        background: rgba(46,204,113,0.1);
        border: 1px solid rgba(46,204,113,0.3);
        color: var(--success);
    }

    /* ── Groupes de champs ── */
    .form-row {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 1rem;
    }
    .form-group { margin-bottom: 1.1rem; }

    label {
        display: block;
        font-size: 0.78rem;
        font-weight: 600;
        letter-spacing: 0.07em;
        text-transform: uppercase;
        color: var(--muted);
        margin-bottom: 0.45rem;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"] {
        width: 100%;
        background: var(--dark2);
        border: 1.5px solid var(--border);
        border-radius: 10px;
        padding: 0.75rem 1rem;
        color: var(--text);
        font-family: 'Outfit', sans-serif;
        font-size: 0.9rem;
        outline: none;
        transition: border-color 0.2s, box-shadow 0.2s, background 0.2s;
    }
    input:focus {
        border-color: var(--orange);
        background: var(--dark3);
        box-shadow: 0 0 0 3px var(--orange-glow);
    }
    input::placeholder { color: #555; }

    /* ── Bloc règles mot de passe ── */
    .pw-rules {
        background: var(--dark2);
        border: 1px solid var(--border);
        border-left: 3px solid var(--orange);
        border-radius: 10px;
        padding: 0.9rem 1rem;
        margin-top: 0.5rem;
        margin-bottom: 1.1rem;
    }
    .pw-rules-title {
        font-size: 0.72rem;
        font-weight: 600;
        letter-spacing: 0.08em;
        text-transform: uppercase;
        color: var(--orange-light);
        margin-bottom: 0.6rem;
    }
    .pw-rule {
        display: flex; align-items: center; gap: 0.6rem;
        font-size: 0.82rem;
        color: var(--muted);
        padding: 0.18rem 0;
    }
    .pw-rule::before {
        content: '○';
        color: var(--border);
        font-size: 0.65rem;
        flex-shrink: 0;
    }
    .pw-rule strong { color: var(--text); }
    .pw-rule em { color: var(--gold); font-style: normal; font-size: 0.75rem; }

    /* ── Bouton principal ── */
    .btn {
        width: 100%;
        padding: 0.9rem;
        border: none;
        border-radius: 10px;
        background: linear-gradient(135deg, var(--orange), var(--orange-dark));
        color: #fff;
        font-family: 'Outfit', sans-serif;
        font-weight: 700;
        font-size: 1rem;
        letter-spacing: 0.04em;
        cursor: pointer;
        margin-top: 0.3rem;
        position: relative;
        overflow: hidden;
        transition: opacity 0.2s, transform 0.15s, box-shadow 0.2s;
        box-shadow: 0 6px 20px rgba(255,107,0,0.35);
    }
    .btn::after {
        content: '';
        position: absolute;
        inset: 0;
        background: linear-gradient(135deg, rgba(255,255,255,0.08), transparent);
        pointer-events: none;
    }
    .btn:hover {
        opacity: 0.92;
        transform: translateY(-1px);
        box-shadow: 0 10px 28px rgba(255,107,0,0.45);
    }
    .btn:active { transform: translateY(0); }

    /* ── Lien connexion ── */
    .login-link {
        text-align: center;
        font-size: 0.85rem;
        color: var(--muted);
        margin-top: 1.4rem;
    }
    .login-link a {
        color: var(--orange-light);
        text-decoration: none;
        font-weight: 600;
        transition: color 0.2s;
    }
    .login-link a:hover { color: var(--orange); text-decoration: underline; }

    /* ── Badge sécurité ── */
    .security-badge {
        display: flex; align-items: center; justify-content: center;
        gap: 0.4rem;
        background: rgba(255,107,0,0.07);
        border: 1px solid rgba(255,107,0,0.2);
        border-radius: 8px;
        padding: 0.45rem 0.75rem;
        font-size: 0.73rem;
        color: var(--orange-light);
        margin-bottom: 1.5rem;
    }
    .center-container {
    flex: 1; /* prend tout l’espace disponible */
    display: flex;
    align-items: center;      /* centre verticalement */
    justify-content: center;  /* centre horizontalement */
    padding: 2rem;
}
</style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold text-brand" href="catalogue">
                <i class="fas fa-shopping-bag me-2"></i>MaBoutique
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-user me-1"></i> Se connecter</a>
                    </li>
                    
                </ul>
            </div>
        </div>
    </nav>
    <div class="center-container">
<div class="card">

    <!-- Logo -->
    <div class="logo-wrap">
        <div class="logo-icon"> MaBoutique</div>
    </div>

    <!-- Titre -->
    <h1>Créer votre <span>compte</span></h1>
    <p class="subtitle">Rejoignez la plateforme et commencez à acheter</p>

    <!-- Badge sécurité -->
    <div class="security-badge">
        🔒 Mot de passe chiffré (BCrypt) — Connexion sécurisée
    </div>

    <!-- Messages Servlet -->
    <c:if test="${not empty erreur}">
        <div class="alert alert-error">⚠ <c:out value="${erreur}"/></div>
    </c:if>
    <c:if test="${not empty succes}">
        <div class="alert alert-success">✓ <c:out value="${succes}"/></div>
    </c:if>

    
    <form action="register" method="post">
        <input type="hidden" name="action" value="inscrire"/>

        <div class="form-group">
            <label>Nom complet</label>
            <input type="text" name="nom"
                   placeholder="Jean Dupont"
                   required
                   value="${param.nom}"/>
        </div>

        

        <div class="form-group">
            <label>Adresse e-mail</label>
            <input type="email" name="email"
                   placeholder="email@exemple.com"
                   required
                   value="${param.email}"/>
        </div>

       
        <div class="form-group">
            <label>Mot de passe</label>
            <input type="password"
                   name="motDePasse"
                   oncopy="return false"
                   onpaste="return false"
                   oncut="return false"
                   autocomplete="off"
                   placeholder="Créez un mot de passe fort"
                   required/>
        </div>

        
        <div class="form-group">
            <label>Confirmer le mot de passe</label>
            <input type="password"
                   name="confirmerMDP"
                   oncopy="return false"
                   onpaste="return false"
                   oncut="return false"
                   autocomplete="off"
                   placeholder="Répétez le mot de passe"
                   required/>
        </div>

        <div class="pw-rules">
            <p class="pw-rules-title">⚡ Le mot de passe doit contenir :</p>
            <div class="pw-rule">
                <span>Au moins <strong>8 caractères</strong></span>
            </div>
            <div class="pw-rule">
                <span>Au moins <strong>une lettre</strong> (a-z ou A-Z)</span>
            </div>
            <div class="pw-rule">
                <span>Au moins <strong>un chiffre</strong> (0-9)</span>
            </div>
            <div class="pw-rule">
                <span>Un <strong>symbole</strong> ( ! @ # $ … ) <em>★ recommandé</em></span>
            </div>
        </div>

        <button class="btn" type="submit">
            Créer mon compte →
        </button>

    </form>

    <p class="login-link">
        Déjà inscrit ?
        <a href="login">
            Se connecter
        </a>
    </p>

</div>
 </div>
 <footer class="bg-dark text-white py-4 mt-auto">
        <div class="container text-center">
            <p class="mb-0">&copy; 2026 MaBoutique - Projet Fil Rouge AQL. Tous droits réservés.</p>
        </div>
    </footer>

</body>
</html>
