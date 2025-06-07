-- Création des index
CREATE INDEX idx_reservation_id_utilisateur ON Reservation(id_utilisateur);
CREATE INDEX idx_reservation_id_materiel ON Reservation(id_materiel);
CREATE INDEX idx_reservation_id_disponibilite ON Reservation(id_disponibilite);
CREATE INDEX idx_reservation_date_deb ON Reservation(date_deb);

