SELECT u.id_utilisateur, u.nom, u.prenom, u.email, m.id_materiel, m.quantite AS quantite, m.informatique, r.date_deb,r.date_fin
FROM utilisateur u
JOIN reservation r ON u.id_utilisateur = r.id_utilisateur
JOIN materiel m ON r.id_materiel = m.id_materiel
WHERE u.id_utilisateur = '1';