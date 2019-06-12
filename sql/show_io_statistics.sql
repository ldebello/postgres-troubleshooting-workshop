SELECT 
	t.relname AS table_name, 
	heap_blks_hit * 100 / (heap_blks_hit + heap_blks_read) AS heap_ratio,
	idx_blks_hit * 100 / (idx_blks_hit + idx_blks_read) AS idx_ratio
FROM 
	pg_statio_user_tables t
WHERE 
	t.heap_blks_read > 0 AND
	t.idx_blks_read > 0;