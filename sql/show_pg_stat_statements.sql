-- Este query requiere la extension de pg_stat_statements
SELECT
    (total_time / 1000 / 60) AS total_minutes,
    (total_time/calls) AS average_time,
    calls,
    temp_blks_read,
    temp_blks_written,
    query
FROM
    pg_stat_statements
ORDER BY 
    temp_blks_written DESC,
    temp_blks_read DESC
LIMIT 100;