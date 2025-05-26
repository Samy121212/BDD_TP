-- Activer l'extension uuid-ossp pour générer des UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Ajouter des matériels
INSERT INTO Materiel (id_materiel, quantite, mobilier, informatique) VALUES
('MAT001', 10, 'Chaise', NULL),
('MAT002', 5, 'Table', NULL),
('MAT003', 20, NULL, 'Ordinateur');

-- Ajouter des utilisateurs
INSERT INTO Utilisateur (id_utilisateur, nom, prenom, email) VALUES
('USER001', 'Dupont', 'Jean', 'jean.dupont@example.com'),
('USER002', 'Martin', 'Marie', 'marie.martin@example.com');

-- Ajouter des périodes de disponibilité
CALL ajouter_disponibilite('2025-01-01', '2025-01-10', 'MAT001');
CALL ajouter_disponibilite('2025-01-15', '2025-01-20', 'MAT001');
CALL ajouter_disponibilite('2025-01-05', '2025-01-15', 'MAT002');
CALL ajouter_disponibilite('2025-01-20', '2025-01-30', 'MAT002');
CALL ajouter_disponibilite('2025-01-10', '2025-01-25', 'MAT003');

-- Effectuer des réservations
-- Réservation valide pour MAT001
INSERT INTO Reservation (id_reservation, id_disponibilite, date_deb, date_fin, id_materiel, id_utilisateur)
SELECT uuid_generate_v4(), id_disponibilite, '2025-01-02', '2025-01-08', 'MAT001', 'USER001'
FROM Disponibilite
WHERE id_materiel = 'MAT001' AND date_debut <= '2025-01-02' AND date_fin >= '2025-01-08';

-- Réservation valide pour MAT002
INSERT INTO Reservation (id_reservation, id_disponibilite, date_deb, date_fin, id_materiel, id_utilisateur)
SELECT uuid_generate_v4(), id_disponibilite, '2025-01-06', '2025-01-12', 'MAT002', 'USER002'
FROM Disponibilite
WHERE id_materiel = 'MAT002' AND date_debut <= '2025-01-06' AND date_fin >= '2025-01-12';

-- Réservation invalide pour MAT001 (période non disponible)
INSERT INTO Reservation (id_reservation, id_disponibilite, date_deb, date_fin, id_materiel, id_utilisateur)
SELECT uuid_generate_v4(), id_disponibilite, '2025-01-11', '2025-01-18', 'MAT001', 'USER001'
FROM Disponibilite
WHERE id_materiel = 'MAT001' AND date_debut <= '2025-01-11' AND date_fin >= '2025-01-18';

-- Réservation invalide pour MAT003 (période non disponible)
INSERT INTO Reservation (id_reservation, id_disponibilite, date_deb, date_fin, id_materiel, id_utilisateur)
SELECT uuid_generate_v4(), id_disponibilite, '2025-01-26', '2025-02-01', 'MAT003', 'USER002'
FROM Disponibilite
WHERE id_materiel = 'MAT003' AND date_debut <= '2025-01-26' AND date_fin >= '2025-02-01';

-- Vérifier les réservations
SELECT * FROM Reservation;
