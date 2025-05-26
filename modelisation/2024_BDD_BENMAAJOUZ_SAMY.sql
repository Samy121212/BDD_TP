SELECT COUNT(*) AS nombre_total_reservations
FROM reservation
WHERE date_deb BETWEEN '2025-10-05' AND '2025-12-01';
