CREATE OR REPLACE FUNCTION verifier_disponibilite_reservation()
RETURNS TRIGGER AS $$
DECLARE
    dispo RECORD;
BEGIN
    -- Récupérer les dates de disponibilité
    SELECT * INTO dispo
    FROM Disponibilite
    WHERE id_disponibilite = NEW.id_disponibilite;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Disponibilité non trouvée pour l''id %', NEW.id_disponibilite;
    END IF;

    -- Vérifie que la période de réservation est bien dans la plage de disponibilité
    IF NEW.date_deb < dispo.date_debut OR NEW.date_fin > dispo.date_fin THEN
        RAISE EXCEPTION 'La réservation [% - %] dépasse la période de disponibilité [% - %]',
                        NEW.date_deb, NEW.date_fin, dispo.date_debut, dispo.date_fin;
    END IF;

    -- Vérifie que le matériel de la réservation correspond à celui de la disponibilité
    IF NEW.id_materiel != dispo.id_materiel THEN
        RAISE EXCEPTION 'Le matériel réservé (%) ne correspond pas à celui disponible (%)',
                        NEW.id_materiel, dispo.id_materiel;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verifier_disponibilite
BEFORE INSERT OR UPDATE ON Reservation
FOR EACH ROW
EXECUTE FUNCTION verifier_disponibilite_reservation();
