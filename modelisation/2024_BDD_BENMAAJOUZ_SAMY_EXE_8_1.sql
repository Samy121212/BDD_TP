-- Suppression des tables existantes dans l'ordre inverse des dépendances
DROP TABLE IF EXISTS Reserver;
DROP TABLE IF EXISTS Stock;
DROP TABLE IF EXISTS Reservation;
DROP TABLE IF EXISTS Disponibilite;
DROP TABLE IF EXISTS Materiel;
DROP TABLE IF EXISTS Utilisateur;

-- Création de la table Utilisateur
CREATE TABLE Utilisateur(
   id_utilisateur VARCHAR(50),
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(50),
   PRIMARY KEY(id_utilisateur)
);

-- Création de la table Materiel
CREATE TABLE Materiel(
   id_materiel VARCHAR(50),
   quantite SMALLINT,
   mobilier VARCHAR(50),
   informatique VARCHAR(50),
   PRIMARY KEY(id_materiel)
);

-- Création de la table Disponibilite
CREATE TABLE Disponibilite(
   id_disponibilite VARCHAR(50),
   id_materiel VARCHAR(50),
   date_debut DATE,
   date_fin DATE,
   PRIMARY KEY(id_disponibilite, id_materiel),
   FOREIGN KEY(id_materiel) REFERENCES Materiel(id_materiel)
);

-- Création de la table Reservation avec la nouvelle colonne id_disponibilite
CREATE TABLE Reservation(
   id_reservation VARCHAR(50),
   id_disponibilite VARCHAR(50),
   id_materiel VARCHAR(50),
   date_deb DATE,
   date_fin DATE,
   id_utilisateur VARCHAR(50),
   PRIMARY KEY(id_reservation),
   FOREIGN KEY(id_materiel) REFERENCES Materiel(id_materiel),
   FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur),
   FOREIGN KEY(id_disponibilite, id_materiel) REFERENCES Disponibilite(id_disponibilite, id_materiel)
);

-- Création de la table Reserver
CREATE TABLE Reserver(
   id_reservation VARCHAR(50),
   id_disponibilite VARCHAR(50),
   id_disponibilite_1 VARCHAR(50),
   id_materiel VARCHAR(50),
   PRIMARY KEY(id_reservation, id_disponibilite, id_disponibilite_1, id_materiel),
   FOREIGN KEY(id_reservation) REFERENCES Reservation(id_reservation),
   FOREIGN KEY(id_disponibilite_1, id_materiel) REFERENCES Disponibilite(id_disponibilite, id_materiel)
);

-- Création de la table Stock
CREATE TABLE Stock(
   id_materiel VARCHAR(50),
   id_disponibilite VARCHAR(50),
   id_materiel_1 VARCHAR(50),
   PRIMARY KEY(id_materiel, id_disponibilite, id_materiel_1),
   FOREIGN KEY(id_materiel) REFERENCES Materiel(id_materiel),
   FOREIGN KEY(id_disponibilite, id_materiel_1) REFERENCES Disponibilite(id_disponibilite, id_materiel)
);
