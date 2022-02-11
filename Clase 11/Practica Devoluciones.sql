Use CV
--Tabla devolucion del cliente a empresa, con su detalle
--DetDevClEmp
--DevolucionEmpProveedor
--DetDevEmpProv
--Dev debe haber motivos, 
--Implementar: Procedimientos, (CRUD), (Funciones), Trigger
--CORREGIR tabla DevCliente
--Devolucion del cliente asociado a venta. Devolucion del proveedor asociado a compra
/*
	Idcliente por Idvl
	MotivoDev en el detalle
*/


create table DevCliente(
Id_DevCl char(5) primary key not null,
FechaDev date default getdate(),
Id_VL int foreign key references VentaL(Id_VL),
montoDev float
)

--Insertar devolucion del cliente
create procedure NDevCl
@IDDev char(5),
@IDVL int,
@montod float
as
declare @iddevcl as char(5)
set @iddevcl =(select Id_DevCl from DevCliente where Id_DevCl=@IDDev)
declare @idvental as int
set @idvental =(select Id_VL from VentaL where Id_VL=@IDVL)
if(@IDDev='' or @IDVL ='')
begin
	print 'El iddevolucion o idcliente no pueden ser nulos'
end
else
begin
	if(@IDDev =@iddevcl)
	begin
		print 'La devolucion ya ha sido registrada'
	end
	else
	begin
		if(@IDVL =@idvental)
		begin
			if(@montod>0)
			begin
				insert into DevCliente values(@IDDev, getdate() , @IDVL, @montod)
			end
			else
			begin
				print 'El monto no puede ser - o cero'
			end
		end
		else
		begin
			print 'La venta no ha sido registrada'
		end
	end
end

NDevCl '001', 1,  240 
NDevCl '002', 2,  20

select * from DevCliente

create table DetDevCliente(
Id_DevCl char(5) foreign key references DevCliente(Id_DevCl),
CodProd char(5) foreign key references Productos(CodProd),
MotivoDev nvarchar(45),
cantdev int,
stdv float,
primary key(Id_DevCl, CodProd)
)


create trigger actDevProducto
on
DetDevCliente
after insert 
as
	update Productos set exist =exist +(select cantdev from inserted)
	from Productos p, DetDevCliente ddc where p.CodProd=ddc.CodProd

create function CalcDevst(@CP as char(5),@cantdev as int)
returns float
as
begin
  declare @st as float
  select @st=precio * @cantdev from Productos
  where CodProd=@CP
  return @st
end

create procedure NDetDevCl
@IDev char(5),
@CP char(5),
@MD nvarchar(45),
@cdv int
as
declare @iddev as char(5)
set @iddev=(select Id_DevCL from DevCliente where Id_DevCL=@IDev)
declare @codp as char(5) 
set @codp =(select CodProd from Productos where CodProd =@CP)
if(@IDev= '')
begin
	print 'El iddevolucion no puede ser nulo' 
end
else
begin
	if(@IDev =@iddev)
	begin
		if(@CP='')
		begin
			print 'El codigo de producto no puede ser nulo'
		end
		else
		begin
			if(@CP =@codp)
			begin
				if(@MD='')
				begin
					print 'El motivo de devolucion no puede ser nulo'
				end
				else
				begin
					if(@cdv>0)
					begin
						insert into DetDevCliente values(@IDev, @CP, @MD, @cdv, dbo.CalcDevst(@CP, @cdv))
					end
					else
					begin
						print 'La cantidad no puede ser - o cero'
					end
				end
			end
			else
			begin
				print 'El producto no ha sido registrado'
			end
		end
	end
	else
	begin
		print 'La devolucion no ha sido registrada'
	end
end

NDetDevCl '002', '02', 'Lata dañada..', 2

select * from DevCliente
select * from DetDevCliente
select * from Productos
select * from Clientes
select * from VentaL

create table DevProveedor(
Id_DevProveedor int identity(1,1) primary key not null,
Fecha_Devolucion date default getdate(),
Id_Compra char(6) foreign key references Compras(Id_Compra),
montoDev float
)

create table DetDevProveedor(
Id_DevProveedor int foreign key references DevProveedor(Id_DevProveedor),
CodProd char(5) foreign key references Productos(CodProd),
MotivoDev nvarchar(45),
cantdev int,
subtotal float
)

