SELECT COUNT(DISTINCT r.id_utilisateur) AS nombre_utilisateurs_ayant_emprunte
FROM reservation r
JOIN utilisateur u ON r.id_utilisateur = u.id_utilisateur
JOIN materiel m ON r.id_materiel = m.id_materiel;
