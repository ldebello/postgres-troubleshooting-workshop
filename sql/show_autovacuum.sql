-- Lista las 10 tablas que necesitan autovacuum, listando de mas a menos urgente.
SELECT
    relname AS table_name,
    n_live_tup AS estimate_live_rows,
    n_dead_tup AS estimate_dead_rows,
    last_vacuum, 
    last_autovacuum, 
    last_analyze, 
    last_autoanalyze
FROM 
    pg_stat_user_tables
WHERE
    schemaname = 'public' AND
    n_live_tup != 0
ORDER BY 
    n_dead_tup / (n_live_tup * current_setting('autovacuum_vacuum_scale_factor')::float8 + current_setting('autovacuum_vacuum_threshold')::float8) DESC
LIMIT 10;