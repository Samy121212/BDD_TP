SELECT u.id_utilisateur, u.nom,u.prenom, COUNT(r.id_reservation) AS nb_emprunts
FROM utilisateur u
LEFT JOIN reservation r ON u.id_utilisateur = r.id_utilisateur
GROUP BY u.id_utilisateur, u.nom, u.prenom
ORDER BY u.id_utilisateur;