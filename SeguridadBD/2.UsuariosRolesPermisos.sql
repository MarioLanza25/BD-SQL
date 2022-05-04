use Northwind

create role Auditoria
--Permiso de lectura para todos los esquemas de la base de datos
--Permiso de ejecucion de todos los sp
--Permiso de creacion de vistas en esquema Sales
grant select on schema :: Sales to Auditoria
grant select on schema :: Customer to Auditoria
grant select on schema :: Supplier to Auditoria
grant select on schema :: Product to Auditoria
grant select on schema :: Person to Auditoria
grant select on schema :: Proceds to Auditoria

grant execute on schema :: Proceds to Auditoria

grant create view to Auditoria

--Crear login Auditor
use master 
go
create login Auditor with password = 'auditor123'Must_change,
Check_expiration = on,
Check_policy=on;

--Ejecutar codigo para reestablecer password al primer ingreso
--------------------------------------------------------------------------------------------------------------
SELECT SL.name AS LoginName
      ,LOGINPROPERTY (SL.name, 'PasswordLastSetTime') AS PasswordLastSetTime
      ,LOGINPROPERTY (SL.name, 'DaysUntilExpiration') AS DaysUntilExpiration
         ,DATEADD(dd, CONVERT(int, LOGINPROPERTY (SL.name, 'DaysUntilExpiration'))
                    , CONVERT(datetime, LOGINPROPERTY (SL.name, 'PasswordLastSetTime'))) AS PasswordExpiration
      ,SL.is_policy_checked AS IsPolicyChecked
      ,LOGINPROPERTY (SL.name, 'IsExpired') AS IsExpired
      ,LOGINPROPERTY (SL.name, 'IsMustChange') AS IsMustChange
      ,LOGINPROPERTY (SL.name, 'IsLocked') AS IsLocked
      ,LOGINPROPERTY (SL.name, 'LockoutTime') AS LockoutTime
      ,LOGINPROPERTY (SL.name, 'BadPasswordCount') AS BadPasswordCount
      ,LOGINPROPERTY (SL.name, 'BadPasswordTime') AS BadPasswordTime
      ,LOGINPROPERTY (SL.name, 'HistoryLength') AS HistoryLength
FROM sys.sql_logins AS SL
WHERE is_expiration_checked = 1
ORDER BY LOGINPROPERTY (SL.name, 'PasswordLastSetTime') DESC 

--sp_addrolemember 'role', 'usuario'

--Creando usuario Revisor con role Auditoria
use Northwind
go
create user Revisor from login Auditor
go
execute sp_addrolemember Auditoria, Revisor 

--Revisar permisos del usuario revisor
sp_helprotect null, Revisor
--Revisar roles asignados
sp_helplogins Revisor