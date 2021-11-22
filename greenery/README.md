### Short answer questions

1. How many users do we have?
> 130
```
SELECT COUNT(DISTINCT user_id) AS distinct_user_cnt
FROM tnakamoto.stg_users;
```

2. On average, how many orders do we receive per hour?
> 8.125
```
WITH hourly_orders AS (
    SELECT date_trunc('hour', created_at) AS order_hr,
        COUNT(order_id) AS order_id_cnt,
        COUNT(DISTINCT order_id) AS order_id_cntd
    FROM tnakamoto.stg_orders
    WHERE created_at IS NOT NULL
    GROUP BY order_hr
)
SELECT AVG(order_id_cnt) AS avg_order_cnt,
    AVG(order_id_cntd) AS avg_order_cntd
FROM hourly_orders;
```

3. On average, how long does an order take from being placed to being delivered?
> {"days": 3, "hours": 22, "minutes": 13, "seconds": 10, "milliseconds": 504.451}
```
WITH delivery_time AS (
    SELECT AGE(delivered_at, created_at) AS difference,
        EXTRACT(
            EPOCH
            FROM AGE(delivered_at, created_at)
        ) AS difference_seconds
    FROM tnakamoto.stg_orders
    WHERE created_at IS NOT NULL
        AND delivered_at IS NOT NULL
)
SELECT AVG(difference) AS delivery_time_avg,
    AVG(difference_seconds) AS delivery_time_avg_seconds
FROM delivery_time;
```
4. How many users have only made one purchase? Two purchases? Three+ purchases?
> two	22	
three or more	81	
one	25
```
WITH user_order_cnt AS (
    SELECT user_id,
        COUNT(order_id) as order_cnt,
        CASE
            WHEN COUNT(order_id) = 1 THEN 'one'
            WHEN COUNT(order_id) = 2 then 'two'
            WHEN COUNT(order_id) > 2 then 'three or more'
        END AS bucket
    FROM tnakamoto.stg_orders
    GROUP BY user_id
)
SELECT bucket,
    COUNT(*)
FROM user_order_cnt
GROUP BY bucket;
```
1. On average, how many unique sessions do we have per hour?
> 7.389
```
SELECT ROUND(AVG(hourly_sessions.session_cntd), 3) AS hourly_unique_sessions
FROM (
        SELECT date_trunc('hour', created_at) AS event_hour,
            COUNT(DISTINCT session_id) as session_cntd
        from tnakamoto.stg_events
        GROUP BY event_hour
    ) hourly_sessions;
```