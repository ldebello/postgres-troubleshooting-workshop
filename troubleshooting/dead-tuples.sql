SELECT
  relname AS table,
  n_live_tup AS live_tuples,
  n_dead_tup AS dead_tuples,
  last_autovacuum
FROM pg_stat_user_tables
ORDER BY
  n_dead_tup / (n_live_tup * current_setting('autovacuum_vacuum_scale_factor')::float8 + current_setting('autovacuum_vacuum_threshold')::float8) DESC;