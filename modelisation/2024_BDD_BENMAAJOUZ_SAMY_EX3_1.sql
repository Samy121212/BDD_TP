SELECT u.id_utilisateur, u.nom, u.prenom, u.email, r.id_reservation, r.date_deb, r.date_fin
FROM utilisateur u
JOIN reservation r ON u.id_utilisateur = r.id_utilisateur;