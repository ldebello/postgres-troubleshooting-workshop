SELECT
    relname,
    indexrelname,
    SUM(idx_blks_read) AS index_block_read,
    SUM(idx_blks_hit) AS index_block_hit,
    (SUM(idx_blks_hit) - SUM(idx_blks_read)) / SUM(idx_blks_hit) AS ratio
FROM 
    pg_statio_user_indexes
WHERE
    idx_blks_hit > 0
GROUP BY
    relname,
    indexrelname
ORDER BY
    ratio;