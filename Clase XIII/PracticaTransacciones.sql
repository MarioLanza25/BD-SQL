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
telefono char(8)
)

create table Tarjetas(
Id_Tarjeta int identity(1,1) primary key not null,
Id_TipoTarjeta int foreign key references TipoTarjeta(Id_TipoTarjeta),
infoTarjeta nvarchar(30),
Id_Banco int foreign key references Banco(Id_Banco)
)


create table CuentaBancaria(
NumCuenta char(14) primary key not null,
Monto float,
Id_Banco int foreign key references Banco(Id_Banco),
FechaCreacion date default getdate()
)

create table transaccion(
Id_Trans int identity(1,1) primary key not null,
TotalTransaccion float,
NumCuenta char(14) foreign key references CuentaBancaria(NumCuenta),
FechaTrans date default getdate()
)

create table DetTrans(
Id_Trans int foreign key references transaccion(Id_Trans),
Id_Cliente int foreign key references Cliente(Id_Cliente),
SaldoAnterior float,
SaldoActual float,
importe float,
primary key(Id_Trans, Id_Cliente)
)