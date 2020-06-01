SELECT 
    locktype,
    relation::regclass, mode, 
    transactionid AS tid,
    virtualtransaction AS vtid, 
    pid, 
    granted
FROM 
    pg_locks l LEFT JOIN 
        pg_database db ON (db.oid = l.database) 
WHERE 
    pid != pg_backend_pid() AND
    db.datname = current_database();