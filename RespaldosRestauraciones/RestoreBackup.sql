--Restore database Adventureworks
--from disk = 'C:\Respaldos\AdventureWorks2019.bak'
--with file = 1, ------ posición del archivo a restaurar
--noRecovery

RESTORE DATABASE [AdventureWorks2019] FROM  DISK = N'C:\Respaldos\AdventureWorks2019.bak' WITH  FILE = 1, 
MOVE N'AdventureWorks2017' 
TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER2019\MSSQL\DATA\AdventureWorks2019.mdf',  
MOVE N'AdventureWorks2017_log' 
TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER2019\MSSQL\DATA\AdventureWorks2019_log.ldf',  
NOUNLOAD,  STATS = 5

GO

use AdventureWorks2019
--Restauracion full
--Carpeta vacia
backup database AdventureWorks2019
to disk= 'E:\Backups\AdventureWorks2019.bak'
with
Name ='AdventureWorks2019 backup'

Backup database AdventureWorks2019
to disk = 'E:\Backups\AdventureWorks2019.bak'
With
name = 'AdventureWorks2019 Backup Diferencial', Differential

Backup log AdventureWorks2012
to disk = 'E:\Backups\AdventureWorks2019.bak'
With
name = 'AdventureWorks2019 Backup Registro de Transacciones'

