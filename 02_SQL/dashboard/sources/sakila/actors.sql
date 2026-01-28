SELECT
     a.first_name || ' ' || a.last_name as actor,
     f.film_id,
     f.title,
     f.description,
     f.length,
     f.rating,
     f.rental_rate,
     f.rental_duration
 FROM staging.actor a
 LEFT JOIN staging.film_actor fa ON fa.actor_id = a.actor_id 
 LEFT JOIN staging.film f ON f.film_id = fa.film_id;