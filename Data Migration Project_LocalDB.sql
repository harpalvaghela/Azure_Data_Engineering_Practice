Drop table IF EXISTS Suppliers
Drop table IF EXISTS Products
Drop table IF EXISTS Employee
Drop table IF EXISTS Sales
Drop table IF EXISTS Inventory_Logs 
DROP TABLE IF EXISTS WATERMARK

-----------SCD Type 1--------------
CREATE TABLE Suppliers (
    supplier_id INT, 
    name VARCHAR(255),
    contact_name VARCHAR(255),
    phone VARCHAR(50),
    address Varchar(100),
	supplierUpdatedDate datetime -------------Delta Column
);

CREATE TABLE Products (
    product_id INT,  
    name VARCHAR(255),
    category VARCHAR(100),
    price DECIMAL(10, 2),
    stock INT,
    supplier_id INT,
	productUpdatedDate datetime ------------Delta Column
);

-----------SCD Type 2--------------
CREATE TABLE Employee (
    employee_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    hire_date DATETIME,
    last_review_date DATETIME,  ----------------Delta Column
    role VARCHAR(100)
);

CREATE TABLE Sales (
    sale_id INT,
    sale_date DATETIME,     
    product_id INT,
    quantity INT,
    total_amount DECIMAL(10, 2),
    cashier_id INT,
	salesUpdatedDate datetime  -------------------Delta Column
);

CREATE TABLE Inventory_Logs (
    log_id INT,
    product_id INT,
    log_updatedDate DATETIME,    ---------------------Delta Column
    change_quantity INT,
    remaining_stock INT
);

----Insert data into Supplier Table 
INSERT INTO Suppliers (supplier_id, name, contact_name, phone, address, supplierUpdatedDate) VALUES
(1, 'Fresh Farms', 'John Doe', '555-3489', '123 Farm Lane', '2023-11-11 00:00:00'),
(2, 'Healthy Beverages Co.', 'Emily Stone', '555-7623', '47 Beverage Blvd','2023-11-11 00:00:00'),
(3, 'Premium Meats', 'Alan Smith', '555-9876', '233 Meat St', '2023-11-11 00:00:00');

----Insert data into Products Table
INSERT INTO Products (product_id, name, category, price, stock, supplier_id, productUpdatedDate) VALUES
(1, 'Organic Apples', 'Fruits', 2.99, 150, 1, '2023-09-25 00:00:00'),
(2, 'Almond Milk', 'Beverages', 3.49, 85, 2, '2023-09-24 00:00:00'),
(3, 'Chicken Breast', 'Meat', 7.99, 60, 3, '2023-09-23 00:00:00');

----Insert data into Employee Table
INSERT INTO Employee (employee_id, first_name, last_name, hire_date, last_review_date, role) VALUES
(1, 'Raj', 'Sharma', '2022-01-05 09:00:00', '2023-09-10 00:00:00', 'Cashier'),
(2, 'Harpal', 'Vaghela', '2022-05-15 09:00:00', '2023-09-20 00:00:00', 'Cashier'),
(3, 'Amit', 'Singh', '2023-03-23 09:00:00', '2023-09-30 00:00:00', 'Stock Manager');

----Insert data into Sales Table
INSERT INTO Sales (sale_id, sale_date, product_id, quantity, total_amount, cashier_id, salesUpdatedDate) VALUES
(1, '2023-10-01 14:00:00', 1, 10, 29.90, 1,'2023-10-01 14:02:00'),
(2, '2023-10-01 14:15:00', 2, 5, 17.45, 2, '2023-10-01 14:17:00'),
(3, '2023-10-01 15:00:00', 3, 4, 31.96, 1, '2023-10-01 15:02:00');

----Insert data into Inventory_Logs Table
INSERT INTO Inventory_Logs (log_id, product_id, log_updatedDate, change_quantity, remaining_stock) VALUES
(1, 1, '2023-10-01 08:00:00', 20, 170),
(2, 2, '2023-10-01 09:00:00', -10, 75),
(3, 3, '2023-10-01 10:00:00', 30, 90);


