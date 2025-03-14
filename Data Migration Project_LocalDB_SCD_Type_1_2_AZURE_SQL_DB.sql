Select * From tbl_Products
Select * From tbl_Sales
Select * From tbl_Inventory_Logs

TRUNCATE TABLE tbl_Products
TRUNCATE TABLE tbl_Sales
TRUNCATE TABLE tbl_Inventory_Logs

drop table IF EXISTS tbl_Products
drop table IF EXISTS tbl_Sales
drop table IF EXISTS tbl_Inventory_Logs

-------SCD Type 1 Table ----------------

CREATE TABLE tbl_Suppliers (
    supplier_id INT,
    name VARCHAR(255),
    contact_name VARCHAR(255),
    phone VARCHAR(50),
    address Varchar(100),
	createdBy varchar(100), 
	createdDate datetime, 
	updatedBy varchar(100), 
	updatedDate datetime, 
	hashKey Bigint
);

--TRUNCATE TABLE tbl_Suppliers
Select * from tbl_Suppliers

--Target Source Query in Dataflow SCD Type 1
Select supplier_id, hashKey from tbl_Suppliers;

--DROP TABLE IF EXISTS tbl_Suppliers
--DROP TABLE IF EXISTS tbl_Employee
-------SCD Type 2 Table ----------------

CREATE TABLE tbl_Employee (
employee_id INT,
first_name VARCHAR(255),
last_name VARCHAR(255),
hire_date DATETIME,
last_review_date DATETIME, 
role VARCHAR(100),
CREATEDBY VARCHAR(100), 
CREATEDDATE DATETIME,
UPDATEDBY VARCHAR(100), 
UPDATEDDATE DATETIME, 
HASHKEY BIGINT, 
ISACTIVE INT
);

--TRUNCATE TABLE tbl_Employee
Select * from tbl_Employee

--Target Source Query in Dataflow SCD Type 2
Select employee_id, HASHKEY from tbl_Employee where ISACTIVE = 1

----------Delete records from tables SCD Type 1 and 2---------------
TRUNCATE TABLE tbl_Suppliers
TRUNCATE TABLE tbl_Employee


---------3 Tables-----------
Select * From tbl_Products
Select * From tbl_Sales
Select * From tbl_Inventory_Logs

----Both Tables-------------
Select * from tbl_Suppliers order by 1
Select * from tbl_Employee order by 1


CREATE TABLE tbl_Products (
    product_id INT,  
    name VARCHAR(255),
    category VARCHAR(100),
    price DECIMAL(10, 2),
    stock INT,
    supplier_id INT,
	productUpdatedDate datetime 
);

CREATE TABLE tbl_Sales (
    sale_id INT,
    sale_date DATETIME,     
    product_id INT,
    quantity INT,
    total_amount DECIMAL(10, 2),
    cashier_id INT,
	salesUpdatedDate datetime  
);

CREATE TABLE tbl_Inventory_Logs (
    log_id INT,
    product_id INT,
    log_updatedDate DATETIME,   
    change_quantity INT,
    remaining_stock INT
);