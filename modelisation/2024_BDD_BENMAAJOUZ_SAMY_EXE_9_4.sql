-- Créer un déclencheur pour mettre à jour le champ `retard` dans la table `Retourmateriel` lors de la mise à jour de `date_retour_effectif` dans la table `Reservation`
CREATE OR REPLACE FUNCTION check_retard()
RETURNS TRIGGER AS $$
DECLARE
    retard_days SMALLINT;
BEGIN
    -- Vérifier si la date de retour effective est postérieure à la date de fin prévue
    IF NEW.date_retour_effectif > (SELECT date_fin FROM Reservation WHERE id_reservation = NEW.id_reservation) THEN
        -- Calculer le retard en jours
        retard_days = NEW.date_retour_effectif - (SELECT date_fin FROM Reservation WHERE id_reservation = NEW.id_reservation);
        -- Mettre à jour le champ `retard` dans la table `Retourmateriel`
        UPDATE Retourmateriel SET retard = retard_days WHERE id_reservation = NEW.id_reservation;
    ELSE
        -- Mettre à jour le champ `retard` dans la table `Retourmateriel` à 0 si pas de retard
        UPDATE Retourmateriel SET retard = 0 WHERE id_reservation = NEW.id_reservation;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Créer le déclencheur qui appelle la fonction `check_retard` avant une mise à jour de `date_retour_effectif`
CREATE TRIGGER trg_check_retard
AFTER UPDATE OF date_retour_effectif ON Reservation
FOR EACH ROW
EXECUTE FUNCTION check_retard();

-- Créer un déclencheur pour mettre à jour le champ `retard` dans la table `Retourmateriel` lors de l'insertion d'une nouvelle réservation
CREATE OR REPLACE FUNCTION set_retard_on_insert()
RETURNS TRIGGER AS $$
DECLARE
    retard_days SMALLINT;
BEGIN
    -- Vérifier si la date de retour effective est postérieure à la date de fin prévue
    IF NEW.date_retour_effectif > NEW.date_fin THEN
        -- Calculer le retard en jours
        retard_days = NEW.date_retour_effectif - NEW.date_fin;
        -- Insérer le retard dans la table `Retourmateriel`
        INSERT INTO Retourmateriel (id_retour, date_retour, retard, id_reservation)
        VALUES (gen_random_uuid(), NEW.date_retour_effectif, retard_days, NEW.id_reservation);
    ELSE
        -- Insérer le retard dans la table `Retourmateriel` à 0 si pas de retard
        INSERT INTO Retourmateriel (id_retour, date_retour, retard, id_reservation)
        VALUES (gen_random_uuid(), NEW.date_retour_effectif, 0, NEW.id_reservation);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Créer le déclencheur qui appelle la fonction `set_retard_on_insert` après une insertion
CREATE TRIGGER trg_set_retard_on_insert
AFTER INSERT ON Reservation
FOR EACH ROW
EXECUTE FUNCTION set_retard_on_insert();
