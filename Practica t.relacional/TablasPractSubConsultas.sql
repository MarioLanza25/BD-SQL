create database CompGuia

use CompGuia

create table Pais(
Id_Pais int identity(1,1) primary key not null,
NombrePais nvarchar(25),
)

create table Ciudades(
Id_Ciudad int identity(1,1) primary key not null,
NombreCiudad nvarchar(25),
Id_Pais int foreign key references Pais(Id_Pais)
)

create table Clientes(
Id_Cliente char(3) primary key not null,
PN nvarchar(25),
SN nvarchar(25),
PA nvarchar(25),
SA nvarchar(25),
DircCl nvarchar(35),
SaldoI float,
SaldoA float,
Id_Pais int foreign key references Pais(Id_Pais)
)

create table Jefe(
Id_Jefe char(2) primary key not null,
Nombre_J nvarchar(25),
TipoCargo nvarchar(25)
)

create table Vendedor(
Id_V char(2) primary key not null,
Nombre_V nvarchar(25),
Id_Ciudad int foreign key references Ciudades(Id_Ciudad),
cantv int,
comision float,
Id_Jefe char(2) foreign key references Jefe(Id_Jefe)
)

create table Fabricante(
Id_Fab char(3) primary key not null,
Nombre_Fab nvarchar(25),
Dirc_Dom nvarchar(35),
Id_Ciudad int foreign key references Ciudades(Id_Ciudad),
Id_Pais int foreign key references Pais(Id_Pais)
)

create table Compra(
Id_Compra int identity(1,1) primary key not null,
FechaC date default getdate(),
Id_Fab char(3) foreign key references Fabricante(Id_Fab),
totalC float
)

create table Producto(
CodProd char(5) primary key not null,
NProd nvarchar(25),
DescP nvarchar(35),
Id_Fab char(3) foreign key references Fabricante(Id_Fab),
exist int,
pc float,
Id_Compra int foreign key references Compra(Id_Compra)
)

create table DetVenta(
FVenta date default getdate(),
Id_Cliente char(3) foreign key references Clientes(Id_Cliente),
Id_V char(2) foreign key references Vendedor(Id_V),
CodProd char(5) foreign key references Producto(CodProd),
cantV int,
totalV float,
primary key(Id_Cliente, CodProd)
)

create table DetCompra(
Id_Compra int foreign key references Compra(Id_Compra),
CodProd char(5) foreign key references Producto(CodProd),
cantC int,
precioC float,
stc float,
primary key(Id_Compra, CodProd)
)

insert into pais values ('USA'), ('Japon'), ('Belgica'), ('B.A')
select * from pais
insert into Ciudades values('Chicago', 1), ('Tokyo', 2), ('Belgica', 3), ('B.A', 4)

--Jefe cargos:dueño sucursal, venta

--llenar jefe
insert into Jefe values ('27', 'Ron Wiseman', 'co-fundador'), ('44', 'Alex B', 'jefe sucursal'), ('35', 'Alexa White', 'jefe sucursal'),
('12', 'Mark Towns', 'jefe sucursal')

select *from Jefe
select *from Ciudades

insert into Vendedor values('10', 'Carlos Garcia', 1, 5, 0.1, 27), ('14', 'Masaji Matsu', 2, 3, 0.11, 44), ('23', 'Francois Moire', 3, 2, 0.09, 35),
('37', 'Elena Hermana', 4, 5, 0.13, 12), ('39', 'Goro Azuma', 2, 7, 0.1, 44), ('27', 'Terry Cardon', 1, 8, 0.15, 12), 
('44', 'Alberto Ige', 2, 8, 0.12, 27), ('35', 'Brigit Bovary', 3, 9, 0.11, 27)

select * from Vendedor
select *from Ciudades

--create view cltokyo
create view vvtokyo
as
select Id_V, Nombre_V, NombreCiudad, cantv, comision, Id_Jefe from Vendedor
inner join Ciudades on Ciudades.Id_Ciudad =Vendedor.Id_Ciudad where Ciudades.Id_Ciudad=2

select * from vvtokyo

create view vendedorid
as
select * from Vendedor where Vendedor.Id_V=23  

select * from vendedorid

create view buscarVEspec
as
select * from Vendedor where Vendedor.Nombre_V='Brigit Bovary'

select * from buscarVEspec

create view buscarVId
as
select * from Vendedor where Vendedor.Id_V>=23

select * from buscarVId

create view buscaridV
as
select Id_V, Nombre_V from Vendedor where Vendedor.Id_V<20

select * from buscaridV

create view buscarComiV
as
select Id_V, Nombre_V, comision from Vendedor where comision<0.11

select * from buscarComiV

create procedure buscarV
@ID as int
as
declare @idv as int
set @idv =(select Id_V from Vendedor where Id_V =@ID)
if(@ID = @idv)
begin
	select * from Vendedor where Id_V =@ID
end
else
begin
	print 'Vendedor no existe, no registrado'
end

buscarV 44

--Actualizar Nombre de ciudad
create procedure ActualizaC
@ID as int,
@NC as nvarchar(25)
as
declare @idc as int
set @idc =(select Id_Ciudad from Ciudades where Id_Ciudad=@ID)
declare @nomc as nvarchar(25)
set @nomc =(select NombreCiudad from Ciudades where NombreCiudad=@NC)
if(@ID =@idc)
begin
		if(@NC ='')
		begin
			print 'El nombre ciudad no puede estar vacio'
		end
		else
		begin
			update Ciudades set NombreCiudad=@NC where @idc=@ID
		end
end
else
begin
	print 'Ciudad no registrada'
end
drop procedure ActualizaC

ActualizaC 3, 'Bruselas'

select * from Ciudades

