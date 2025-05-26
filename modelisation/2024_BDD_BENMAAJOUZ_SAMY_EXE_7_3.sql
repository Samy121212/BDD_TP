-- Ajout obligé pour avoir un résultat
INSERT INTO reservation (id_reservation, date_deb, date_fin,id_utilisateur, id_materiel)
VALUES (5, '2025-2-10','2025-2-10',6,2),
       (6, '2025-3-15','2025-3-15',7,2),
       (7, '2025-4-5','2025-4-5',8,2),
       (8, '2025-5-10','2025-5-10',9,2);
	   
SELECT m.id_materiel, m.mobilier, COUNT(r.id_reservation) AS nb_emprunts
FROM reservation r
JOIN materiel m ON r.id_materiel = m.id_materiel
WHERE m.mobilier = 'chaise'
GROUP BY m.id_materiel, m.mobilier
HAVING COUNT(r.id_reservation) > 3;