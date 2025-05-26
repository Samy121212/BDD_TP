SELECT m.id_materiel, m.mobilier, m.informatique, m.quantite FROM materiel m
WHERE m.id_materiel NOT IN (
    SELECT DISTINCT id_materiel
    FROM reservation
);
