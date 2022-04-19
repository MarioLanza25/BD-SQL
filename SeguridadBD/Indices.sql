use master
go
create database Cementerio

use Cementerio

select * from Cementerio

insert into Cementerio values(1, 'Inversiones', 'CieloAzul', 'Carretera leon', 'Leon')
insert into Cementerio values(2, 'Cementerio', 'Eden', 'Carretera masaya', 'masaya')
insert into Cementerio values(3, 'Cementerio', 'DulceDescanso', 'km 9 carretera sebaco', 'Casares')
insert into Cementerio values(4, 'Inversiones', 'Sierras de Paz', 'km 14 carretera', 'Managua')

update Cementerio set Comuna='Masaya' where IDCementerio=2

CREATE UNIQUE INDEX uix_cemeneterioON Cementerio(IDCementerio DESC);--{,<nombre_campo> [ASC | DESC]}) );
