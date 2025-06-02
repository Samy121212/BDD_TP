-- Suppression des tables existantes dans l'ordre inverse des dépendances 
DROP TABLE Reservation cascade;
DROP TABLE Disponibilite cascade;
DROP TABLE Materiel cascade;
DROP TABLE Utilisateur cascade;
DROP TABLE Retourmateriel cascade;

CREATE TABLE Utilisateur(
   id_utilisateur VARCHAR(50),
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(50),
   PRIMARY KEY(id_utilisateur)
);

CREATE TABLE Materiel(
   id_materiel VARCHAR(50),
   quantite SMALLINT,
   mobilier VARCHAR(50),
   informatique VARCHAR(50),
   PRIMARY KEY(id_materiel)
);

CREATE TABLE Disponibilite(
   id_disponibilite VARCHAR(50),
   date_debut DATE,
   date_fin DATE,
   id_materiel VARCHAR(50),
   PRIMARY KEY(id_disponibilite),
   FOREIGN KEY(id_materiel) REFERENCES Materiel(id_materiel)
);

CREATE TABLE Reservation(
   id_reservation VARCHAR(50),
   date_deb DATE,
   date_fin DATE,
   date_retour_effectif DATE,
   id_disponibilite VARCHAR(50),
   id_materiel VARCHAR(50) NOT NULL,
   id_utilisateur VARCHAR(50),
   PRIMARY KEY(id_reservation),
   FOREIGN KEY(id_disponibilite) REFERENCES Disponibilite(id_disponibilite),
   FOREIGN KEY(id_materiel) REFERENCES Materiel(id_materiel),
   FOREIGN KEY(id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
);

CREATE TABLE Retourmateriel(
   id_retour VARCHAR(50),
   date_retour DATE,
   retard SMALLINT,
   id_reservation VARCHAR(50),
   PRIMARY KEY(id_retour),
   FOREIGN KEY(id_reservation) REFERENCES Reservation(id_reservation)
);

