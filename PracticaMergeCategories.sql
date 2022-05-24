use Northwind

create table UpdateCategories(
	CategoryID int primary key identity(1,1) not null,
	CategoryName nvarchar(15) not null,
	Description ntext null,
	Picture image null
)

select * from dbo.Categories

Merge UpdateCategories as Target
using Categories as Source
on (Target.CategoryID =Source.CategoryID)

when matched then update set
Target.CategoryName = Source.CategoryName,
Target.Description = Source.Description,
Target.Picture = Source.Picture

when not matched by Target
then insert (CategoryName, Description, Picture) values (Source.CategoryName, Source.Description, Source.Picture)

when not matched by Source
then delete;

select * from Categories
select * from UpdateCategories

insert into Categories values('cccc', 'eeff', '')
go

insert into UpdateCategories values('', 'cdcd', '')
