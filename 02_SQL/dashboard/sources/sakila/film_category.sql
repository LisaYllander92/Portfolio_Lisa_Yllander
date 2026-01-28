    SELECT
        c.name AS category,
        p.amount AS amount
    FROM staging.category c
    INNER JOIN staging.film_category fc ON fc.category_id = c.category_id
    INNER JOIN staging.film f ON f.film_id = fc.film_id
    INNER JOIN staging.inventory i ON i.film_id = f.film_id
    INNER JOIN staging.rental r ON r.inventory_id = i.inventory_id
    INNER JOIN staging.payment p ON p.rental_id = r.rental_id;
