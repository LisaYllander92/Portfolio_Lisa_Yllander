---
title: Explorating sakila database
--- 

<Details title='Information'>

  In this report you will find some of the EDA based on the Sakila database. There are statistcs focusing on film properties, top actors, top movie categorys and customers etc. 
</Details>


## Movies longer than 3 hours
Showing film title and length of the movie in minutes.
```sql film_length
    SELECT title, length as length_in_minutes
    FROM film
    WHERE length > 180
    ORDER BY length DESC
```

## Movies with the word "LOVE" in title
Here you can see which movies has the word "LOVE" in the title, rating of the movie, length and description.
```film_title
    SELECT title, rating, length, description
    FROM film
    WHERE title ILIKE '% love %' 
    OR title ILIKE  'love %'
    OR title ILIKE '% love'
```

## Desctiptive statistics on movies length
Some statistics on length, showing the shortes, average, mean and longest movie. 
```film_statistics
SELECT
    MIN(length) AS Shortest_movie_length,
    ROUND(AVG(length)) AS Average_movie_length,
    MEDIAN(length) AS Median_movie_lenth,
    MAX(length) AS Longest_movie_length
    FROM film
```

## Top 10 most expensive movies to rent per day
```rental_rate
SELECT title, 
    rental_rate,
    rental_duration,
    (rental_rate/rental_duration) AS rental_cost_per_day
    FROM film
    ORDER BY rental_cost_per_day DESC
    LIMIT 10
```

## Top 10 actors played in most movies
Showing how many films each actor has been in.
```actors
SELECT actor,
COUNT(film_id) as number_films
FROM actors
GROUP BY actor
ORDER BY number_films DESC
LIMIT 10
```

## Top 5 most rented movie categorys
```top_categorys
    SELECT
        category,
         ROUND(((CAST(COUNT(rental_id) AS DOUBLE) * 100.0) / (
             SELECT
                 COUNT(rental_id)
             FROM
                 rental)), 2) AS percentage_rental
    FROM categories
    GROUP BY category
    ORDER BY percentage_rental DESC
    LIMIT 5
```

## Analyzing rental hours
Here I wanted to show what time of day is the most busy by dividing the time of day into categories and also visualize this with a linechart. 
```sql rental
from rent
```

<Dropdown
data={rental} 
name=selected_time
value=time_of_day
title="Time of day:"
defaultValue="Morning (06-11)">
</Dropdown>

```sql rental_time
SELECT
    rental_hour AS rental_time,
    total_rentals
FROM rent
WHERE time_of_day = '${inputs.selected_time.value}'
ORDER BY rental_hour
```

<LineChart
    data={rental_time}
    x=rental_time
    y=total_rentals
    title={`Rentals per hour: ${inputs.selected_time.value}`}
/>

## Top customers
These customers are the top 5 who`s spent most money on renting films from our store. 
```top_customers
    SELECT 
        customer,
        SUM(amount) AS total_spent_USD
    FROM customers
    GROUP BY customer
    ORDER BY total_spent_USD DESC
    LIMIT 5
```
<BarChart
    data={top_customers}
    x=customer
    y=total_spent_USD
/>

## Most profitable film category
Categories and how must money they bring in. This also shows which genres are the most populare among customers. 
```film_category
    SELECT
        category,
        ROUND(SUM(amount)) as total_revenue
    FROM film_category
    GROUP BY category
    ORDER BY total_revenue DESC
```

<BarChart
data={film_category}
x=category
y=total_revenue
/>
