use CV

-- Procedimientos almacenados
-- CRUD: Create, Read, Update y Delete
-- Busqueda, Lista

--1.- Insercion Depto
create procedure NDpto
@ND nvarchar(45)
as
declare @nomd as nvarchar(45)
set @nomd=(select NombreDepto from
Dept where NombreDepto=@ND)
if(@nomd=@ND)
begin
  print 'Depto ya registrado'
end
else
begin
  if(@ND='')
  begin
    print 'No puede ser nulo'
  end
  else
  begin
    insert into Dept values(@ND)
  end
end

select * from Dept

NDpto 'Masaya'

--2.- Actualizar
create procedure ADpto
@ID int,
@ND nvarchar(45)
as
declare @iddept as int
set @iddept=(select Id_Dpto from Dept where Id_Dpto=@ID)
declare @nomd as nvarchar(45)
set @nomd=(select NombreDepto from Dept where NombreDepto=@ND)
if(@iddept=@ID)
begin
  if(@ND=@nomd)
  begin
    print 'No puede duplicar el registro'
  end
  else
  begin
    if(@ND='')
	begin
	  print 'No puede ser nulo'
	end
	else
	begin
	  update Dept set NombreDepto=@ND where Id_Dpto=@ID
	end
  end
end
else
begin
  print 'Dpto no registrado'
end

ADpto 2,'Granada'

select * from Dept

-- Buscar
create procedure BD
@ID int 
as
declare @idd as int
set @idd=(select Id_Dpto from Dept where Id_Dpto=@ID)
if(@idd=@ID)
begin
   select * from Dept where Id_Dpto=@ID
end
else
begin
   print 'Dept no encontrado'
end

BD 1

-- Listar
create procedure LD
as
select * from Dept

LD


-- Insercion Mun
create procedure NM
@NM nvarchar(45),
@ID int
as
declare @idd as int
set @idd=(select Id_Dpto from Dept where Id_Dpto=@ID)
declare @nmu as nvarchar(45)
set @nmu=(select NombreMun from Muni where NombreMun=@NM)
if(@ID=@idd)
begin	
  if(@NM='')
  begin
    print 'No puede ser nulo'
  end
  else
  begin
    if((@NM=@nmu)and (@ID=@idd))
	begin
	  print 'No puede duplicarse'
	end
	else
	begin
	  insert into Muni values(@NM,@ID)
	end
  end
end
else
begin
 print 'Dpto no registrado'
end

select * from Muni

NM 'Tipitapa',3

alter table Proveedor add estadop bit default 1

-- Insert Prov
create procedure NProv
@IDP char(5),
@NP nvarchar(35),
@DP nvarchar(70),
@TP char(8),
@MP nvarchar(35),
@IDep int
as
declare @idpr as char(5)
set @idpr=(select Id_Prov from Proveedor where Id_Prov=@IDP)
declare @iddep as int
set @iddep=(select Id_Dpto from Dept where Id_Dpto=@IDep)
declare @pdt as char(1)
set @pdt=(select substring(@TP,1,1))
if(@IDP='')
begin
  print 'No puede ser nulo'
end
else
begin
  if(@IDP=@idpr)
  begin
    print 'No puede estar duplicado'
  end
  else
  begin
    if(@IDep=@iddep)
	begin
	  if(@NP='' or @DP='' or @TP='')
	  begin
	    print 'Ni el nombre, dir o tel pueden ser nulos'
	  end
	  else
	  begin
	     if(@pdt='2' or @pdt='5' or @pdt='7' or @pdt='8')
		 begin
		   insert into Proveedor values(@IDP,@NP,@DP,@TP,@MP,@IDep,1)
		 end
		 else
		 begin
		   print 'debe ser 2, 5, 7 u 8'
		 end
	  end
	end
	else
	begin
	  print 'Depto no registrado'
	end
  end
end

select * from Proveedor
select * from Dept
NProv '0001','Dicegsa','Carretera nueva leon','84547414','',1
NProv '0003','Carlos','Carretera Norte','54547414','',1

-- Dar de baja Prov
create procedure DBP
@IDP char(5)
as
declare @idpr as char(5)
set @idpr=(select Id_Prov from Proveedor where Id_Prov=@IDP)
if(@IDP=@idpr)
begin
  update Proveedor set estadop=0 where Id_Prov=@IDP
end
else
begin
  print 'Proveedor no registrado'
end

DBP '0002'

create procedure BProv
@IDP char(5)
as
declare @idpr as char(5)
set @idpr=(select Id_Prov from Proveedor where Id_Prov=@IDP)
if(@IDP=@idpr)
begin
  select * from Proveedor where Id_Prov=@IDP and estadop=1
end
else
begin
   print 'Proveedor no encontrado'
end

-- Crear actualizacion, busqueda y lista de: Mun
-- insercion, actualizacion, busqueda y lista de : Comarcas
-- lista de proveedor considerand proveedor activos
-- insercion, actualizacion, dar baja, busqueda y lista de Clientes

backup database CV to disk='D:\CV.bak'