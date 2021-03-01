USE Northwind
SELECT companyname, address
FROM Customers
GO
USE Northwind
SELECT lastname, homephone
FROM Employees
GO
USE Northwind
SELECT productname, unitprice
FROM Products
GO
USE Northwind
SELECT categoryname, description
FROM Categories
GO
USE Northwind
SELECT companyname, homepage
FROM Suppliers
GO
USE Northwind
SELECT companyname, address
FROM Customers
WHERE city = 'London'
GO
SELECT companyname, address
FROM Customers
WHERE country = 'France' OR country='Spain'
GO
USE Northwind
SELECT productname, unitprice
FROM Products
WHERE UnitPrice BETWEEN 20.00 AND 30.00
GO
USE Northwind
SELECT categoryid
FROM Categories
WHERE Categoryname='meat/poultry'
GO
USE Northwind
SELECT productname, unitprice
FROM products
WHERE categoryid='6'
GO
USE Northwind
SELECT supplierid
FROM Suppliers
WHERE companyname='Tokyo Traders'
GO
USE Northwind
SELECT productname, unitsinstock
FROM products
WHERE supplierid='4'
GO
USE Northwind
SELECT productname
FROM products
WHERE unitsinstock='0'
GO
USE Northwind
SELECT productname
FROM products
WHERE quantityperunit LIKE '%bottle%'
GO
USE Northwind
SELECT lastname, title
FROM Employees
WHERE lastname LIKE '[B-L]%'
GO
USE Northwind
SELECT lastname, title
FROM Employees
WHERE lastname LIKE '[BL]%'
GO
USE Northwind
SELECT categoryname, description
FROM Categories
WHERE description LIKE '%,%'
GO
USE Northwind
SELECT companyname
FROM customers
WHERE companyname LIKE '%Store%'
GO
USE northwind
SELECT productname, unitprice
FROM products
WHERE unitprice>=10 AND unitprice<=20
GO
USE northwind
SELECT productname, unitprice
FROM products
WHERE unitprice<10 OR unitprice>20
GO
USE northwind
SELECT productname, unitprice
FROM products
WHERE unitprice BETWEEN 20.00 AND 30.00
GO

USE northwind
SELECT companyname, country
FROM customers
WHERE country IN ('Japan' , 'Italy')
GO
USE northwind
SELECT orderid, orderdate, customerid
FROM orders
WHERE shippeddate=NULL AND shipcountry='Argentina'
GO
USE northwind
SELECT companyname, country
FROM customers
ORDER BY country, companyname
GO
USE Northwind
SELECT categoryid, productname, unitprice
FROM products
ORDER BY categoryid, unitprice DESC
GO
USE Northwind
SELECT companyname, country
FROM customers
WHERE country IN ('Japan', 'Italy')
ORDER BY country, companyname
GO
