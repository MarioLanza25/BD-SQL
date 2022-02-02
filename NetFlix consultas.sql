use NF

--Insertar Pais
create procedure NewP
@NP nvarchar(30),
@NR nvarchar(30)
as
declare @npais as nvarchar(30)
set @npais =(select NombreP from Pais where NombreP =@NP)
declare @nregion as nvarchar(30)
set @nregion= (select Region from Pais where Region =@NR)
if(@NP =@npais)
begin
	print 'Pais ya registrado'
end
else
begin
	if(@NP='' or @NR='')
	begin
		print 'El nombre ni region pueden estar vacios'
	end
	else
	begin
		insert into Pais values(@NP, @NR)
	end
end

NewP 'Nicaragua', 'CentroAmerica'
NewP 'EstadosUnidos', 'NorteAmerica'
NewP 'Alemania', 'Europa'

select * from Pais

--Buscar pais 
create procedure SearchP
@ID int
as
declare @idpais as int
set @idpais =(select Id_Pais from Pais where Id_Pais =@ID)
if(@ID = @idpais)
begin
	select Id_Pais, NombreP from Pais where Id_Pais =@ID
end
else
begin	
	print 'Pais no encontrado, no registrado'
end

SearchP 1

--Listar paises
create procedure ListP
as
select * from Pais

ListP

--Creacion cuentas
create procedure createC
@MC as nvarchar(35),
@PSW as varchar(max),
@KC as varchar(100)
as
set @PSW =(ENCRYPTBYPASSPHRASE(@KC, @PSW))
if(@MC =(select correo from Cuenta where correo =@MC))
begin
	print 'Esta cuenta ya existe'
end
else
begin
	if(@MC='' or @PSW='')
	begin
		print 'El correo o contra no pueden estar vacios'
	end
	else
	begin
		insert into Cuenta values(@MC, @PSW, @KC)
	end
end

createC 'carlitos@mail.com', '12345', '******'
createC 'marinAnto@mail.com', '9876', '******'

select * from Cuenta

--Mostrar cuentas con password cifrada
create procedure ListC
as
	select Id_Cuenta, correo, passw=DECRYPTBYPASSPHRASE(llave, passw)  from Cuenta

ListC

--Mostrar password sin cifrar
create procedure ListCc
as
	select Id_Cuenta, correo, passw=CONVERT(varchar(max), DECRYPTBYPASSPHRASE(llave, passw))  from Cuenta

ListCc

--Buscar usuario
create procedure SearchC
@ID int
as
declare @idc as int
set @idc =(select Id_Cuenta from Cuenta where Id_Cuenta =@ID)
if(@ID =@idc)
begin
	select Id_Cuenta, correo from Cuenta where Id_Cuenta=@idc
end
else
begin
	print 'No se encontro ninguna cuenta asociada'
end

SearchC 2

--Insertar tipo plan
create procedure createPlan
@TP as char(1),
@ND as char(1),
@PP as float,
@CV as nvarchar(10)
as
declare @pdp as char(1)
set @pdp = (select substring(@TP,1,1))
declare @pdnd as char(1)
set @pdnd = (select substring(@TP,1,1))
if(@pdp='b' or @pdp='e' or @pdp='p')
begin
	if(@pdnd='1' or @pdnd='2' or @pdnd='4')
	begin
		print 'Debe ingresar numero dispositivos: 1, 2 o 4'
	end
	else
	begin
		if(@CV ='')
		begin
			print 'El campo no puede ser vacio'
		end
		else
		begin
			insert into TipoPlan values(@TP, @ND, @PP, @CV)
		end
	end
end
else
begin
	print 'Debe ingresar plan: b=basico, o e=estandar, o p=premium'
end

createPlan 'b', '1', '7.99', 'HD'
createPlan 'e', '2', '10.99', 'FULLHD'
createPlan 'p', '4', '13.99', '4KHDR'

select * from TipoPlan

--Insertar subscripcion
create procedure createSubs
@Fsubs as date,
@Fvenc as date,
@CT as char(5),
@IDp as int
as
declare @idplan as int
set @idplan = (select Id_Plan from TipoPlan where Id_Plan =@IDp)
if(@CT ='')
begin
	print 'El codigo de tarjeta no puede ser vacio'
end
else
begin
	if(@IDp =@idplan)
	begin
		insert into Subscripcion values (@Fsubs, @Fvenc, @CT, @IDp)
	end
	else
	begin
		print 'El plan debe ser 2, 3 o 4'
	end
end

createSubs '', '', '0695', '4'

select * from Subscripcion

select F_subscripcion, F_vencimiento, Cod_tarjeta from Subscripcion
where Id_Plan in (select Id_Plan from TipoPlan where Id_Plan =4)

--Buscar subscripciones asociadas a un tipo de plan basico(2), estandar(3) o premium(4)

select * from TipoPlan join Subscripcion
on Subscripcion.Id_Plan = TipoPlan.Id_Plan  where TipoPlan.Id_Plan =3




