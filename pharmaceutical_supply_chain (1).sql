
-- Drop tables if they exist
DROP TABLE IF EXISTS Suppliers;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Shipments;

-- Create Suppliers table
CREATE TABLE Suppliers (
    supplier_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    contact_info TEXT
);

-- Create Customers table
CREATE TABLE Customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT
);

-- Create Products table
CREATE TABLE Products (
    product_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    supplier_id INTEGER,
    price REAL,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    product_id INTEGER,
    customer_id INTEGER,
    quantity INTEGER,
    order_date TEXT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create Shipments table
CREATE TABLE Shipments (
    shipment_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    shipment_date TEXT,
    delivery_date TEXT,
    status TEXT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Insert sample data into Suppliers table
INSERT INTO Suppliers (supplier_id, name, contact_info) VALUES
(1, 'PharmaCorp', 'contact@pharmacorp.com'),
(2, 'MediLife', 'support@medilife.com');

-- Insert sample data into Customers table
INSERT INTO Customers (customer_id, name, address) VALUES
(1, 'City Hospital', '123 Main St, Metropolis'),
(2, 'Green Clinic', '456 Elm St, Smallville');

-- Insert sample data into Products table
INSERT INTO Products (product_id, name, supplier_id, price) VALUES
(1, 'Aspirin', 1, 0.10),
(2, 'Paracetamol', 2, 0.20);

-- Insert sample data into Orders table
INSERT INTO Orders (order_id, product_id, customer_id, quantity, order_date) VALUES
(1, 1, 1, 1000, '2025-04-20'),
(2, 2, 2, 500, '2025-04-21');

-- Insert sample data into Shipments table
INSERT INTO Shipments (shipment_id, order_id, shipment_date, delivery_date, status) VALUES
(1, 1, '2025-04-21', '2025-04-23', 'Delivered'),
(2, 2, '2025-04-22', '2025-04-24', 'In Transit');

-- Sample Queries
-- List all products with their supplier names
SELECT Products.name AS Product, Suppliers.name AS Supplier
FROM Products
JOIN Suppliers ON Products.supplier_id = Suppliers.supplier_id;

-- List all orders with customer and product names
SELECT Orders.order_id, Customers.name AS Customer, Products.name AS Product, Orders.quantity
FROM Orders
JOIN Customers ON Orders.customer_id = Customers.customer_id
JOIN Products ON Orders.product_id = Products.product_id;

-- List all shipments with their order and status
SELECT Shipments.shipment_id, Orders.order_id, shipment_date, delivery_date, status
FROM Shipments
JOIN Orders ON Shipments.order_id = Orders.order_id;
