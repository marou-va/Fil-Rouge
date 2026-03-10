<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <footer style="background:linear-gradient(160deg,#0f0c29,#1e1b4b);color:white;margin-top:80px;">
            <div class="container py-5">
                <div class="row g-5">
                    <!-- Brand -->
                    <div class="col-lg-4">
                        <div class="d-flex align-items-center gap-2 mb-3">
                            <div
                                style="width:36px;height:36px;background:linear-gradient(135deg,#7c3aed,#06b6d4);border-radius:10px;display:flex;align-items:center;justify-content:center;color:white;font-size:15px;">
                                <i class="fas fa-bolt"></i>
                            </div>
                            <span style="font-size:1.1rem;font-weight:800;">MaBoutique</span>
                        </div>
                        <p style="color:rgba(255,255,255,0.45);font-size:0.875rem;line-height:1.7;">
                            Votre destination shopping préférée pour des produits de qualité au meilleur prix. Livraison
                            rapide, paiement sécurisé.
                        </p>
                        <div class="d-flex gap-3 mt-4">
                            <a href="#"
                                style="width:36px;height:36px;background:rgba(255,255,255,0.08);border-radius:9px;display:flex;align-items:center;justify-content:center;color:rgba(255,255,255,0.6);text-decoration:none;transition:all 0.2s;"
                                onmouseover="this.style.background='rgba(124,58,237,0.5)';this.style.color='white'"
                                onmouseout="this.style.background='rgba(255,255,255,0.08)';this.style.color='rgba(255,255,255,0.6)'">
                                <i class="fab fa-facebook-f"></i>
                            </a>
                            <a href="#"
                                style="width:36px;height:36px;background:rgba(255,255,255,0.08);border-radius:9px;display:flex;align-items:center;justify-content:center;color:rgba(255,255,255,0.6);text-decoration:none;transition:all 0.2s;"
                                onmouseover="this.style.background='rgba(124,58,237,0.5)';this.style.color='white'"
                                onmouseout="this.style.background='rgba(255,255,255,0.08)';this.style.color='rgba(255,255,255,0.6)'">
                                <i class="fab fa-instagram"></i>
                            </a>
                            <a href="#"
                                style="width:36px;height:36px;background:rgba(255,255,255,0.08);border-radius:9px;display:flex;align-items:center;justify-content:center;color:rgba(255,255,255,0.6);text-decoration:none;transition:all 0.2s;"
                                onmouseover="this.style.background='rgba(124,58,237,0.5)';this.style.color='white'"
                                onmouseout="this.style.background='rgba(255,255,255,0.08)';this.style.color='rgba(255,255,255,0.6)'">
                                <i class="fab fa-twitter"></i>
                            </a>
                        </div>
                    </div>

                    <!-- Links -->
                    <div class="col-6 col-lg-2">
                        <h6
                            style="font-size:0.72rem;font-weight:800;text-transform:uppercase;letter-spacing:0.12em;color:rgba(255,255,255,0.35);margin-bottom:16px;">
                            Navigation</h6>
                        <ul class="list-unstyled" style="display:flex;flex-direction:column;gap:10px;">
                            <li><a href="catalogue"
                                    style="color:rgba(255,255,255,0.6);text-decoration:none;font-size:0.875rem;transition:color 0.2s;"
                                    onmouseover="this.style.color='#a78bfa'"
                                    onmouseout="this.style.color='rgba(255,255,255,0.6)'">Catalogue</a></li>
                            <li><a href="#"
                                    style="color:rgba(255,255,255,0.6);text-decoration:none;font-size:0.875rem;transition:color 0.2s;"
                                    onmouseover="this.style.color='#a78bfa'"
                                    onmouseout="this.style.color='rgba(255,255,255,0.6)'">À propos</a></li>
                            <li><a href="#"
                                    style="color:rgba(255,255,255,0.6);text-decoration:none;font-size:0.875rem;transition:color 0.2s;"
                                    onmouseover="this.style.color='#a78bfa'"
                                    onmouseout="this.style.color='rgba(255,255,255,0.6)'">Contact</a></li>
                        </ul>
                    </div>
                    <div class="col-6 col-lg-2">
                        <h6
                            style="font-size:0.72rem;font-weight:800;text-transform:uppercase;letter-spacing:0.12em;color:rgba(255,255,255,0.35);margin-bottom:16px;">
                            Support</h6>
                        <ul class="list-unstyled" style="display:flex;flex-direction:column;gap:10px;">
                            <li><a href="#"
                                    style="color:rgba(255,255,255,0.6);text-decoration:none;font-size:0.875rem;">Livraison</a>
                            </li>
                            <li><a href="#"
                                    style="color:rgba(255,255,255,0.6);text-decoration:none;font-size:0.875rem;">Retours</a>
                            </li>
                            <li><a href="#"
                                    style="color:rgba(255,255,255,0.6);text-decoration:none;font-size:0.875rem;">FAQ</a>
                            </li>
                        </ul>
                    </div>

                    <!-- Newsletter -->
                    <div class="col-lg-4">
                        <h6
                            style="font-size:0.72rem;font-weight:800;text-transform:uppercase;letter-spacing:0.12em;color:rgba(255,255,255,0.35);margin-bottom:16px;">
                            Newsletter</h6>
                        <p style="color:rgba(255,255,255,0.45);font-size:0.875rem;margin-bottom:14px;">Recevez nos
                            offres exclusives directement dans votre boîte mail.</p>
                        <div
                            style="display:flex;background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.12);border-radius:12px;overflow:hidden;">
                            <input type="email" placeholder="votre@email.com"
                                style="flex:1;background:transparent;border:none;padding:12px 16px;color:white;font-size:0.875rem;outline:none;">
                            <button
                                style="background:linear-gradient(135deg,#7c3aed,#a855f7);color:white;border:none;padding:12px 20px;font-size:0.8rem;font-weight:700;cursor:pointer;white-space:nowrap;">
                                S'abonner
                            </button>
                        </div>
                    </div>
                </div>

                <hr style="border-color:rgba(255,255,255,0.08);margin:40px 0 24px;">
                <div style="display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:12px;">
                    <p style="color:rgba(255,255,255,0.25);font-size:0.78rem;margin:0;">
                        © 2026 MaBoutique — Projet Fil Rouge AQL. Tous droits réservés.
                    </p>
                    <div style="display:flex;gap:16px;">
                        <span style="color:rgba(255,255,255,0.2);font-size:0.72rem;">Politique de confidentialité</span>
                        <span style="color:rgba(255,255,255,0.2);font-size:0.72rem;">CGU</span>
                    </div>
                </div>
            </div>
        </footer>