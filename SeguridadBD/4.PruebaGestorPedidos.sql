USE [Northwind]
GO

/****** Object:  User [Gestor]    Script Date: 14/4/2022 09:57:08 ******/
CREATE USER [Gestor] FOR LOGIN [LoginVentas] WITH DEFAULT_SCHEMA=[dbo]
GO

--Como prueba podemos observar como podemos seleccionar productos y empleados porque se dio el permiso a gestor.
--Pero no se puede seleccionar categoria debido a que no se le dio permiso, no esta relacionado directamente con los pedidos o ordenes.
--Al ingresar con usuario Gestor se puede observar que solo tenemos disponibles las tablas requeridas puesto... 
--que se asignaron permisos al role GestionarPedidos.
select * from Product.Products
select * from Person.Employees
select * from Product.Categories
