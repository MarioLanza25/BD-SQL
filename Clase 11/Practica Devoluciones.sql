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
Id_Cliente int foreign key references Clientes(Id_Cliente),
MotivoDev nvarchar(45),
montoDev float
)

--Insertar devolucion del cliente
create procedure NDevCl
@IDDev char(5),
@FD date,
@IDC int,
@MD nvarchar(45),
@montod float
as
declare @iddevcl as char(5)
set @iddevcl =(select Id_DevCl from DevCliente where Id_DevCl=@IDDev)
declare @idcl as int
set @idcl =(select Id_Cliente from Clientes where Id_Cliente=@IDC)
if(@IDDev='' or @IDC ='')
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
		if(@IDC =@idcl)
		begin
			if(@MD ='')
			begin
				print 'El motivo de devolucion no puede ser nulo'
			end
			else
			begin
				if(@montod>0)
				begin
					insert into DevCliente values(@IDDev, @FD , @IDC, @MD, @montod)
				end
				else
				begin
					print 'El monto no puede ser - o cero'
				end
			end
		end
		else
		begin
			print 'El cliente no ha sido registrado'
		end
	end
end

NDevCl '001', '', 2, 'Producto defectuoso', 50 
NDevCl '002', '', 1, 'Producto dañado', 20
select * from DevCliente

create table DetDevCliente(
Id_DevCl char(5) foreign key references DevCliente(Id_DevCl),
CodProd char(5) foreign key references Productos(CodProd),
cantdev int,
stdv float
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
@ID

select * from DetDevCliente
select * from Productos
select * from Clientes