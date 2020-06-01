SELECT 
    pid, 
    wait_event_type, 
    wait_event 
FROM 
    pg_stat_activity 
WHERE 
    wait_event is NOT NULL;