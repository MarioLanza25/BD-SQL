create database BDSI

use BDSI

create table Distrito(
Id_Distrito int identity(1,1) primary key not null,
NumeroDistrito int
)

create table Conductor(
Id_Conduc int identity(1,1) primary key not null,
PN nvarchar(25),
PA nvarchar(25),
InfoLic nvarchar(20),
Telc char(8),
DirC nvarchar(35),
estadoC bit default 1
)

create table Vehiculo(
Matricula char (7) primary key not null,
Marca nvarchar(20),
Modelo nvarchar(20),
color nvarchar(20),
TipoV nvarchar(20),
NAsients int,
Id_Conduc int foreign key references Conductor(Id_Conduc)
)

create table AgenteTransito(
Id_AT int identity (1,1) primary key not null,
NombreAT nvarchar(25),
RangoAT nvarchar(25),
Id_Distrito int foreign key references Distrito(Id_Distrito)
)

create table Accidentes(
Id_Ac int identity (1,1) primary key not null,
Descri nvarchar(35),
FechaA date default getdate(),
HoraA time,
LugarA nvarchar(35),
Matricula char(7) foreign key references Vehiculo(Matricula)
)

create table multas(
Id_Multa int identity(1,1) primary key not null,
Id_Conduc int foreign key references Conductor(Id_Conduc),
FechaM date default getdate(),
HoraM time,
LugarM nvarchar(35),
Id_AT int foreign key references AgenteTransito(Id_AT)
)

insert into Distrito values(1), (2), (3), (4),(5),(6)
select * from Distrito

create procedure NConduc
@PN nvarchar(25),
@PA nvarchar(25),
@InfoL nvarchar(20),
@TC char(8),
@DirC nvarchar(35)
as
declare @inflic as nvarchar(20)
set @inflic=(select InfoLic from Conductor where InfoLic=@InfoL)
if(@InfoL=@inflic)
begin
	print 'La licencia no puede repetirse'
end
else
begin
	if(@PN='' or @PA='' or @TC='' or @DirC='')
	begin
		print 'Los campos no pueden ser nulos'
	end
	else
	begin
		insert into Conductor values(@PN , @PA, @InfoL, @TC, @DirC, 1)
	end
end

NConduc 'Andres', 'Zeledon', '085-200477-0001F', '85642125', 'Managua'
NConduc 'Juan', 'Perez', '052-200665-0005H', '85242125', 'Managua'
NConduc 'Gabriel', 'Lopez', '058-200665-0003Q', '56242125', 'Masaya'
select * from Conductor

--Actualizar conductor
create procedure AConduc
@IDC int,
@InfoL nvarchar(20),
@TC char(8),
@DirC nvarchar(35)
as
declare @idcc as int
set @idcc =(select Id_Conduc from Conductor where Id_Conduc =@IDC)
declare @inflic as nvarchar(20)
set @inflic=(select InfoLic from Conductor where InfoLic=@InfoL)
if(@IDC =@idcc)
begin
	if(@InfoL =@inflic)
	begin
		print 'No puede repetirse licencia'
	end
	else
	begin
		if(@TC='' or @DirC='')
		begin
			print 'Telefono y direccion no pueden ser nulos'
		end
		else
		begin
			update Conductor set InfoLic=@InfoL, Telc =@TC, DirC=@Dirc where Id_Conduc=@IDC
		end
	end
end
else
begin
	print 'No hay conductor asociado'
end

--Dar de baja conductor
create procedure BajaC
@IDC int
as
declare @idconc as int
set @idconc=(select Id_Conduc from Conductor where Id_Conduc=@IDC)
if(@IDC=@idconc)
begin
  update Conductor set estadoC=0 where Id_Conduc=@IDC
end
else
begin
   print 'Proveedor no encontrado'
end

BajaC 2


--Buscar conductor por licencia
create procedure BuscarC
@Infl nvarchar(20)
as
declare @infol as nvarchar(20)
set @infol=(select InfoLic from Conductor where InfoLic=@infl)
if(@infol=@Infl)
begin
   select * from Conductor where InfoLic=@Infl
end
else
begin
   print 'No hay conductor asociado a esta licencia'
end

BuscarC '085-200477-0001F'


--Listar
create procedure LC
as
select * from Conductor

LC

--
insert into Vehiculo values('337-226', 'Toyota', 'Corolla', 'rojo', 'Manual', 5, 1)
insert into Vehiculo values('447-224', 'Toyota', 'Yaris', 'blanco', 'Manual', 4, 1)
insert into Vehiculo values('221-678', 'Hyundai', 'Hon', 'negro', 'Manual', 4, 2)
select * from Vehiculo

insert into AgenteTransito values('Carlos Perez', 'Oficial', 4)
insert into AgenteTransito values('Carlos Perez', 'sub-Oficial', 2)
insert into AgenteTransito values('Carlos Perez', 'Oficial', 4)
insert into AgenteTransito values('Maria Paz', 'Oficial', 3)
select * from AgenteTransito

insert into Accidentes values('', GETDATE(), '9:45am', 'Managua', '337-226')
insert into Accidentes values('', GETDATE(), '2:45pm', 'Managua', '221-678')
select * from Accidentes

select * from Conductor
select *from AgenteTransito

insert into multas values(1, GETDATE(), '9:45', 'Managua', 2)
insert into multas values(3, GETDATE(), '2:45', 'Managua', 3)

select * from multas

create view multaC
as
select PN, PA, InfoLic, Id_Multa from multas 
inner join Conductor on Conductor.Id_Conduc=multas.Id_Conduc where Conductor.Id_Conduc>0

select * from multaC

