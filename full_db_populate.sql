-- Cleanup existing tables
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `ligne_commande`;
DROP TABLE IF EXISTS `commande`;
DROP TABLE IF EXISTS `ligne_panier`;
DROP TABLE IF EXISTS `panier`;
DROP TABLE IF EXISTS `produit`;
DROP TABLE IF EXISTS `categorie`;
DROP TABLE IF EXISTS `utilisateur`;
SET FOREIGN_KEY_CHECKS = 1;

-- Table structure for table `categorie`
CREATE TABLE `categorie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `utilisateur`
-- Added telephone and adresse columns
CREATE TABLE `utilisateur` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role` enum('CLIENT','ADMIN') NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `adresse` text DEFAULT NULL,
  `date_creation` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `produit`
CREATE TABLE `produit` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) NOT NULL,
  `description` text,
  `prix` decimal(10,2) NOT NULL,
  `stock` int NOT NULL,
  `actif` tinyint(1) DEFAULT '1',
  `image_url` varchar(255) DEFAULT NULL,
  `categorie_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_produit_categorie` FOREIGN KEY (`categorie_id`) REFERENCES `categorie` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `panier`
CREATE TABLE `panier` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `utilisateur_id` bigint DEFAULT NULL,
  `date_creation` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `utilisateur_id` (`utilisateur_id`),
  CONSTRAINT `fk_panier_utilisateur` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `ligne_panier`
CREATE TABLE `ligne_panier` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `panier_id` bigint DEFAULT NULL,
  `produit_id` bigint DEFAULT NULL,
  `quantite` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_lp_panier` FOREIGN KEY (`panier_id`) REFERENCES `panier` (`id`),
  CONSTRAINT `fk_lp_produit` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `commande`
CREATE TABLE `commande` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `utilisateur_id` bigint DEFAULT NULL,
  `date_commande` datetime DEFAULT CURRENT_TIMESTAMP,
  `statut` enum('EN_COURS','VALIDEE','ANNULEE') DEFAULT 'EN_COURS',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_commande_utilisateur` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `ligne_commande`
CREATE TABLE `ligne_commande` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `commande_id` bigint DEFAULT NULL,
  `produit_id` bigint DEFAULT NULL,
  `quantite` int NOT NULL,
  `prix_unitaire` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_lc_commande` FOREIGN KEY (`commande_id`) REFERENCES `commande` (`id`),
  CONSTRAINT `fk_lc_produit` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- INSERT CATEGORIES
INSERT INTO `categorie` (id, nom, description) VALUES 
(1, 'Fruits & Légumes', 'Produits frais et de saison'),
(2, 'Épicerie Fine', 'Produits gourmets et sélectionnés'),
(3, 'Boissons', 'Jus naturels, vins et eaux minérales'),
(4, 'Boucherie', 'Viandes de qualité supérieure');

-- INSERT PRODUCTS
INSERT INTO `produit` (nom, description, prix, stock, image_url, categorie_id) VALUES 
('Pommes Bio', 'Pommes rouges croquantes issues de l''agriculture biologique.', 2.50, 50, 'https://images.unsplash.com/photo-1560806887-1e470b13e456', 1),
('Huile d''Olive Extra Vierge', 'Huile d''olive de première pression à froid, origine Provence.', 12.00, 30, 'https://images.unsplash.com/photo-1474979266404-7eaacbadcbaf', 2),
('Jus d''Orange Pur', 'Jus pressé sans sucres ajoutés, riche en vitamine C.', 4.50, 40, 'https://images.unsplash.com/photo-1624517452488-04869289c4ca', 3),
('Steak de Bœuf Charolais', 'Viande de bœuf tendre et savoureuse, élevée au pâturage.', 18.00, 15, 'https://images.unsplash.com/photo-1594041680534-e8c8cdebd659', 4),
('Avocats Hass', 'Avocats mûrs à point, parfaits pour vos salades ou guacamole.', 3.00, 25, 'https://images.unsplash.com/photo-1523049673857-eb18f1d743ff', 1),
('Miel de Lavande', 'Miel artisanal au parfum délicat de fleurs de lavande.', 8.50, 20, 'https://images.unsplash.com/photo-1587049352846-4a222e784d38', 2);

-- INSERT USERS (Password is 'password123' hashed with BCrypt)
INSERT INTO `utilisateur` (nom, email, mot_de_passe, role, telephone, adresse) VALUES 
('Jean Dupont', 'jean.dupont@email.com', '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07S0vZv0v9d.YymVmy', 'CLIENT', '0612345678', '12 rue des Fleurs, Paris'),
('Admin User', 'admin@ma-boutique.com', '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07S0vZv0v9d.YymVmy', 'ADMIN', '0600000000', '1 Boulevard du Web, Lyon');

-- INSERT ORDERS
-- Order 1 for Jean Dupont
INSERT INTO `commande` (utilisateur_id, statut) VALUES (1, 'VALIDEE');
INSERT INTO `ligne_commande` (commande_id, produit_id, quantite, prix_unitaire) VALUES (1, 1, 3, 2.50);
INSERT INTO `ligne_commande` (commande_id, produit_id, quantite, prix_unitaire) VALUES (1, 3, 2, 4.50);

-- Order 2 for Jean Dupont
INSERT INTO `commande` (utilisateur_id, statut) VALUES (1, 'EN_COURS');
INSERT INTO `ligne_commande` (commande_id, produit_id, quantite, prix_unitaire) VALUES (2, 2, 1, 12.00);

-- Order 3 for Jean Dupont
INSERT INTO `commande` (utilisateur_id, statut) VALUES (1, 'ANNULEE');
INSERT INTO `ligne_commande` (commande_id, produit_id, quantite, prix_unitaire) VALUES (3, 4, 1, 18.00);
