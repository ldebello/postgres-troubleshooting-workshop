SELECT
  activity.pid,
  activity.usename,
  activity.query,
  blocking.pid AS blocking_id,
  blocking.state AS blocking_state,
  blocking.query AS blocking_query
FROM 
  pg_stat_activity AS activity JOIN 
    pg_stat_activity AS blocking ON blocking.pid = ANY(pg_blocking_pids(activity.pid));