-- Wait events 
SELECT 
    wait_event,
    count(*)
FROM 
    pg_stat_activity
WHERE
    wait_event != null 
GROUP BY
    wait_event;