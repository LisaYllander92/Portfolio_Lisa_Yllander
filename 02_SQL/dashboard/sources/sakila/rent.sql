SELECT
    EXTRACT(HOUR FROM rental_date) AS rental_hour,
    CASE
    WHEN EXTRACT(HOUR FROM rental_date) BETWEEN 6 AND 11 THEN 'Morning (06-11)'
    WHEN EXTRACT(HOUR FROM rental_date) BETWEEN 12 AND 16 THEN 'Daytime (12-16)'
    WHEN EXTRACT(HOUR FROM rental_date) BETWEEN 17 AND 21 THEN 'Evening (17-21)'
    ELSE 'Nighttime (22-05)'
    END AS time_of_day,
        
    COUNT(rental_id) AS total_rentals
FROM staging.rental
GROUP BY time_of_day, rental_hour
ORDER BY rental_hour;
