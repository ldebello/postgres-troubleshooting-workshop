SELECT 
    SUM(blks_hit) * 100/ SUM(blks_hit+blks_read) AS hit_ratio 
FROM
    pg_stat_database;