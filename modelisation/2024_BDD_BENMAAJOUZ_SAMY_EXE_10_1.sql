-- Suppression des contraintes de clé étrangère
ALTER TABLE Disponibilite DROP CONSTRAINT IF EXISTS disponibilite_id_materiel_fkey;
ALTER TABLE Reservation DROP CONSTRAINT IF EXISTS reservation_id_utilisateur_fkey;
ALTER TABLE Reservation DROP CONSTRAINT IF EXISTS reservation_id_materiel_fkey;
ALTER TABLE Reservation DROP CONSTRAINT IF EXISTS reservation_id_disponibilite_fkey;
ALTER TABLE Retourmateriel DROP CONSTRAINT IF EXISTS retourmateriel_id_reservation_fkey;

-- Vider les tables
TRUNCATE TABLE Retourmateriel CASCADE;
TRUNCATE TABLE Reservation CASCADE;
TRUNCATE TABLE Disponibilite CASCADE;
TRUNCATE TABLE Materiel CASCADE;
TRUNCATE TABLE Utilisateur CASCADE;

-- Insertion de 100 lignes dans Utilisateur
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Utilisateur (id_utilisateur, nom, prenom, email)
        VALUES (
            'U' || LPAD(i::text, 3, '0'),
            'Nom_' || i,
            'Prenom_' || i,
            'user_' || i || '@example.com'
        );
    END LOOP;
END $$;

-- Insertion de 100 lignes dans Materiel
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO Materiel (id_materiel, quantite, mobilier, informatique)
        VALUES (
            'M' || LPAD(i::text, 3, '0'),
            (random() * 20)::INT + 1, -- Quantité aléatoire entre 1 et 20
            'Mobilier_' || i,
            'Informatique_' || i
        );
    END LOOP;
END $$;

-- Insertion de 200 lignes dans Disponibilite
DO $$
DECLARE
    i INT;
    start_date DATE;
    end_date DATE;
BEGIN
    FOR i IN 1..200 LOOP
        -- Générer des dates de début et de fin aléatoires
        start_date := DATE '2025-01-01' + (random() * 365)::INT;
        end_date := start_date + (random() * 30)::INT;

        INSERT INTO Disponibilite (id_disponibilite, date_debut, date_fin, id_materiel)
        VALUES (
            'D' || LPAD(i::text, 3, '0'),
            start_date,
            end_date,
            'M' || LPAD(((random() * 99)::INT + 1)::text, 3, '0') -- id_materiel aléatoire entre 1 et 99
        );
    END LOOP;
END $$;

-- Insertion de 200 lignes dans Reservation
DO $$
DECLARE
    i INT;
    reservation_date DATE;
    return_date DATE;
    effective_return_date DATE;
BEGIN
    FOR i IN 1..200 LOOP
        -- Générer des dates de réservation, de retour et de retour effectif aléatoires
        reservation_date := DATE '2025-01-01' + (random() * 365)::INT;
        return_date := reservation_date + (random() * 15)::INT;
        effective_return_date := reservation_date + (random() * 15)::INT;

        INSERT INTO Reservation (id_reservation, date_deb, date_fin, date_retour_effectif, id_disponibilite, id_materiel, id_utilisateur)
        VALUES (
            'R' || LPAD(i::text, 3, '0'),
            reservation_date,
            return_date,
            effective_return_date,
            'D' || LPAD(((random() * 199)::INT + 1)::text, 3, '0'), -- id_disponibilite aléatoire entre 1 et 199
            'M' || LPAD(((random() * 99)::INT + 1)::text, 3, '0'), -- id_materiel aléatoire entre 1 et 99
            'U' || LPAD(((random() * 99)::INT + 1)::text, 3, '0') -- id_utilisateur aléatoire entre 1 et 99
        );
    END LOOP;
END $$;

-- Insertion de 200 lignes dans Retourmateriel
DO $$
DECLARE
    i INT;
    return_date DATE;
BEGIN
    FOR i IN 1..200 LOOP
        -- Générer des dates de retour aléatoires
        return_date := DATE '2025-01-01' + (random() * 365)::INT;

        INSERT INTO Retourmateriel (id_retour, date_retour, retard, id_reservation)
        VALUES (
            'RT' || LPAD(i::text, 3, '0'),
            return_date,
            0, -- Valeur initiale pour retard, sera calculée par le déclencheur
            'R' || LPAD(((random() * 199)::INT + 1)::text, 3, '0') -- id_reservation aléatoire entre 1 et 199
        );
    END LOOP;
END $$;
