CREATE TABLE ITEMS (
    Item_id INT AUTO_INCREMENT,
    Item_name VARCHAR(50),
    Price DECIMAL(10, 2),
    Department VARCHAR(50),
    PRIMARY KEY (Item_id)
);

-- Create CUSTOMERS Table
CREATE TABLE CUSTOMERS (
    Customer_id INT AUTO_INCREMENT,
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    Address VARCHAR(100),
    PRIMARY KEY (Customer_id)
);

CREATE TABLE SALES (
    Date DATE,
    Order_id INT,
    Item_id INT,
    Customer_id INT,
    Quantity INT,
    Revenue DECIMAL(10, 2),
    PRIMARY KEY (Order_id),
    FOREIGN KEY (Item_id) REFERENCES ITEMS(Item_id),
    FOREIGN KEY (Customer_id) REFERENCES CUSTOMERS(Customer_id)
);

INSERT INTO CUSTOMERS (First_name, Last_name, Address) VALUES
('John', 'Doe', '123 Maple St, Springfield'),
('Jane', 'Smith', '456 Oak Ave, Metropolis'),
('Alice', 'Johnson', '789 Pine Rd, Gotham'),
('Bob', 'Brown', '101 Elm St, Smallville'),
('John', 'Doe', '102 Cherry Ln, Springfield'); 

INSERT INTO ITEMS (Item_name, Price, Department) VALUES
('Laptop', 1000.00, 'Electronics'),
('Tablet', 500.00, 'Electronics'),
('Office Chair', 150.00, 'Furniture'),
('Desk Lamp', 30.00, 'Furniture'),
('Monitor', 200.00, 'Electronics'),
('Bookshelf', 120.00, 'Furniture');

INSERT INTO SALES (Date, Order_id, Item_id, Customer_id, Quantity, Revenue) VALUES
('2023-03-18', 1, 1, 1, 2, 2000.00),   
('2023-03-18', 2, 2, 5, 1, 500.00),   
('2023-01-15', 3, 3, 2, 3, 450.00),    
('2023-01-20', 4, 4, 3, 4, 120.00),    
('2022-11-10', 5, 5, 4, 3, 600.00),    
('2022-12-25', 6, 6, 1, 2, 240.00),    
('2023-02-14', 7, 1, 2, 1, 1000.00),   
('2023-03-18', 8, 4, 3, 5, 150.00);    

-- Total numbers of orders completed on 18th march 2023
SELECT COUNT(Order_id) AS total_orders
FROM SALES
WHERE Date = '2023-03-18';

-- Total number of orders completed on 18th March 2023 by a customer with the first name 'John' and last name 'Doe':
SELECT COUNT(s.Order_id) AS orders_by_john_doe
FROM SALES s
JOIN CUSTOMERS c ON s.Customer_id = c.Customer_id
WHERE s.Date = '2023-03-18'
  AND c.First_name = 'John'
  AND c.Last_name = 'Doe';

-- Total number of customers who purchased in January 2023 and the average amount spent per customer:
SELECT COUNT(DISTINCT Customer_id) AS total_customers,
       AVG(Revenue) AS avg_spent_per_customer
FROM SALES
WHERE Date BETWEEN '2023-01-01' AND '2023-01-31';

-- Departments that generated less than $600 in revenue in 2022:
SELECT i.Department, SUM(s.Revenue) AS total_revenue
FROM SALES s
JOIN ITEMS i ON s.Item_id = i.Item_id
WHERE s.Date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY i.Department
HAVING total_revenue < 600;

-- Most and least revenue generated by an order:
-- Subquery to find the max and min revenue
WITH RevenueStats AS (
    SELECT MAX(Revenue) AS max_revenue, MIN(Revenue) AS min_revenue
    FROM SALES
)

-- Order details for highest and lowest revenue
SELECT s.Order_id, s.Date, s.Quantity, s.Revenue, 
       c.First_name AS Customer_First_Name, c.Last_name AS Customer_Last_Name, 
       i.Item_name, i.Price, i.Department
FROM SALES s
JOIN CUSTOMERS c ON s.Customer_id = c.Customer_id
JOIN ITEMS i ON s.Item_id = i.Item_id
JOIN RevenueStats rs ON s.Revenue = rs.max_revenue OR s.Revenue = rs.min_revenue;

-- Orders included in most lucrative order
-- Subquery to get the highest revenue
WITH MaxRevenue AS (
    SELECT MAX(Revenue) AS max_revenue
    FROM SALES
)

-- Details for the most lucrative orders
SELECT s.Order_id, s.Date, s.Quantity, s.Revenue,
       c.First_name AS Customer_First_Name, c.Last_name AS Customer_Last_Name,
       i.Item_name, i.Price, i.Department
FROM SALES s
JOIN CUSTOMERS c ON s.Customer_id = c.Customer_id
JOIN ITEMS i ON s.Item_id = i.Item_id
JOIN MaxRevenue mr ON s.Revenue = mr.max_revenue;
