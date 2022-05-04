use master

--restore database Northwind from disk = 'C:\northwind.bak'
--WITH  FILE = 1, 
--MOVE N'northwind' 
--TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\northwind.mdf',  
--MOVE N'northwind_log' 
--TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\northwind_log.ldf',  
--NOUNLOAD,  STATS = 5

restore database Northwind from disk = 'C:\northwind.bak' with replace

use Northwind

sp_helpdb Northwind

--Visualizar usuarios huerfanos
SELECT dp.type_desc, dp.sid, dp.name AS user_name  
FROM sys.database_principals AS dp  
LEFT JOIN sys.server_principals AS sp  
    ON dp.sid = sp.sid  
WHERE sp.sid IS NULL  
    AND dp.authentication_type_desc = 'INSTANCE';  

--use master
--go
--create login Creador with password ='12345'
--go
--use Northwind
--go
--Exec sp_adduser Creador, creador
--go
--grant create table to creador
--grant create view to creador
--grant create procedure to creador

--Esquema define el ambito de un objeto en una BD

--use Northwind
--create table creador.persona(id int)

--select * from creador.persona

--sp_helprotect null, creador

--user master
--go
--create login AdminNorthwind With password ='12345'
--go
--execute sp_adduser 'AdminNorthwind', ''


--crear esquema por defecto creador venta
--sp_adduser 'Creador', 'creadorVenta'

--Creacion de esquemas
create schema Sales authorization dbo
create schema Customer authorization dbo
create schema Supplier authorization dbo
create schema Product authorization dbo
create schema Person authorization dbo
create schema Proceds authorization dbo

--Tramsferir o mover a esquema sale
Alter schema Sales
 Transfer dbo.Orders

Alter schema Sales
 Transfer dbo.OrderDetails

--Tramsferir o mover a esquema Customer
Alter schema Customer
 Transfer dbo.Customers

Alter schema Customer
 Transfer dbo.CustomerCustomerDemo

Alter schema Customer
Transfer dbo.CustomerDemographics

--Tramsferir o mover a esquema Supplier
Alter schema Supplier
 Transfer dbo.Suppliers

Alter schema Supplier
 Transfer dbo.Shippers

Alter Schema Supplier
 Transfer dbo.Territories

Alter schema Supplier
 Transfer dbo.Region

--Tramsferir o mover a esquema Product
Alter Schema Product
 Transfer dbo.Products

Alter schema Product
 Transfer dbo.Categories

--Tramsferir o mover a esquema Person
Alter Schema Person
 Transfer dbo.Employees

Alter schema Person
 Transfer dbo.EmployeeTerritories

--Transferir a esquema Procedures
Alter schema Proceds
 Transfer dbo.CustOrderHist

Alter schema Proceds
 Transfer dbo.CustOrdersDetail
 
Alter schema Proceds
 Transfer dbo.CustOrdersOrders

Alter schema Proceds
 Transfer dbo.EmployeeSalesbyCountry

Alter schema Proceds
 Transfer dbo.SalesbyYear

Alter schema Proceds
 Transfer dbo.SalesByCategory

Alter schema Proceds
 Transfer dbo.TenMostExpensiveProducts


