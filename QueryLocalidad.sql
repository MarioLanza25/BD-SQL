create database Localidad

use Localidad

create table Dept(
Id_Dpto int identity(1,1) primary key not null,
NombreDepto nvarchar(45) not null
)

create table Muni(
Id_Mun int identity(1,1) primary key not null,
NombreMun nvarchar(45) not null,
Id_Dpto int foreign key references Dept(Id_Dpto) not null
)

create table Comarcas(
Id_Com int identity(1,1) primary key not null,
NombreCom nvarchar(35) not null,
Id_Mun int foreign key references Muni(Id_Mun) not null
)