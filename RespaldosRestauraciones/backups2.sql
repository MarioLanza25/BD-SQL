

RESTORE DATABASE [northwind] FROM  DISK = N'C:\Respaldos\northwind.bak' WITH  FILE = 1, 
MOVE N'northwind' 
TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER2019\MSSQL\DATA\northwind.mdf',  
MOVE N'northwind_log' 
TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER2019\MSSQL\DATA\northwind_log.ldf',  
NOUNLOAD,  STATS = 5

backup database northwind
to disk= 'C:\Backups\northwind.bak'
with
Name ='northwind backup'

Backup database northwind
to disk = 'C:\Backups\northwind.bak'
With
name = 'northwind Backup Diferencial', Differential

Backup log northwind
to disk = 'C:\Backups\northwind.bak'
With
name = 'northwind Backup Registro de Transacciones'

restore database northwind 
from disk = 'C:\Backups\northwind.bak'
with file =1,
norecovery

drop database northwind

restore headeronly
from disk= 'C:\Backups\northwind.bak'