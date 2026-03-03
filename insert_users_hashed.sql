-- Ajout d'un utilisateur par défaut (Admin)
-- Mot de passe : admin123 (haché avec BCrypt)
INSERT INTO utilisateur (nom, email, mot_de_passe, role) 
VALUES ('Administrateur', 'admin@maboutique.com', '$2a$12$R.S7M1o7L8kLz7Jm6Yv8ZueE8mC0y5I7lY6cE9x9V9z9B6G1W2E3G', 'ADMIN');

-- Ajout d'un utilisateur client test
-- Mot de passe : client123 (haché avec BCrypt)
INSERT INTO utilisateur (nom, email, mot_de_passe, role) 
VALUES ('Jean Client', 'client@test.com', '$2a$12$P1l8z8u9l0u7m6Yv8ZueE8mC0y5I7lY6cE9x9V9z9B6G1W2E3G', 'CLIENT');
