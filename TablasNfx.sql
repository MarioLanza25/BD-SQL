create database NF

use NF

create table Pais(
Id_Pais int identity(1,1) primary key not null,
NombreP nvarchar(30),
Region nvarchar(30)
)

create table Idioma(
Id_Idioma int identity (1,1) primary key not null,
Tipo_Idioma nvarchar(20),
Id_Pais int foreign key references Pais(Id_Pais)
)

create table TipoPlan(
Id_Plan int identity (1,1) primary key not null,
TipoPlan char(1) check(TipoPlan like '[b|e|p]'),
NDisp char (1) check(NDisp like '[1|2|4]'),
precio float,
CalidadVideo nvarchar(10)
) 

create table Subscripcion(
Id_subs int identity(1,1) primary key not null,
F_subscripcion date default getdate() not null,
F_vencimiento date not null,
Cod_tarjeta char(5),
Id_Plan int foreign key references TipoPlan(Id_Plan)
)

create table Clientes(
Id_Cliente int identity(1,1) primary key not null,
PN nvarchar(25),
SN nvarchar(25),
PA nvarchar(25),
SA nvarchar(25),
Tipo nvarchar(20),
Id_Pais int foreign key references Pais(Id_Pais),
Id_subs int foreign key references Subscripcion(Id_subs)
)

create table Cuenta(
Id_Cuenta int identity(1,1) primary key not null,
correo nvarchar(35),
passw varchar(max),
llave varchar(100),
)

create table DetSubs(
Id_Cuenta int foreign key references Cuenta(Id_Cuenta),
Id_subs int foreign key references Subscripcion(Id_subs),
Montopago money
primary key(Id_Cuenta, Id_subs)
)

create table Perfil(
Id_Perfil int identity(1,1) primary key not null,
NombreP nvarchar(25),
Tipo nvarchar(20),
cantidad int,
Id_Cuenta int foreign key references Cuenta(Id_Cuenta)
)

create table Contenido(
Id_Contenido int identity(1,1) primary key not null,
NombreC nvarchar(30),
Festreno date,
Id_Perfil int foreign key references Perfil(Id_Perfil)
)

create table ContenidoGenero(
Id_ContenidoG int identity(1,1) primary key not null,
NombreGenero nvarchar(35),
Id_Contenido int foreign key references Contenido(Id_Contenido)
)



