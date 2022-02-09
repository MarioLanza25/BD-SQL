create database CV

restore database CV from disk='E:\CV.bak' with replace

EXEC sp_attach_db @dbname = N'Northwind', 
    @filename1 = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER2019\MSSQL\Data\Northwind.mdf', 
    @filename2 = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLSERVER2019\MSSQL\Data\Northwind_log.ldf';

use Northwind

go

create sequence ValoresPorDefecto
go

select name, start_value, increment, maximum_value, minimum_value,
is_cycling, type, system_type_id, current_value
From sys.sequences where name ='ValoresPorDefecto'
go