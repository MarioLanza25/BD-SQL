use Northwind

--select * from 

create table RegionPrueba(
	RegionId int primary key identity(1,1) not null,
	RegionDescription nchar(50) not null
)

select * from RegionPrueba
select * from Region

--MERGE
Merge dbo.RegionPrueba as Target
using dbo.Region as Source
on (Target.RegionId = Source.RegionId)

when matched and Target.RegionDescription <> Source.RegionDescription
then update set Target.RegionDescription = Source.RegionDescription

when not matched by target
then insert (RegionId, RegionDescription) values(Source.RegionId, Source.RegionDescription)

when not matched by source
then delete;

---
insert into dbo.Region values(5, '')
go


