DELETE FROM reservation
WHERE date_fin < CURRENT_DATE;

SELECT * FROM reservation;