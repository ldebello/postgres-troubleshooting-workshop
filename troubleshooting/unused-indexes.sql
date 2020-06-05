SELECT
  s.relname AS table,
  s.indexrelname AS index,
  pg_size_pretty(pg_relation_size(s.indexrelid)) AS index_size,
  idx_scan as index_scans
FROM 
  pg_stat_user_indexes s JOIN 
    pg_index i USING (indexrelid) 
WHERE 
  s.idx_scan < 50 AND
  indisunique IS FALSE AND
  pg_relation_size(relid) > 5 * 8192 AND -- Greater than 5 pages
  0 != ALL (i.indkey) AND -- No index column is an expression
  NOT EXISTS (SELECT 1 FROM pg_catalog.pg_constraint c WHERE c.conindid = s.indexrelid) -- Does not enforce a constraint
ORDER BY 
  pg_relation_size(s.indexrelid) DESC;