select * from Productos
select * from Compras
select *from DetCompras
select * from Proveedor

--Insert para detCompra
insert into DetCompras values('01','02' , 2, 600, 2*600)
insert into DetCompras values('03','03' , 2, 150, 2*150)

--Insertar devolucion proveedor
create procedure NDevProv
@IDCompra char(6),
@MD float
as
declare @idc as char(6) 
set @idc =(select Id_Compra from Compras where Id_Compra=@IDCompra)
if(@IDCompra='')
begin
	print 'El idcompra no puede ser nulo'
end
else
begin
	if(@IDCompra = @idc)
	begin
		if(@MD >0)
		begin
			 insert into DevProveedor values(getdate(), @IDCompra, @MD)
		end
		else
		begin
			print 'El monto de la devolucion no puede ser - o cero'
		end
	end
	else
	begin
		print 'La compra no ha sido registrada'
	end
end

select * from DevProveedor

update DevProveedor set montoDev=0 where Id_DevProveedor=1
update DevProveedor set montoDev=0 where Id_DevProveedor=2

create procedure BuscarDevProv
@ID int
as
declare @idbdp as int
set @idbdp =(select Id_DevProveedor from DevProveedor where Id_DevProveedor=@ID)
if(@ID =@idbdp)
begin
	select * from DevProveedor where Id_DevProveedor=@ID
end
else
begin
	print 'El id no existe'
end

BuscarDevProv 1

create trigger ActProductoDVP
on
DetDevProveedor
after insert 
as
	update Productos set exist = exist -(select cantdev from inserted)
	from Productos p, DetDevProveedor ddp where p.CodProd=ddp.CodProd

create function CalcDetDevPst(@CP as char(5), @cantdev as int)
returns float
as
begin
	declare @st as float
	select @st= precio *@cantdev from Productos
	where CodProd=@CP
	return @st
end

alter procedure NDetDevP
@ID int,
@CP char(5),
@md nvarchar(45),
@cd int
as
declare @iddevp as int
set @iddevp=(select Id_DevProveedor from DevProveedor where Id_DevProveedor=@ID)
declare @codp as char(5)
set @codp=(select CodProd from Productos where CodProd=@CP)
declare @exis as int
set @exis=(select exist from Productos where CodProd=@CP)
if(@ID='' or @CP='')
begin
	print 'El idDevProveedor or codigoProducto no puede ser - o cero'
end
else
begin
	if(@ID=@iddevp)
	begin
		if(@CP =@codp)
		begin
			if(@md ='')
			begin
				print 'El motivo de devolucion no puede ser nulo'
			end
			else
			begin
				if(@cd>0)
				begin
					if(@cd<@exis)
					begin
						insert into DetDevProveedor values(@ID, @CP, @md, @cd, dbo.CalcDetDevPst(@CP, @cd))
					end
					else
					begin
						print 'No hay inventario suficiente'
					end
				end
				else
				begin
					print 'La cantidad no puede ser - o cero'
				end
			end
		end
		else
		begin
			print 'El producto no ha sido registrado'
		end
	end
	else
	begin
		print 'La devolucion del proveedor no ha sido registrada'
	end
end

NDetDevP 1, '03', 'Lamina en mal estado', 2
--Funciona trigger
select * from Compras
select * from Productos
select * from DevProveedor
select * from DetDevProveedor

create trigger actdvempp
on
DetDevProveedor
after insert
as
	update Productos set exist= exist -(select cantdev from inserted)
	from Productos p, DetDevProveedor ddp where p.CodProd=ddp.CodProd


create procedure ActDevProv
@ID int
as
declare @iddevp as int
set @iddevp=(select Id_DevProveedor from DevProveedor where Id_DevProveedor=@ID)
declare @st as float
set @st =(select sum(subtotal) from DetDevProveedor where Id_DevProveedor=@ID)
if(@ID=@iddevp)
begin
	update DevProveedor set montoDev =@st where Id_DevProveedor=@ID
end
else
begin
	print 'La devolucion no ha sido registrada'
end

ActDevProv 1

select * from DevProveedor
select * from DetDevProveedor