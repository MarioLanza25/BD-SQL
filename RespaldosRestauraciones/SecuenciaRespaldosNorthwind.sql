
--Desvincular BD
sp_detach_db Northwind
--Vincular BD
sp_attach_db Northwind,
'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER2019\MSSQL\DATA\northwnd.mdf',
'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER2019\MSSQL\DATA\northwnd.ldf'

--backup full
Backup database Northwind
to disk ='C:\Respaldos\Northwind.bak'
with name ='Respaldo full', copy_only

sp_helpdb Northwind

--Info del backup
Restore headeronly
from disk = 'C:\Respaldos\Northwind.bak'

--Respaldo diferencial
Backup database Northwind
to disk ='C:\Respaldos\Northwind.bak'
with name ='Respaldo diferencial',
Differential

use Northwind

create procedure ListaRegiones
as
select * from Region

select * from Territories
select * from Region
insert into Region values(5, 'CentroAmerica')

--Nuevo respaldo diferencial
Backup database Northwind
to disk ='C:\Respaldos\Northwind.bak'
with name ='Respaldo diferencial 2',
Differential

insert into Region values(6, 'Sur America')
insert into Region values(7, 'Norte America')

--NuevoDiferencial
Backup database Northwind
to disk ='C:\Respaldos\Northwind.bak'
with name ='Respaldo diferencial 3',
Differential

insert into Region values(8, 'Region Central')
insert into Region values(9, 'Ecuador')

--Backup log para transacciones
Backup log Northwind
to disk ='C:\Respaldos\Northwind.bak'

insert into Region values(10, 'Polo sur')
listaRegiones

--Nuevo respaldo log
Backup log Northwind
to disk = 'C:\Respaldos\Northwind.bak'
with name = 'Respaldo log 2'

--UltimoDiferencial
Backup database Northwind
to disk ='C:\Respaldos\Northwind.bak'
with name ='Respaldo diferencial 4',
Differential

--Info sobre los backups
restore headeronly
from disk = 'C:\Respaldos\Northwind.bak'

use master
go
drop database Northwind

--Restauracion
restore database Northwind
from disk = 'C:\Respaldos\Northwind.bak'
with
file =1,
recovery
--Opcion norecovery para no permitir operaciones

--Solo recuperada copia full 1
use Northwind
select * from Region

--Restauracion 2
use master
go
restore database Northwind
from disk = 'C:\Respaldos\Northwind.bak'
with
file =2,
recovery