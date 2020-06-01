SELECT 
    relname, 
    100 * idx_scan / (seq_scan + idx_scan) percent_of_times_index_used, 
    n_live_tup estime_rows 
FROM 
    pg_stat_user_tables 
WHERE
    schemaname = 'public' AND
    idx_scan != 0 
ORDER BY 
    n_live_tup DESC;