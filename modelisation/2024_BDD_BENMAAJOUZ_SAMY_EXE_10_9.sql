CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE INDEX idx_utilisateur_nom_trgm ON Utilisateur USING gin (nom gin_trgm_ops);
EXPLAIN ANALYZE
SELECT * FROM Utilisateur WHERE nom LIKE '%nom%1%';
