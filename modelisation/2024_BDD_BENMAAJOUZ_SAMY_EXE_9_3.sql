-- Suppression des tables existantes dans l'ordre inverse des dépendances
DROP TABLE IF EXISTS Retourmateriel CASCADE;
DROP TABLE IF EXISTS Reservation CASCADE;
DROP TABLE IF EXISTS Disponibilite CASCADE;
DROP TABLE IF EXISTS Materiel CASCADE;
DROP TABLE IF EXISTS Utilisateur CASCADE;

-- Création des tables avec les contraintes appropriées

CREATE TABLE Utilisateur (
   id_utilisateur VARCHAR(50),
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(50),
   PRIMARY KEY (id_utilisateur)
);

CREATE TABLE Materiel (
   id_materiel VARCHAR(50),
   quantite SMALLINT,
   mobilier VARCHAR(50),
   informatique VARCHAR(50),
   PRIMARY KEY (id_materiel)
);

CREATE TABLE Disponibilite (
   id_disponibilite VARCHAR(50),
   date_debut DATE,
   date_fin DATE,
   id_materiel VARCHAR(50),
   PRIMARY KEY (id_disponibilite),
   FOREIGN KEY (id_materiel) REFERENCES Materiel(id_materiel),
   CHECK (date_fin >= date_debut)
);

CREATE TABLE Reservation (
   id_reservation VARCHAR(50),
   date_deb DATE,
   date_fin DATE,
   date_retour_effectif DATE,
   id_disponibilite VARCHAR(50),
   id_materiel VARCHAR(50) NOT NULL,
   id_utilisateur VARCHAR(50),
   PRIMARY KEY (id_reservation),
   FOREIGN KEY (id_disponibilite) REFERENCES Disponibilite(id_disponibilite),
   FOREIGN KEY (id_materiel) REFERENCES Materiel(id_materiel),
   FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_utilisateur),
   CHECK (date_fin >= date_deb),
   CHECK (date_retour_effectif >= date_deb)
);

CREATE TABLE Retourmateriel (
   id_retour VARCHAR(50),
   date_retour DATE,
   retard SMALLINT,
   id_reservation VARCHAR(50),
   PRIMARY KEY (id_retour),
   FOREIGN KEY (id_reservation) REFERENCES Reservation(id_reservation),
   CHECK (retard >= 0)
);

-- Création d'un déclencheur pour calculer automatiquement le retard sur le retour du matériel

CREATE OR REPLACE FUNCTION calculer_retard()
RETURNS TRIGGER AS $$
BEGIN
    -- Calculer le retard en jours
    NEW.retard = (NEW.date_retour - (SELECT date_fin FROM Reservation WHERE id_reservation = NEW.id_reservation));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Créer le déclencheur qui appelle la fonction `calculer_retard` avant une insertion ou une mise à jour
CREATE TRIGGER trg_calculer_retard
BEFORE INSERT OR UPDATE ON Retourmateriel
FOR EACH ROW
EXECUTE FUNCTION calculer_retard();
