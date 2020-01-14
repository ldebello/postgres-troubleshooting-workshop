-- commit_ratio aprox > 95%
-- rollback_ratio aprox < 5%
-- deadlocks cercano a 0
-- conflicts cercano a 0
SELECT
	datname,
	(xact_commit * 100) / (xact_commit + xact_rollback) AS commit_ratio,
	(xact_rollback * 100) / (xact_commit + xact_rollback) AS rollback_ratio,
	deadlocks,
	conflicts,
	temp_files,
	pg_size_pretty(pg_database_size(datname)) AS db_size
FROM
	pg_stat_database
WHERE
	xact_commit + xact_rollback != 0;