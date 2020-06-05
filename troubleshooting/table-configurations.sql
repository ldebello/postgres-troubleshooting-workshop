SELECT
  relname AS table,
  reloptions AS options
FROM 
  pg_class 
WHERE
  reloptions IS NOT NULL;