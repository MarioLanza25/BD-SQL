--Considere un escenario donde se necesita crear un acceso para realizar operaciones de gestión
--de pedidos
use master
go
create login LoginVentas with password = 'ventas123'

use Northwind
go
create user Gestor from login LoginVentas

--Crear role con permisos necesarios para gestionar orders y orderDetails
use Northwind
go
create role GestionarPedidos
go
grant select, insert, update, delete on Sales.Orders to GestionarPedidos
grant select, insert, update, delete on Sales.OrderDetails to GestionarPedidos
grant select on Product.Products to GestionarPedidos
grant select on Customer.Customers to GestionarPedidos
grant select on Person.Employees to GestionarPedidos
grant select on Supplier.Shippers to GestionarPedidos

--Asignar role al gestor solo para gestionar pedidos
sp_addrolemember GestionarPedidos, Gestor
