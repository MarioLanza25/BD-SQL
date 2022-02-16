create database CV 

restore database CV from disk ='E:\CV.bak' with replace

use CV 

select * from Proveedor
select * from Productos
select * from Clientes

alter procedure NProducto
@CP char(5),
@NP nvarchar(25),
@p float,
@exist int,
@DP nvarchar(35),
@IDP char(5)
as
declare @codpro as char(5)
set @codpro=(select CodProd from Productos where CodProd=@CP)
declare @idprov as char(5)
set @idprov=(select Id_Prov from Proveedor where Id_Prov=@IDP)
if(@CP='')
begin
	print 'El codigo de producto no puede ser nulo'
end
else
begin
	if(@CP=@codpro)
	begin
		print 'El codigo no puede repetirse'
	end
	else
	begin
		if(@IDP =@idprov)
		begin
			if(@NP =@DP)
			begin
				print 'El nombre y descripcion no pueden ser nulos'
			end
			else
			begin
				if(@p>0 or @exist>0)
				begin
					insert into Productos values(@CP, @NP, @p, @exist , @DP , @IDP)
				end
				else
				begin
					print 'El precio ni existencia pueden ser - o cero'
				end
			end
		end
		else
		begin
			print 'El proveedor no ha sido registrado'
		end
	end
end

NProducto '05', 'Alka-d', 7, 3, 'Pastillas para..', '0001' 

create procedure listarP
as
	select * from Productos
listarP

alter table Productos add estado bit default 1

update Productos set estado=1 where CodProd='01'
update Productos set estado=1 where CodProd='02'
update Productos set estado=1 where CodProd='03'
update Productos set estado=1 where CodProd='04'

create procedure BajaP
@CP char(5)
as
declare @codpro as char(5)
set @codpro=(select CodProd from Productos where CodProd=@CP)
if(@CP ='')
begin
	print 'El codigo no puede ser nulo'
end
else
begin
	if(@CP =@codpro)
	begin
		update Productos set estado=0 where CodProd=@CP and estado=1
	end
	else
	begin
		print 'El codigo no ha sido registrado'
	end
end

BajaP '04'

create procedure BuscarP
@CP char(5)
as
declare @codpro as char(5)
set @codpro=(select CodProd from Productos where CodProd=@CP)
if(@CP ='')
begin
	print 'El codigo no puede ser nulo'
end
else
begin
	if(@CP =@codpro)
	begin
		select * from Productos where CodProd=@CP
	end
	else
	begin
		print 'El codigo no ha sido registrado'
	end
end

BuscarP '04'

create procedure AProducto
@CP char(5),
@NP nvarchar(25),
@p float,
@ex int,
@DP nvarchar(35)
as
declare @codpro as char(5)
set @codpro=(select CodProd from Productos where CodProd=@CP)
if(@CP='')
begin
	print 'El codigo de producto no puede ser nulo'
end
else
begin
	if(@CP= @codpro)
	begin
		if(@NP =@DP)
		begin
			print 'El nombre y descripcion no pueden ser nulos' 
		end
		else
		begin
			if(@p>0 or @ex>0)
			begin
				update Productos set NProd=@NP, precio=@p, exist=@ex, DescProd=@DP where CodProd=@CP
			end
			else
			begin
				print 'El precio ni la existencia pueden ser - o cero'
			end
		end
	end
	else
	begin
		print 'El codigo no ha sido registrado'
	end
end

AProducto '04', 'Valzartan', 12, 24, 'Presion'