DROP TABLE IF EXISTS WATERMARK

CREATE TABLE dbo.WATERMARK(
	ID INT IDENTITY(1,1),
	TABLE_NAME VARCHAR(100),
	SCHEMA_NAME  VARCHAR(100),
	FOLDER_NAME VARCHAR(100),
	LPV VARCHAR(100),
	DELTA_COLUMN VARCHAR(100),
	TABLE_TYPE VARCHAR(100)
)


Select * From WATERMARK

----------------------------------TableName--SchemaName----FolderName--------LPV--------------------DeltaColumn-----Table Type------
INSERT INTO dbo.WATERMARK VALUES ('Products', 'dbo', 'RetailDB/Products', '1900-01-01 00:00:00', 'productUpdatedDate', 'INCREMENTAL');
INSERT INTO dbo.WATERMARK VALUES ('Sales', 'dbo', 'RetailDB/Sales', '1900-01-01 00:00:00', 'salesUpdatedDate', 'INCREMENTAL');
INSERT INTO dbo.WATERMARK VALUES ('Employee', 'dbo', 'RetailDB/Employee', '1900-01-01 00:00:00', 'last_review_date', 'SCDTYPE2');
INSERT INTO dbo.WATERMARK VALUES ('Suppliers', 'dbo', 'RetailDB/Suppliers','1900-01-01 00:00:00', 'supplierUpdatedDate','SCDTYPE1');
INSERT INTO dbo.WATERMARK VALUES ('Inventory_Logs', 'dbo', 'RetailDB/InventoryLogs', '1900-01-01 00:00:00', 'log_updatedDate', 'INCREMENTAL');

----------------------------------------------------------------------------------------------------
----Insert new data into Products table
INSERT INTO Products (product_id, name, category, price, stock, supplier_id, productUpdatedDate) VALUES
(4, 'Vegetable Oil', 'Groceries', 4.50, 100, 2, '2023-12-01 00:00:00');

----Insert new data into Sales table
INSERT INTO Sales (sale_id, sale_date, product_id, quantity, total_amount, cashier_id, salesUpdatedDate) VALUES
(4, '2025-02-25 10:30:00', 5, 20, 90.00, 1, '2025-02-25 10:35:00');


----Insert new data into Suppliers table --- SCD Type 1
INSERT INTO Suppliers (supplier_id, name, contact_name, phone, address, supplierUpdatedDate) VALUES
(4, 'Bakers Delight', 'Nora Special Bates', '111-1111', '88 Baker Rd', '2025-02-22 00:00:00');


----Insert new data into Employees table ---- SCD Type 2
INSERT INTO Employee (employee_id, first_name, last_name, hire_date, last_review_date, role) VALUES
(4, 'Nayan', 'Vaghela', '2025-01-01 09:00:00', '2025-02-20 00:00:00', 'Inventory Specialist');




------------------------------------------------------------------------------------------------------------


----Insert new data into Suppliers table --- SCD Type 1 -- 2nd Round
INSERT INTO Suppliers (supplier_id, name, contact_name, phone, address, supplierUpdatedDate) VALUES
(4, 'Bakers Magic Delight', 'Nora Magic Bates', '555-2222', '88 Baker Rd', '2025-02-23 00:00:00');

----Update Employee Table
Update Employee
Set first_name = 'Nayansinh', last_name = 'Patel', role = 'Inventory Manager', last_review_date = '2025-02-27 00:00:00'
Where employee_id = 4;


------------------------------------
Select * From WATERMARK
Select * From Suppliers
Select * From Products
Select * From Employee
Select * From Sales
Select * From Inventory_Logs


-----------Stored Procedure----------

CREATE PROC USP_WATERMARK_UPDATE 
@Table_Name VARCHAR(100),
@LPV_Value VARCHAR(50)
AS
UPDATE WATERMARK
SET LPV = @LPV_Value
WHERE TABLE_NAME = @Table_Name