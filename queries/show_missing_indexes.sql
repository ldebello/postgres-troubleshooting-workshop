SELECT
    relname AS table_name,
    seq_scan - idx_scan AS too_much_seq,
    CASE
    WHEN
        seq_scan - COALESCE(idx_scan, 0) > 0
    THEN
        'Missing Index?'
    ELSE
        'OK'
    END AS result,
    pg_size_pretty(pg_relation_size(relname::regclass)) AS table_size,
    seq_scan AS sequential_scans, 
    idx_scan AS indexes_scans
FROM
    pg_stat_user_tables
WHERE
    schemaname = 'public' AND
    n_live_tup != 0
ORDER BY
    too_much_seq DESC;