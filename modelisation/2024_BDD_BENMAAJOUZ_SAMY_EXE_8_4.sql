-- Création de la procédure ajouter_disponibilite
CREATE OR REPLACE PROCEDURE ajouter_disponibilite (
    IN p_date_debut DATE,
    IN p_date_fin DATE,
    IN p_id_materiel VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Vérifie que la date de début est antérieure à la date de fin
    IF p_date_debut >= p_date_fin THEN
        RAISE EXCEPTION 'La date de début doit être antérieure à la date de fin.';
    ELSE
        INSERT INTO Disponibilite (date_debut, date_fin, id_materiel)
        VALUES (p_date_debut, p_date_fin, p_id_materiel);
    END IF;
END;
$$;

-- Création de la procédure modifier_disponibilite
CREATE OR REPLACE PROCEDURE modifier_disponibilite (
    IN p_id_disponibilite VARCHAR(50),
    IN p_nouvelle_date_debut DATE,
    IN p_nouvelle_date_fin DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_nouvelle_date_debut >= p_nouvelle_date_fin THEN
        RAISE EXCEPTION 'La date de début doit être antérieure à la date de fin.';
    ELSE
        UPDATE Disponibilite
        SET date_debut = p_nouvelle_date_debut,
            date_fin = p_nouvelle_date_fin
        WHERE id_disponibilite = p_id_disponibilite;
    END IF;
END;
$$;

-- Création de la procédure supprimer_disponibilite
CREATE OR REPLACE PROCEDURE supprimer_disponibilite (
    IN p_id_disponibilite VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Disponibilite
    WHERE id_disponibilite = p_id_disponibilite;
END;
$$;
