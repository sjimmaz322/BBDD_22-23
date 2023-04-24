-- Simulacro examen Tema 7
use ventapromoscompleta;
/*Ejercicio 1*/
-- Queremos saber el importe de las ventas de artículos a cada uno de nuestros clientes (muestra el nombre).
-- Queremos que cada cliente se muestre una sola vez y que aquellos a los que hayamos vendido más se muestren primero.

drop procedure if exists ej1;
delimiter $$
create procedure ej1()
	begin
		
        select concat(ape1cli,' ',ifnull(ape2cli,''),', ',nomcli) as 'Nombre Cliente', sum(detalleventa.precioventa) as 'Total Venta'
        from clientes 
			join ventas on clientes.codcli = ventas.codcli
			join detalleventa on ventas.codventa = detalleventa.codventa
		group by concat(ape1cli,' ',ifnull(ape2cli,''),', ',nomcli)
        order by sum(detalleventa.precioventa) desc;
        
	end $$
delimiter ;
-- 
call ej1();
-- 
/*Ejercicio 2*/
-- Muestra un listado de todos los artículos vendidos, queremos mostrar la descripción del artículo y entre paréntesis la descripción de la categoría
-- a la que pertenecen y la fecha de la venta con el formato “march - 2016, 1 (tuesday)”. 
-- Haz que se muestren todos los artículos de la misma categoría juntos.
drop procedure if exists ej2;
delimiter $$
create procedure ej2()
	
    begin
    
		select articulos.refart, articulos.desart,concat(' (',categorias.descat,')'),ventas.fecventa
			from categorias 
			join articulos on categorias.codcat = articulos.codcat
			join detalleventa on articulos.refart = detalleventa.refart
			join ventas on detalleventa.codventa = ventas.codventa
            order by categorias.descat
		;
        
    end $$

delimiter ;
-- 
call ej2();
--
/*Ejercicio 3*/
-- Obtener el precio medio de los artículos de cada promoción (muestra la descripción de la promoción) del año 2012.
-- (Se usará en el ejercicio 7).
drop procedure if exists ej3;
delimiter $$
create procedure ej3(in anio int)

	begin
		select avg(catalogospromos.precioartpromo) as 'Precio medio'
        from catalogospromos 
        join promociones on catalogospromos.codpromo = promociones.codpromo
        where year(promociones.fecinipromo) = anio;
		
	end $$

delimiter ;
--
call ej3(2012);
-- 
/*Ejercicio 4*/
-- Prepara una rutina que muestre un listado de artículos, su referencia, su nombre y la categoría
-- que no hayan estado en ninguna promoción que haya empezado en este año.