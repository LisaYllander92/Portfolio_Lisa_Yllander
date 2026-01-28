SELECT
    c.first_name || ' ' || c.last_name AS customer,
    p.amount as amount
FROM staging.rental r
LEFT JOIN staging.payment p ON p.rental_id = r.rental_id
LEFT JOIN staging.customer c ON c.customer_id = r.customer_id;
