<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Mon Panier - MaBoutique</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #f4f5f7; font-family: 'Segoe UI', sans-serif; }
        .text-brand { color: #f68b1e !important; }
        .bg-brand { background-color: #f68b1e !important; }
        .btn-brand { background-color: #f68b1e; color: white; border: none; font-weight: bold; }
        .btn-brand:hover { background-color: #e57a10; color: white; }
        .cart-img { width: 70px; height: 70px; object-fit: contain; border: 1px solid #ddd; border-radius: 6px; background-color: white; }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />
	<%-- ALERTE STOCK INSUFFISANT (vient du ValiderCommandeServlet) --%>
	<c:if test="${not empty sessionScope.panierErreur}">
	    <div class="alert alert-danger alert-dismissible fade show shadow-sm mx-0 mb-4" role="alert">
	        <div class="d-flex align-items-start gap-3">
	            <i class="fas fa-exclamation-circle fa-lg mt-1 flex-shrink-0"></i>
	            <div>
	                <div class="fw-bold mb-1">Impossible de valider votre commande</div>
	                <div>${sessionScope.panierErreur}</div>
	                <div class="mt-2 small text-danger-emphasis">
	                    Veuillez ajuster les quantités avant de continuer.
	                </div>
	            </div>
	        </div>
	        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	    </div>
	    <%-- ✅ Supprimer l'attribut pour ne pas le réafficher au prochain chargement --%>
	    <% session.removeAttribute("panierErreur"); %>
	</c:if>
    <div class="container py-5">
        <h2 class="mb-4 fw-bold"><i class="fas fa-shopping-cart text-brand me-2"></i>Votre Panier</h2>
        
        <c:if test="${not empty sessionScope.panierErreur}">
            <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i> ${sessionScope.panierErreur}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("panierErreur"); %>
        </c:if>

        <c:choose>
            <c:when test="${empty panier or empty panier.items}">
                <div class="text-center py-5 bg-white shadow-sm rounded">
                    <i class="fas fa-shopping-basket fa-4x text-muted mb-3"></i>
                    <h4 class="text-muted">Votre panier est vide.</h4>
                    <a href="catalogue" class="btn btn-brand mt-3 px-4 py-2">Continuer mes achats</a>
                </div>
            </c:when>
            
            <c:otherwise>
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card border-0 shadow-sm mb-4">
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="bg-light">
                                            <tr>
                                                <th class="ps-4 py-3">Produit</th>
                                                <th>Prix unitaire</th>
                                                <th>Quantité</th>
                                                <th>Total</th>
                                                <th class="text-end pe-4">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${panier.items}">
                                                <tr>
                                                    <td class="ps-4 py-3">
                                                        <div class="d-flex align-items-center">
                                                            <c:set var="imgSrc" value="${not empty item.produit.imageUrl ? item.produit.imageUrl : 'https://placehold.co/70x70/eeeeee/999999?text=IMG'}" />
                                                            <img src="${imgSrc}" class="cart-img me-3" alt="${item.produit.nom}">
                                                            
                                                            <div>
                                                                <div class="fw-bold text-dark mb-1">
                                                                    <a href="produit-detail?id=${item.produit.id}" class="text-decoration-none text-dark">
                                                                        ${item.produit.nom}
                                                                    </a>
                                                                </div>
                                                                
                                                                <c:choose>
                                                                    <c:when test="${item.produit.stock == 0}">
                                                                        <span class="badge bg-danger"><i class="fas fa-times-circle me-1"></i>Épuisé</span>
                                                                        <small class="text-danger d-block mt-1">Cet article n'est plus disponible.</small>
                                                                    </c:when>
                                                                    <c:when test="${item.produit.stock <= 5}">
                                                                        <small class="text-warning fw-bold"><i class="fas fa-fire me-1"></i>Plus que ${item.produit.stock} en stock !</small>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <small class="text-success"><i class="fas fa-check-circle me-1"></i>En stock (${item.produit.stock} disponibles)</small>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    
                                                    <td class="fw-semibold">${item.produit.prix} MAD</td>
                                                    
                                                    <td>
                                                        <div class="input-group input-group-sm" style="width: 110px;">
                                                            
                                                            <a href="update-panier?id=${item.produit.id}&action=minus" 
                                                               class="btn btn-outline-secondary">
                                                                <i class="fas fa-minus"></i>
                                                            </a>
                                                            
                                                            <input type="text" class="form-control text-center bg-white fw-bold" 
                                                                   value="${item.quantite}" readonly>
                                                            
                                                            <c:choose>
                                                                <c:when test="${item.quantite < item.produit.stock}">
                                                                    <a href="update-panier?id=${item.produit.id}&action=plus" 
                                                                       class="btn btn-outline-secondary">
                                                                        <i class="fas fa-plus"></i>
                                                                    </a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <button class="btn btn-outline-secondary disabled" title="Stock maximum atteint">
                                                                        <i class="fas fa-plus"></i>
                                                                    </button>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            
                                                        </div>
                                                    </td>
                                                    
                                                    <td class="fw-bold text-brand">${item.sousTotal} MAD</td>
                                                    
                                                    <td class="text-end pe-4">
                                                        <a href="supprimer-article?id=${item.produit.id}" 
                                                           class="btn btn-outline-danger btn-sm rounded-circle p-2"
                                                           onclick="return confirm('Voulez-vous retirer ce produit de votre panier ?');"
                                                           title="Supprimer">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        
                        <a href="catalogue" class="btn btn-outline-secondary"><i class="fas fa-arrow-left me-2"></i>Retour au catalogue</a>
                    </div>

                    <div class="col-lg-4 mt-4 mt-lg-0">
                        <div class="card border-0 shadow-sm">
                            <div class="card-header bg-white py-3">
                                <h5 class="mb-0 fw-bold">Résumé de la commande</h5>
                            </div>
                            <div class="card-body">
                                <div class="d-flex justify-content-between mb-3 text-muted">
                                    <span>Articles (${panier.items.size()})</span>
                                    <span>${panier.total} MAD</span>
                                </div>
                                <div class="d-flex justify-content-between mb-3 text-muted">
                                    <span>Frais de livraison</span>
                                    <span class="text-success fw-bold">Gratuit</span>
                                </div>
                                <hr class="my-4">
                                <div class="d-flex justify-content-between mb-4">
                                    <span class="fs-5 fw-bold text-dark">Total à payer</span>
                                    <span class="fs-4 fw-bold text-brand">${panier.total} MAD</span>
                                </div>
                                
                                <a href="validercommande" class="btn btn-brand w-100 py-3 rounded-3 shadow-sm text-uppercase fw-bold">
                                    Valider ma commande <i class="fas fa-lock ms-2"></i>
                                </a>
                                
                                <div class="mt-4 text-center">
                                    <div class="text-muted small mb-2">Paiement 100% sécurisé</div>
                                    <i class="fab fa-cc-visa fa-2x text-muted mx-1"></i>
                                    <i class="fab fa-cc-mastercard fa-2x text-muted mx-1"></i>
                                    <i class="fab fa-cc-paypal fa-2x text-muted mx-1"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>