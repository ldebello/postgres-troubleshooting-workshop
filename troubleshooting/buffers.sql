SELECT
  c.relname,
  COUNT(*) AS buffers,
  pg_size_pretty(COUNT(*) * 8192) AS buffered,
  ROUND(100.0 * COUNT(*) / (SELECT setting FROM pg_settings WHERE name='shared_buffers')::integer,1) AS buffer_percentage,
  ROUND(100.0 * COUNT(*) * 8192 / pg_table_size(c.oid),1) AS table_percentage
FROM 
  pg_class c INNER JOIN
    pg_buffercache b ON b.relfilenode = c.relfilenode INNER JOIN
    pg_database d ON (b.reldatabase = d.oid AND d.datname = current_database()) 
GROUP BY
  c.oid,
  c.relname
ORDER BY
  buffer_percentage DESC
LIMIT 10;