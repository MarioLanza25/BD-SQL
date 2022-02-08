use CV

--Tablas temporales Manipular cierta info de tiempo limitada para

--Tabla temporal local, valido dentro de este servidor de BD
create table #Usuarios(
Id_Usuario int identity(1,1) primary key not null,
NombreUsuario nvarchar(25) not null,
Contraseña varbinary(8000) not null
)

insert into #Usuarios values('Mario', 101010)

select * from #Usuarios

--Global para todo tipo de escenarios o servidor
create table ##Usuarios(
Id_Usuario int identity(1,1) primary key not null,
NombreUsuario nvarchar(25) not null,
Contraseña varbinary(8000) not null
)

insert into ##Usuarios values('Mario', 101010)

select * from ##Usuarios

--Tabala temp con manejo de sistemas
CREATE TABLE dbo.Employee   
(    
  [EmployeeID] int NOT NULL PRIMARY KEY CLUSTERED   
  , [Name] nvarchar(100) NOT NULL  
  , [Position] varchar(100) NOT NULL   
  , [Department] varchar(100) NOT NULL  
  , [Address] nvarchar(1024) NOT NULL  
  , [AnnualSalary] decimal (10,2) NOT NULL  
  , [ValidFrom] datetime2 (2) GENERATED ALWAYS AS ROW START  
  , [ValidTo] datetime2 (2) GENERATED ALWAYS AS ROW END  
  , PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)  
 )    
 WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.EmployeeHistory));  

 --Crear tabla cte Cliente y proveedor

 CREATE TABLE dbo.Clientestmp   
(    
  [EmployeeID] int NOT NULL PRIMARY KEY CLUSTERED   
  , [Name] nvarchar(100) NOT NULL  
  , [Position] varchar(100) NOT NULL   
  , [Department] varchar(100) NOT NULL  
  , [Address] nvarchar(1024) NOT NULL  
  , [AnnualSalary] decimal (10,2) NOT NULL  
  , [ValidFrom] datetime2 (2) GENERATED ALWAYS AS ROW START  
  , [ValidTo] datetime2 (2) GENERATED ALWAYS AS ROW END  
  , PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)  
 )    
 WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.ClientestmpHistory));  