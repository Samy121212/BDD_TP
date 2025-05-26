UPDATE materiel m
SET quantite = quantite - 1
WHERE id_materiel IN (
    SELECT r.id_materiel
    FROM reservation r
    WHERE r.date_fin > CURRENT_DATE + INTERVAL '2 days'
);

SELECT * FROM materiel;
