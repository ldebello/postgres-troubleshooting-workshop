SELECT 
    reloptions 
FROM 
    pg_class 
WHERE 
    reloptions != null;