SELECT
  SUBSTRING(query, 1, 50) AS query_snippet,
  calls,
  interval '1 millisecond' * total_time AS total_time,
  interval '1 millisecond' * mean_time AS mean,
  ROUND((100 * total_time / sum(total_time::numeric) OVER ())::numeric, 2) AS percentage_cpu
FROM
  pg_stat_statements
ORDER BY 
  total_time DESC
LIMIT 10;