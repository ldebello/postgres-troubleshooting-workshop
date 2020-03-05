SELECT 
    client_addr,count(client_addr)
FROM
    pg_stat_ssl JOIN pg_stat_activity ON 
        pg_stat_ssl.pid = pg_stat_activity.pid
GROUP BY
    client_addr
ORDER BY 
    count;