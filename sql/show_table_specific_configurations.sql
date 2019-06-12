-- Muestra las tablas que tenga configurados parametros de forma especifica
SELECT 
    reloptions 
FROM 
    pg_class 
WHERE 
    reloptions != null;