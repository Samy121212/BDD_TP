-- commande pour avoir le plan d'execution

EXPLAIN ANALYZE
SELECT 
    u.id_utilisateur,
    u.nom,
    u.prenom,
    m.id_materiel,
    m.mobilier,
    m.informatique,
    d.date_debut AS date_disponible_debut,
    d.date_fin AS date_disponible_fin,
    r.id_reservation,
    r.date_deb AS date_reservation_debut,
    r.date_fin AS date_reservation_fin,
    r.date_retour_effectif
FROM 
    Reservation r
JOIN Utilisateur u ON r.id_utilisateur = u.id_utilisateur
JOIN Materiel m ON r.id_materiel = m.id_materiel
JOIN Disponibilite d ON r.id_disponibilite = d.id_disponibilite
ORDER BY 
    r.date_deb
LIMIT 50;

/* les causes de ralentissement sont les suivantes : 1-Manque d’index sur : Reservation.id_utilisateur, Reservation.id_materiel, Reservation.id_disponibilite
Reservation.date_deb
2-Tables volumineuses sans condition de filtrage (WHERE), donc tout est lu.
3-Jointures multiples sans optimisation : si les tables ne sont pas indexées sur les colonnes de jointure, chaque JOIN peut devenir très coûteux.*/
