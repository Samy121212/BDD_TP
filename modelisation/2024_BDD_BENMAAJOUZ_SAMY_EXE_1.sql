INSERT INTO utilisateur (id_utilisateur, nom, prenom, email)
VALUES
    (1, 'Dupont', 'Jean', 'jean.dupont@example.com'),
    (2, 'Martin', 'Marie', 'marie.martin@example.com'),
    (3, 'Durand', 'Pierre', 'pierre.durand@example.com'),
    (4, 'Leroy', 'Sophie', 'sophie.leroy@example.com'),
    (5, 'Bernard', 'Luc', 'luc.bernard@example.com'),
    (6, 'Petit', 'Claire', 'claire.petit@example.com'),
    (7, 'Moreau', 'Thomas', 'thomas.moreau@example.com'),
    (8, 'Duclaire', 'Paul', 'paul.duclaire@example.com'),
    (9, 'Molly', 'Anna', 'anna.molly@example.com'),
    (10, 'Lefevre', 'Nicolas', 'nicolas.lefevre@example.com');

SELECT * FROM utilisateur;

INSERT INTO materiel (id_materiel, quantite, mobilier, informatique)
VALUES (1, 10,'table', 'ordinateur'),
		(2, 5,'chaise', 'clavier'),
		(3, 10,'table', 'souris'),
		(4, 6,'chaise', 'clavier'),
		(5, 15,'table', 'ordinateur'),
		(6, 2,'chaise', 'souris'),
		(7, 1,'table', 'ordinateur'),
		(8, 11,'chaise', 'clavier'),
		(9, 8,'table', 'ecran'),
		(10, 6,'chaise', 'clavier');

SELECT * FROM materiel;

INSERT INTO reservation (id_reservation, date_deb, date_fin,id_utilisateur, id_materiel)
VALUES (1, '2025-10-5','2025-10-5',1,1),
		(2, '2025-12-1','2025-12-1',2,2),
		(3, '2025-5-25','2025-5-25',3,3),
		(4, '2025-4-20','2025-4-20',4,4),
		(5, '2025-1-9','2025-1-9',5,5);

SELECT * FROM reservation;


