-- Muestra estadisticas de nuestras tablas
SELECT
    relname AS table_name,
    n_live_tup AS estimate_live_rows,
    n_dead_tup AS estimate_dead_rows,
    seq_scan AS total_seq_scan,
    seq_tup_read AS total_fetch_seq_scan,
    idx_scan AS total_index_scan,
    idx_tup_fetch AS total_fetch_idx_scan,
    n_tup_ins AS inserted_rows,
    n_tup_del AS deleted_rows,
    n_tup_upd AS updated_rows,
    n_tup_hot_upd AS updated_rows_hot,
    COALESCE(n_tup_ins,0) + COALESCE(n_tup_upd,0) - COALESCE(n_tup_hot_upd,0) + COALESCE(n_tup_del,0) AS total,
    (COALESCE(n_tup_hot_upd,0)::float * 100/(CASE WHEN n_tup_upd > 0 THEN n_tup_upd ELSE 1 END)::float)::numeric(10,2) AS hot_rate,
    pg_size_pretty(pg_relation_size(relname::regclass)) AS table_size
FROM 
    pg_stat_user_tables