
/*
  Transferencias locales: Banco a banco
  En un banco a distintas tipos de cuentas, corriente, ahorro, cuenta deposito a plazo fijo
  El tipo de moneda para las cuentas: es en cordobas o dolares
  Monto minimo para abrir una cuenta
  La cuenta corriente no puede estar en cero
  persona: tambien tienen tarjeta credito, un banco n tarjetas
  --interes para tarjetas
  Estado de cuenta: todos los movimientos de tu cuenta, dependiendo que si fue en cordoba o dolar
  --Cuentas, tarjetas, detalleTransaccional
*/

create database Banca

use Banca

create table TipoDocumento(
Id_TipoDoc int identity(1,1) primary key not null,
NombreDocumento nvarchar(45)
)

create table TipoTarjeta(
Id_TipoTarjeta int identity(1,1) primary key not null,
Nombre nvarchar(30)
)

create table Departamentos(
Id_Depart int identity(1,1) primary key not null,
NombreDepart nvarchar(45)
)

create table Sucursal(
Id_Sucursal int identity(1,1) primary key not null,
NombreSucursal nvarchar(45),
Id_Depart int foreign key references Departamentos(Id_Depart)
)

create table Banco(
Id_Banco int identity(1,1) primary key not null,
Nombre nvarchar(45),
Id_Sucursal int foreign key references Sucursal(Id_Sucursal)
)

create table Cliente(
Id_Cliente int identity(1,1) primary key not null,
Id_TipoDoc int foreign key references TipoDocumento(Id_TipoDoc),
NumeroDocumento nvarchar(45),
PN nvarchar(45),
PA nvarchar(45),
correo nvarchar(45),
telefono char(8),
Id_Banco int foreign key references Banco(Id_Banco)
)

create table Tarjetas(
Id_Tarjeta int identity(1,1) primary key not null,
Id_TipoTarjeta int foreign key references TipoTarjeta(Id_TipoTarjeta),
infoTarjeta nvarchar(30),
Id_Cliente int foreign key references Cliente(Id_Cliente)
)


create table CuentaBancaria(
NumCuenta char(14) primary key not null,
Monto float,
FechaCreacion date default getdate()
)

create table transaccion(
Id_Trans int identity(1,1) primary key not null,
TotalTransaccion float,
FechaTrans date default getdate()
)

create table DetTrans(
Id_Trans int foreign key references transaccion(Id_Trans),
NumCuenta char(14) foreign key references CuentaBancaria(NumCuenta),
SaldoAnterior float,
SaldoActual float,
importe float
primary key(Id_Trans, NumCuenta)
)

insert into TipoDocumento values('Carnet perpetuo')
insert into TipoDocumento values('Cedula de identidad')
insert into TipoDocumento values('Cedula de residencia')
insert into TipoDocumento values('Pasaporte')
insert into TipoDocumento values('RUC')
select * from TipoDocumento

insert into Departamentos values('Managua')
insert into Departamentos values('Masaya')
insert into Departamentos values('Juigalpa')
insert into Departamentos values('Chinandega')

insert into Sucursal values('Centro', 1)
insert into Sucursal values('Carretera sur', 1)
insert into Sucursal values('La virgen', 1)
insert into Sucursal values('Las brisas', 1)
select * from Sucursal

create procedure NB
@NS nvarchar(45),
@IDS int
as
declare @idsucursal as int
set @idsucursal=(select Id_Sucursal from Sucursal where Id_Sucursal=@IDS)
if(@NS='')
begin
	print 'El nombre no peude ser nulo'
end
else
begin
	if(@IDS =@idsucursal)
	begin
		insert into Banco values(@NS, @IDS)
	end
	else
	begin
		print 'La sucursal no ha sido registrada'
	end
end

NB 'Banco de finanzas', 1

create procedure listaSucursalesBDF
as
	select * from Banco

listaSucursalesBDF


