CREATE DATABASE Ecommerce;
use [Ecommerce];

CREATE TABLE customers
(
	 customer_id INT PRIMARY KEY,
	 firstName VARCHAR(30),
	 lastName VARCHAR(30),
	 email VARCHAR(30),
	 address VARCHAR(50)
);

INSERT INTO customers
VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '123 Main St, City'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '456 Elm St, Town'),
(3, 'Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb'),
(5, 'David', 'Lee', 'david@example.com', '234 Cedar St, District'),
(6, 'Laura', 'Hall', 'laura@example.com', '567 Birch St, County'),
(7, 'Michael', 'Davis', 'michael@example.com', '890 Maple St, State'),
(8, 'Emma', 'Wilson', 'emma@example.com', '321 Redwood St, Country'),
(9, 'William', 'Taylor', 'william@example.com', '432 Spruce St, Province'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '765 Fir St, Territory')SELECT * FROM products;CREATE TABLE products(	product_id INT PRIMARY KEY,	name VARCHAR(30),	description VARCHAR(100),	price FLOAT(2),	stockQuantity INT);INSERT INTO products
VALUES
(1, 'Laptop', 'High-performance laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);SELECT * FROM products;CREATE TABLE cart(	cart_id INT PRIMARY KEY,	customer_id INT FOREIGN KEY (customer_id) REFERENCES customers(customer_id),	product_id INT FOREIGN KEY (product_id)REFERENCES products(product_id),	quantity INT);INSERT INTO cartVALUES(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2)SELECT * FROM cart;CREATE TABLE orders(	order_id INT PRIMARY KEY,	customer_id INT FOREIGN KEY (customer_id) REFERENCES customers(customer_id),	order_date DATE,	total_amount FLOAT(2));INSERT INTO orders
VALUES
(1, 1, '2023-01-05', 1200.00),
(2, 2, '2023-02-10', 900.00),
(3, 3, '2023-03-15', 300.00),
(4, 4, '2023-04-20', 150.00),
(5, 5, '2023-05-25', 1800.00),
(6, 6, '2023-06-30', 400.00),
(7, 7, '2023-07-05', 700.00),
(8, 8, '2023-08-10', 160.00),
(9, 9, '2023-09-15', 140.00),
(10, 10, '2023-10-20', 1400.00);SELECT * FROM orders;CREATE TABLE order_items(	order_item_id INT PRIMARY KEY,	order_id INT FOREIGN KEY (order_id) REFERENCES orders(order_id),	product_id INT FOREIGN KEY (product_id) REFERENCES products(product_id),	quantity INT,	item_amount FLOAT(2));INSERT INTO order_itemsVALUES(1, 1, 1, 2, 1600.00),(2, 1, 3, 1, 300.00),
(3, 2, 2, 3, 1800.00),(4, 3, 5, 2, 1800.00),
(5, 4, 4, 4, 600.00),
(6, 4, 6, 1, 50.00),
(7, 5, 1, 1, 800.00),
(8, 5, 2, 2, 1200.00),
(9, 6, 10, 2, 240.00),
(10, 6, 9, 3, 210.00)SELECT * FROM order_items;--Q1UPDATE productsSET price = 800WHERE name = 'Refrigerator';--Q2DELETE  FROM cartWHERE customer_id = 3;--Q3SELECT * FROM productsWHERE price < 100;--Q4SELECT * FROM productsWHERE stockQuantity > 5;--Q5SELECT * FROM ordersWHERE total_amount >500 AND total_amount < 1000;--Q6SELECT * FROM productsWHERE name LIKE '%r';--Q7SELECT * FROM cartWHERE  customer_id = 5;--Q8SELECT firstName,lastName  FROM customers cINNER JOIN orders o ON c.customer_id = o.customer_idWHERE YEAR(order_date) = 2023;--Q9SELECT product_id, name, MIN(stockQuantity) AS MinStockQuantity
FROM products
GROUP BY product_id, name;--Q10SELECT firstName, lastName, o.total_amount  FROM customers cJOIN orders o ON c.customer_id = o.customer_id;--Q11SELECT firstName, lastName, AVG(total_amount)  FROM customers cJOIN orders o ON c.customer_id = o.customer_idGROUP BY firstName, lastName;--Q12SELECT c.firstName, c.lastName, COUNT(order_id) FROM customers cJOIN orders o ON c.customer_id = o.customer_idGROUP BY c.firstName, c.lastName;--Q13SELECT c.firstName, c.lastName, MAX(total_amount) FROM customers cJOIN orders o ON c.customer_id = o.customer_idGROUP BY c.firstName, c.lastName; --Q14SELECT c.firstName, c.lastName, total_amount FROM customers cJOIN orders o ON c.customer_id = o.customer_idWHERE total_amount > 1000;--Q15SELECT name FROM productsWHERE product_id NOT IN(	SELECT c.product_id FROM cart c);--Q16SELECT firstName, lastName FROM customersWHERE customer_id NOT IN(	SELECT o.customer_id FROM orders o)--Q17SELECT  o.product_id, name, (SUM(item_amount) / (SELECT  SUM(o.item_amount) FROM order_items)) * 100 AS PercentageOfTotalRevenue
FROM order_items o
JOIN products p ON o.product_id = p.product_id
GROUP BY o.product_id, name;

--Q18
SELECT product_id, name, stockQuantity FROM products
WHERE StockQuantity < (
        SELECT AVG(StockQuantity) - 1 * STDEV(StockQuantity) FROM products
);

--Q19
SELECT c.customer_id, c.firstName FROM customers c
WHERE c.customer_id IN (
        SELECT o.customer_id FROM orders o
        JOIN  order_items oi ON o.order_id = oi.order_id
        GROUP BY o.customer_id
        HAVING SUM(o.total_amount) > 1000  
);