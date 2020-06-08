SELECT
  datname,
  usename,
  pid,
  state,
  wait_event,
  current_timestamp - xact_start AS xact_runtime,
  query
FROM
  pg_stat_activity
WHERE
  upper(query) LIKE '%VACUUM%' AND
  pid != pg_backend_pid()
ORDER BY
  xact_start;