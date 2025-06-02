-- Ajouter une colonne pour les pénalités dans la table Retourmateriel
ALTER TABLE Retourmateriel
ADD COLUMN penalite DECIMAL(10, 2);

-- Fonction pour calculer les pénalités
CREATE OR REPLACE FUNCTION calculer_penalite()
RETURNS TRIGGER AS $$
DECLARE
    penalite_par_jour DECIMAL(10, 2) := 5.00; -- Montant de la pénalité par jour de retard
BEGIN
    -- Calculer le retard en jours
    NEW.retard = (NEW.date_retour - (SELECT date_fin FROM Reservation WHERE id_reservation = NEW.id_reservation));

    -- Calculer la pénalité
    IF NEW.retard > 0 THEN
        NEW.penalite = NEW.retard * penalite_par_jour;
    ELSE
        NEW.penalite = 0.00;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Mettre à jour le déclencheur pour inclure le calcul des pénalités
CREATE OR REPLACE TRIGGER trg_calculer_retard
BEFORE INSERT OR UPDATE ON Retourmateriel
FOR EACH ROW
EXECUTE FUNCTION calculer_penalite();

-- Insérer des données de test dans la table Utilisateur
INSERT INTO Utilisateur (id_utilisateur, nom, prenom, email) VALUES
('U001', 'Dupont', 'Jean', 'jean.dupont@example.com'),
('U002', 'Martin', 'Marie', 'marie.martin@example.com');

-- Insérer des données de test dans la table Materiel
INSERT INTO Materiel (id_materiel, quantite, mobilier, informatique) VALUES
('M001', 10, 'Chaise', NULL),
('M002', 5, NULL, 'Ordinateur');

-- Insérer des données de test dans la table Disponibilite
INSERT INTO Disponibilite (id_disponibilite, date_debut, date_fin, id_materiel) VALUES
('D001', '2023-10-01', '2023-10-10', 'M001'),
('D002', '2023-10-05', '2023-10-15', 'M002');

-- Insérer des données de test dans la table Reservation
INSERT INTO Reservation (id_reservation, date_deb, date_fin, date_retour_effectif, id_disponibilite, id_materiel, id_utilisateur) VALUES
('R001', '2023-10-02', '2023-10-10', '2023-10-10', 'D001', 'M001', 'U001'),
('R002', '2023-10-06', '2023-10-15', '2023-10-18', 'D002', 'M002', 'U002');

-- Insérer des données de test dans la table Retourmateriel
INSERT INTO Retourmateriel (id_retour, date_retour, id_reservation) VALUES
('RT001', '2023-10-10', 'R001'),
('RT002', '2023-10-18', 'R002');

-- Sélectionner les retours avec les pénalités
SELECT id_retour, date_retour, retard, penalite
FROM Retourmateriel;
