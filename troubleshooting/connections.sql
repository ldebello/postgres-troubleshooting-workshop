SELECT
  client_addr,
  COUNT(client_addr)
FROM
  pg_stat_activity
GROUP BY
  client_addr
ORDER BY
  COUNT;