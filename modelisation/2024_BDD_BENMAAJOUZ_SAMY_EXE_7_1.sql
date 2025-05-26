SELECT DISTINCT u.id_utilisateur, u.nom, u.prenom, u.email FROM utilisateur u
JOIN reservation r ON u.id_utilisateur = r.id_utilisateur;
