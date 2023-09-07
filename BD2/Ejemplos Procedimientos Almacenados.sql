create database SFCIFX

restore database SFCIFX from disk='D:\ECEA\BD I\2M2-IS\SFCIFX.bak'
with replace

use SFCIFX

-- Procedimientos almacenados
alter table Proveedor add EstadoProv bit default 1

select * from Proveedor

update proveedor set EstadoProv=1

-- 1.- Insercion
create procedure NuevoProv
@IDP char(5),
@NP nvarchar(45),
@DP nvarchar(70),
@TP char(8),
@URLP nvarchar(45)
as
declare @idprov as char(5)
set @idprov=(select IdProv from Proveedor where
IdProv=@IDP)
declare @pdt as char(1)
set @pdt=(select substring(@TP,1,1))
if(@IDP='' or @NP='' or @DP='')
begin
  print 'No pueden ser nulos'
end
else
begin
  if(@IDP=@idprov)
  begin
     print 'Proveedor ya registrado'
  end
  else
  begin
    if(@pdt='2' or @pdt='5' or @pdt='7' or @pdt='8')
	begin
	   insert into Proveedor values(@IDP,@NP,@DP,
	   @TP,@URLP,1)
	end
	else
	begin
	   print 'Debe iniciar con 2, 5, 7 u 8'
	end
  end
end

select * from Proveedor

NuevoProv '00003','Rarpe','Managua','22548741',
'www.rarpe.com.ni'

-- Procedimiento de Dar baja
alter procedure DarBProv
@IDP char(5)
as
declare @idprov as char(5)
set @idprov=(select IdProv from Proveedor where
IdProv=@IDP)
if(@IDP='')
begin
  print 'No puede estar en blanco'
end
else
begin
  if(@IDP=@idprov)
begin
  update Proveedor set EstadoProv=0 where IdProv=@IDP
  and EstadoProv=1
end
else
begin
   print 'Proveedor no encontrado'
end
end


DarBProv '00003'

select * from Proveedor where EstadoProv=0

-- Procedimiento de Modificacion
create procedure ModProv
@IDP char(5),
@NP nvarchar(45),
@DP nvarchar(70),
@TP char(8),
@URLP nvarchar(45)
as
declare @ip as char(5)
set @ip=(select IdProv from Proveedor where IdProv=@IDP)
declare @t as char(1)
set @t=(select substring(@TP,1,1))
if(@IDP='' or @NP='' or @DP='')
begin
  print 'No pueden ser nulos'
end
else
begin
  if(@IDP=@ip)
  begin
    if(@t='2' or @t='5' or @t='7' or @t='8')
	begin
	  update Proveedor set NombreProv=@NP,
	  DirProv=@DP, TelProv=@TP, URLProv=@URLP
	  where IdProv=@IDP and EstadoProv=1
	end
	else
	begin
	  print 'Debe iniciar con 2, 5, 7 u 8'
	end
  end
  else
  begin
    print 'Proveedor no encontrado'
  end
end

backup database SFCIFX to disk='D:\SFCIFX.bak'
