SELECT
  relname AS table_name,
  seq_scan AS sequential_scans,
  idx_scan AS indexes_scans,
  seq_scan - COALESCE(idx_scan, 0) AS diff,
  pg_size_pretty(pg_relation_size(relname::regclass)) AS table_size,
  CASE
    WHEN seq_scan - COALESCE(idx_scan, 0) > 0 THEN 'Missing Index?'
    ELSE 'OK'
  END AS conclusion
FROM
  pg_stat_user_tables
WHERE
  n_live_tup != 0
ORDER BY
  diff DESC;