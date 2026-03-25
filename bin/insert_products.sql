-- Insertion des catégories
INSERT INTO `categorie` (`id`, `nom`, `description`) VALUES
(1, 'Électronique', 'Smartphones, ordinateurs, casques et accessoires high-tech.'),
(2, 'Maison & Déco', 'Meubles, éclairage et objets de décoration pour votre intérieur.'),
(3, 'Mode', 'Vêtements et chaussures pour hommes et femmes.'),
(4, 'Beauté & Santé', 'Soins du corps, parfums et produits de bien-être.'),
(5, 'Livres', 'Romans, guides techniques et littérature classique.');

-- Insertion des produits avec images
INSERT INTO `produit` (`nom`, `description`, `prix`, `stock`, `actif`, `image_url`, `categorie_id`) VALUES
('Dell XPS 13', 'Ordinateur portable ultra-fin avec écran InfinityEdge 13.4 pouces.', 1299.99, 15, 1, 'images/dell_xps13.webp', 1),
('Samsung Galaxy S23', 'Smartphone Android puissant avec un excellent système de caméras.', 849.00, 25, 1, 'images/galaxy_s23.webp', 1),
('Canapé 3 Places', 'Canapé moderne et confortable en tissu gris anthracite.', 599.00, 8, 1, 'images/canape_3places.webp', 2),
('Lampe LED Bureau', 'Lampe de bureau articulée avec réglage de luminosité et de température.', 45.50, 50, 1, 'images/lampe_led.webp', 2),
('Chaussures de Running', 'Chaussures de sport légères offrant un excellent amorti.', 89.90, 30, 1, 'images/chaussures_running.webp', 3),
('T-shirt Noir Basique', 'T-shirt 100% coton bio, coupe classique et confortable.', 19.99, 100, 1, 'images/tshirt_noir.webp', 3),
('Crème Hydratante CeraVe', 'Soin hydratant visage et corps pour peaux sèches à très sèches.', 15.20, 45, 1, 'images/creme_hydratante_cerave.webp', 4),
('Parfum Chanel N°5', 'L''iconique parfum Chanel en format 50ml.', 115.00, 12, 1, 'images/parfum_50ml_chanel.webp', 4),
('Guide Complet Java', 'Tout ce qu''il faut savoir pour maîtriser le développement Java.', 39.00, 20, 1, 'images/java_guide.webp', 5),
('Le Petit Prince', 'Le chef-d''œuvre d''Antoine de Saint-Exupéry.', 12.50, 60, 1, 'images/petit_prince.webp', 5);
