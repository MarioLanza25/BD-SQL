
create database Clientes;

use Clientes

update Usuarios set estado=0 where idUsuario=2;



select *from temporal

create table temporal(
idUsuario int identity(1,1) primary key not null,
PNombre varchar(40) not null,
Papellido varchar(40) not null,
contra varchar(max) not null,
Direccion varchar(max) not null,
telefono  char(8) check (telefono like '[5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
estado bit default 0
)


select *from temporal
-- Cremamos un Trigger sobre la tabla expedientes

create table Usuarios(
idUsuario int identity(1,1) primary key not null,
PNombre varchar(40) not null,
Papellido varchar(40) not null,
contra varchar(max) not null,
Direccion varchar(max) not null,
telefono  char(8) check (telefono like '[5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
estado bit default 1
)



go
create TRIGGER StatusChangeTrigger
ON Usuarios
 AFTER UPDATE AS 

 SET IDENTITY_INSERT temporal ON
 IF UPDATE(estado)
 BEGIN
	-- Actualizamos el campo stateChangedDate a la fecha/hora actual
	UPDATE Usuarios SET estado=0 WHERE idUsuario=(SELECT idUsuario FROM inserted);
 
    -- A modo de auditoría, añadimos un registro en la tabla expStatusHistory
	INSERT INTO temporal (idUsuario, PNombre,Papellido,contra,telefono,Direccion) (SELECT idUsuario, PNombre,Papellido,contra,telefono,Direccion FROM deleted WHERE idUsuario=deleted.idUsuario);
	
    -- La tabla deleted contiene información sobre los valores ANTIGUOS mientras que la tabla inserted contiene los NUEVOS valores.
    -- Ambas tablas son virtuales y tienen la misma estructura que la tabla a la que se asocia el Trigger. 
 END;

 go


 
go
create proc eliminarUsuario
@id int
as
    
	if exists (select idUsuario from Usuarios where idUsuario=@id)
  begin
       update Usuarios set estado=0 where idUsuario=@id
  end

go


go
create proc editUsuario
@id int,
@tel char(8),
@dir varchar(max)
as
  if exists (select idUsuario from Usuarios where idUsuario=@id)
  begin
       update Usuarios set telefono=@tel where idUsuario=@id
	   update Usuarios set Direccion=@dir where idUsuario=@id
  end
    
go


go
create proc InsertarUsuario
@Pnombre varchar(40),@Papellido varchar(40),@contra varchar(max),
@direccion varchar(max),@telefono char(8)
as
   insert into Usuarios (PNombre,Papellido,contra,Direccion,telefono) values (@Pnombre,@Papellido,@contra,@direccion,@telefono) 
go

go
create proc MostrarUsuarios
as
     select idUsuario as ID,PNombre as Nombre,Papellido as Apellido,contra as Contraseña ,Direccion as Direccion,telefono as Telefono from Usuarios where estado=1
     
go