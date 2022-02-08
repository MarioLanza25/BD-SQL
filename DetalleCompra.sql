
select * from Clientes


--cursor
--1: primer registro tabla cliente
DECLARE listac CURSOR  
    FOR SELECT * FROM Clientes
OPEN listac  
FETCH NEXT FROM listac;  

--2:
SET NOCOUNT ON;  
  
DECLARE @IDC INT, @PN NVARCHAR(15), @PA NVARCHAR(15), 
    @DirC VARCHAR(70), @TelC CHAR(8);  
  
PRINT '-------- Vendor Products Report --------';  
  
DECLARE Clientes_cursor CURSOR FOR   
SELECT Id_Cliente, PN,PA, DirC, TelC 
FROM Clientes
--ORDER BY Id_Cliente  
  
OPEN Clientes_cursor  
  
FETCH NEXT FROM Clientes_cursor   
INTO @IDC, @PN, @PA, @DirC, @TelC  
  
WHILE @@FETCH_STATUS = 0  
BEGIN  
    PRINT ' '  
    SELECT PN,PA, DirC, TelC from Clientes 

        -- Get the next vendor.  
    FETCH NEXT FROM Clientes_cursor   
    INTO @IDC, @PN, @PA, @DirC, @TelC
END   
CLOSE Clientes_cursor;  
DEALLOCATE Clientes_cursor;


--procedure compra
alter procedure NCompra
@IDC char(6),
@FC date,
@IDP char(5),
@TC float
as
declare @IdCo as char(6)
set @IdCo=(Select Id_Compra from Compras where Id_Compra=@IDC)
declare @IdProv as char(5)
set @IdProv=(Select Id_Prov from Proveedor where Id_Prov=@IDP)
if(@IDC =@IdCo)
begin
	print 'Compra ya registrada'
end
else
begin 
	if(@IDC ='')
	begin
		print 'El idCompra no puede ser nulo'
	end
	else
	begin
		if(@IDP= '')
		begin
			print 'El idProveedor no puede ser nulo'
		end
		else
		begin
			if(@IDP =@IdProv)
			begin
				if(@FC ='')
				begin
					print 'Fecha de compra no puede ser nula'
				end
				else
				begin
					if(@TC>0)
					begin
						insert into Compras values(@IDC, @FC, @IDP, @TC)
					end
					else
					begin 
						print 'El total de compra no puede ser menor a cero'
					end
				end
			end
			else
				begin
					print 'Proveedor no registrado'
				end				
		end
	end
end

select * from Proveedor
select * from Compras

NCompra '01', '08-02-2022', '0001', 1050
NCompra '02', '09-02-2022', '0001', 1100

--actualizar primer registro
update Compras set Fecha_Compra='08-02-2022' where Id_Compra='01'

create trigger ActC
on
DetCompras
after insert
as
	update Productos set exist=exist +(Select cc from inserted)
	from DetCompras dc, Productos p where p.CodProd=dc.CodProd

select * from DetCompras

create procedure NDCompras
@IDC char(6),
@IDP char(5),
@cc int,
@pc float
as
declare @idCompra as char(6)
set @idCompra=(select Id_Compra from Compras where Id_Compra =@IDC)
declare @idprod as char(5)
set @idprod=(select CodProd from Productos where CodProd =@IDP)
declare @p as float
set @p =(select precio from Productos where precio =@IDP)
if(@IDC =@idCompra)
begin
	if(@IDP =@idprod)
	begin
		if(@IDP='')
		begin
			print 'Codigo de producto no puede ser nulo'
		end
		else
		begin
			if(@cc>0)
			begin
				if(@pc>0)
				begin
					if(@pc >=@p)
					begin
						
					end
					else
					begin
						insert into DetCompras values(@IDC, @IDP, @cc, @pc)
					end
				end
			end
			else
			begin
				print 'El precio no puede ser menor a cero'
			end
		end
		else
		begin
			print 'La cantidad no puede ser menor a cero '
		end
	end
	else
	begin
		print 'El producto no ha sido registrado'
	end
end
else
begin
	print 'La compra no ha sido registrada'
end
