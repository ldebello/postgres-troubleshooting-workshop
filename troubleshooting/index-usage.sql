SELECT
  relname AS table,
  100 * idx_scan / (seq_scan + idx_scan) AS usage_percentage,
  n_live_tup AS estime_rows
FROM
  pg_stat_user_tables
WHERE
  idx_scan != 0
ORDER BY
  n_live_tup DESC;