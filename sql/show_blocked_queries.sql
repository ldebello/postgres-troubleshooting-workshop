-- Simple Version
SELECT
    pid,
    usename,
    pg_blocking_pids(pid) AS blocked_by,
    query AS blocked_query
FROM 
    pg_stat_activity
WHERE 
    cardinality(pg_blocking_pids(pid)) > 0;
-- Complex Version
SELECT
    blocked_locks.pid AS blocked_pid,
    blocked_activity.query AS blocked_query,
    blocked_activity.usename AS blocked_user,
    blocked_locks.mode AS blocked_mode,
    blocking_locks.pid AS blocking_pid,
    blocking_activity.query AS blocking_query,
    blocking_activity.usename AS blocking_user,
    blocking_locks.mode AS blocking_mode,
    now() - blocked_activity.query_start AS waiting_duration
FROM
    pg_locks blocked_locks JOIN 
        pg_stat_activity blocked_activity  ON blocked_activity.pid = blocked_locks.pid JOIN 
        pg_locks blocking_locks ON blocking_locks.locktype = blocked_locks.locktype AND 
    blocking_locks.DATABASE IS NOT DISTINCT FROM blocked_locks.DATABASE AND 
    blocking_locks.relation IS NOT DISTINCT FROM blocked_locks.relation AND 
    blocking_locks.page IS NOT DISTINCT FROM blocked_locks.page AND 
    blocking_locks.tuple IS NOT DISTINCT FROM blocked_locks.tuple AND 
    blocking_locks.virtualxid IS NOT DISTINCT FROM blocked_locks.virtualxid AND 
    blocking_locks.transactionid IS NOT DISTINCT FROM blocked_locks.transactionid AND 
    blocking_locks.classid IS NOT DISTINCT FROM blocked_locks.classid AND 
    blocking_locks.objid IS NOT DISTINCT FROM blocked_locks.objid AND 
    blocking_locks.objsubid IS NOT DISTINCT FROM blocked_locks.objsubid AND 
    blocking_locks.pid != blocked_locks.pid JOIN pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid
WHERE 
    NOT blocked_locks.GRANTED;