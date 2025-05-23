-- Problem 2 - Insert
INSERT INTO offerings(name, price, vegan, restaurant_id)
SELECT CONCAT(name, ' costs:'), price, vegan, restaurant_id
FROM offerings
WHERE name LIKE 'Grill%';

-- Problem 3 - Update
UPDATE offerings
SET name = UPPER(name)
WHERE name LIKE '%Pizza%';

-- Problem 4 - Delete
DELETE FROM restaurants
WHERE name LIKE '%fast%' OR type  LIKE '%fast%';

-- Problem 5 - Get all offerings from restaurant
SELECT o.name, o.price FROM offerings o
JOIN restaurants r ON o.restaurant_id = r.id
WHERE r.name = 'Burger Haven'
ORDER BY o.id;

-- Problem 6 - Get all customers without orders
SELECT id, first_name, last_name FROM customers
WHERE id NOT IN (SELECT customer_id FROM orders)
ORDER BY id;

-- Problem 7 - Get all offerings from orders of the customer
SELECT o.id, o.name
FROM customers c
JOIN orders ord ON c.id = ord.customer_id
JOIN orders_offerings oo ON ord.id = oo.order_id
JOIN offerings o ON oo.offering_id = o.id
WHERE c.first_name = 'Sofia' AND c.last_name = 'Sanchez' AND o.vegan = FALSE
ORDER BY o.id ASC;

-- Problem 8 - Get all restaurants with regular customers
SELECT DISTINCT r.id, r.name FROM restaurants r
JOIN offerings o ON r.id = o.restaurant_id
JOIN orders ord ON o.restaurant_id = ord.restaurant_id
JOIN customers c ON ord.customer_id = c.id
WHERE c.regular IS TRUE and o.vegan IS TRUE and ord.priority = 'HIGH'
ORDER BY r.id;

-- Problem 9 - Offering price categories
SELECT name,
(CASE 
   WHEN price <= 10 THEN 'cheap'
   WHEN price between 10 and 25 THEN 'affordable'
   WHEN price > 25 THEN 'expensive'
END) as price_category
FROM offerings
ORDER BY price DESC, name;

-- Problem 10 - Get offerings average price per restaurant
DELIMITER $$
CREATE FUNCTION udf_get_offerings_average_price_per_restaurant(restaurant_name varchar(40))
RETURNS DECIMAL(19,2)
DETERMINISTIC
BEGIN
	DECLARE average_offering_price DECIMAL(19,2);
	   SELECT ROUND(AVG(price), 2) INTO average_offering_price FROM offerings o 
       JOIN restaurants r ON o.restaurant_id = r.id 
       WHERE r.name = restaurant_name;
    RETURN average_offering_price;
END$$

SELECT r.name, udf_get_offerings_average_price_per_restaurant('Burger Haven') as average_offering_price
FROM restaurants r
WHERE r.name = 'Burger Haven';

-- Problem 11 - Update offering prices
DELIMITER $$
CREATE PROCEDURE udp_update_prices(restaurant_type VARCHAR(40))
BEGIN
	UPDATE offerings o
    JOIN restaurants r ON o.restaurant_id = r.id
    SET price = price + 5.00
    WHERE r.type = restaurant_type AND r.non_stop IS TRUE;
END$$

CALL udp_update_prices('buffet');