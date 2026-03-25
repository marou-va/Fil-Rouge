-- Script de mise à jour de la base de données
-- Objectif : Ajouter la gestion de la date de livraison

-- 1. Ajout de la colonne date_livraison à la table commande
ALTER TABLE commande 
ADD COLUMN date_livraison DATETIME DEFAULT NULL;

-- 2. Mise à jour des commandes déjà EN_COURS ou LIVREE (optionnel)
-- On initialise une date par défaut pour les commandes existantes si nécessaire
UPDATE commande 
SET date_livraison = date_commande 
WHERE statut IN ('EN_COURS', 'LIVREE') AND date_livraison IS NULL;
