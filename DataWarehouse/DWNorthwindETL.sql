create database DWNorthwind2022
--restore database DWNorthwind2022 from disk='C:\DWNorthwind2022.bak' with replace
RESTORE DATABASE [DWNorthwind2022] FROM  DISK = N'C:\DWNorthwind2022.bak' WITH  FILE = 1, 
MOVE N'DWNorthwind2022' 
TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER2019\MSSQL\DATA\DWNorthwind2022.mdf',  
MOVE N'DWNorthwind2022_log' 
TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER2019\MSSQL\DATA\DWNorthwind2022_log.ldf',  
NOUNLOAD,  STATS = 5

use DWNorthwind2022

select * from dbo.DimProducts
select * from dbo.DimCategories
select * from dbo.DimFechas
select * from dbo.DimSuppliers
select * from dbo.HechosVentas

--Consulta para la dimension fecha
select distinct DimFechaID as IDFecha,
				year (DimFechaID) as Anio,	
				month (DimFechaID) as noMes,
				day (DimFechaID) as Dia,
				DATEname (WEEKDAY,DimFechaID) as NombreDia,
				DATEname (MONTH,DimFechaID) as NombreMes,
				DATEpart (QQ, DimFechaID) AS trimestre
from dbo.HechosVentas