restore database Northwind from disk='C:\Northwind.bak' with replace

Use Master
go
-- Desvincular BD
sp_detach_db Northwind

-- Vincular la BD

sp_attach_db Northwind,
'c:\bases\northwnd.mdf',
'c:\bases\northwnd.ldf'

sp_helpDB Northwind

-- Respaldo Full de Base de Datos
Backup database Northwind
to disk = 'c:\bases\Northwind.bak'
with Name = 'Respaldo Full '

-- Respaldo Diferencial de Base de Datos
Backup database Northwind
to disk = 'c:\bases\Northwind.bak'
with Name = 'Respaldo Diferencial',
Differential
----------------------------------------------------
Use Northwind
go
Select * from Region
Insert into Region values(5,'Centro América')

Backup database Northwind
to disk = 'c:\bases\Northwind.bak'
with Name = 'Respaldo Diferencial 2',
Differential
------------------------------------------
Insert into Region values(6,'Sur América')
Insert into Region values(7,'Norte América')
------------------------------------------
Backup database Northwind
to disk = 'c:\bases\Northwind.bak'
with Name = 'Respaldo Diferencial 3',
Differential
-------------------------------------------
Insert into Region values(8,'Region Central')
Insert into Region values(9,'Ecuador')
------------------------------------------
Backup log Northwind
to disk = 'c:\bases\Northwind.bak'
-------------------------------------------------------------
Insert into Region values(10,'Polo Sur')

Backup log Northwind
to disk = 'c:\bases\Northwind.bak'
with Name = 'Respaldo Log 2'

---------------------------------------------------------
Backup database Northwind
to disk = 'c:\bases\Northwind.bak'
with Name = 'Respaldo Diferencial 4',
Differential

Select * from REgion
Restore headeronly from disk = 'c:\bases\Northwind.bak'

Use Master
go
Drop database Northwind


Use Northwind
go



----------- Restauración de Base de Datos Northwindj

Restore database Northwind
from disk = 'c:\bases\Northwind.bak'
with
File =1,
recovery,
move 'Northwind' to 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER2019\MSSQL\DATA\Northwind.mdf',
move 'Northwind_log' to 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER2019\MSSQL\DATA\Northwind.ldf'

use northwind

select *from region


use master
go

Restore database Northwind
from disk = 'C:\bases\northwind.bak'
with file = 2, ------ posición del archivo a restaurar
Recovery  
 --   restauracion falla

 Use Master
go
Drop database Northwind  -- borramos para intentar de nuevo


Restore database Northwind
from disk = 'c:\bases\Northwind.bak'
with
File =1,
norecovery, -- usamos la opcion norecovery en el full backup para que no falle luego al usar el diferencial
move 'Northwind' to 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER2019\MSSQL\DATA\Northwind.mdf',
move 'Northwind_log' to 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER2019\MSSQL\DATA\Northwind.ldf'


Restore database Northwind
from disk = 'C:\bases\northwind.bak'
with file = 2, ------ posición del archivo a restaurar
norecovery

use northwind

select *from region

 Use Master
go
Restore database Northwind
from disk = 'C:\bases\northwind.bak'
with file = 3, ------ posición del archivo a restaurar
Recovery

--restaurar log (se restauran en secuencia)
 Use Master
go
Restore database Northwind
from disk = 'C:\bases\northwind.bak'
with file = 5, ------ posición del archivo a restaurar
norecovery

Restore database Northwind
from disk = 'C:\bases\northwind.bak'
with file = 6, ------ posición del archivo a restaurar
recovery

use Northwind
select * from Region