SELECT
  slot_name,
  slot_type,
  database,
  active,
  active_pid,
  xmin
FROM
  pg_replication_slots
ORDER BY
  age(xmin) DESC;