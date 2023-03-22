-- Tema 6 Relación de Ejercicios 5
USE bdalmacen;
-- 
/* Ejercicio 1: Obtener todos los productos que comiencen por una letra determinada.*/
delimiter $$
drop procedure if exists descProductFor $$
create procedure descProductFor(in letra char(1))
begin
	SELECT *
		FROM productos
		WHERE descripcion LIKE CONCAT(letra,'%');-- Usamos concat para unir la variable con el caracter especial
end $$
delimiter ;
--
call descProductFor('C');
--
/* Ejercicio 2: Se ha diseñado un sistema para que los proveedores puedan acceder a ciertos datos,
 la contraseña que se les da es el teléfono de la empresa al revés.
 Se pide elaborar un procedimiento almacenado que dado un proveedor obtenga su contraseña y la muestre en los resultados.
*/
delimiter $$
drop function if exists getPasswordFrom $$
create function getPasswordFrom(codeP int)
	returns char(9)
	deterministic
begin
	declare passw char(9);
    
    set passw =reverse((select proveedores.telefono
    from proveedores
    where proveedores.codproveedor = codeP));
    
    return passw;
end $$
delimiter ;
--
select getPasswordFrom(1) as 'Password';
--
/* Ejercicio 3: Obtener el mes previsto de entrega para los pedidos que no se han recibido aún y para una categoría determinada.*/
delimiter $$
drop procedure if exists getMonthFromNonRecievedDeliveries $$
create procedure getMonthFromNonRecievedDeliveries(in category int)
begin
	select distinct monthname(pedidos.fecentrega), productos.codcategoria
    from pedidos join productos on pedidos.codproducto = productos.codproducto
    join categorias on productos.codcategoria = category
    where MONTH(fecentrega) > MONTH(curdate());
end $$

delimiter ;
--
call getMonthFromNonRecievedDeliveries(1);
--
/* Ejercicio 4: Obtener un listado con todos los productos, ordenados por categoría, en el que se muestre solo las tres primeras letras de la categoría.*/

delimiter $$
drop procedure if exists getProductInfo $$
create procedure getProductInfo()
begin
	select productos.descripcion, left(categorias.Nomcategoria,3) 
    from productos join categorias on productos.codcategoria = categorias.codcategoria
    order by productos.codcategoria;
end $$
delimiter ;
--
call getProductInfo();

/* Ejercicio 5: Obtener el cuadrado y el cubo de los precios de los productos.*/
delimiter $$
drop procedure if exists getPowCube $$
create procedure getPowCube()

begin
select productos.preciounidad as Precio,(productos.preciounidad*productos.preciounidad) as 'Cuadrado Precio',(productos.preciounidad*productos.preciounidad*productos.preciounidad) as 'Cuadrado Cubo'
from productos;
end $$

delimiter ;
-- 
call getPowCube();

/* Ejercicio 6: Devuelve la fecha del mes actual.*/

delimiter $$
drop function if exists getMes $$
create function getMes()
returns int
deterministic
begin
declare mes int;
set mes = month(curdate());
return mes;
end $$

delimiter ;
--
select getMes();

/* Ejercicio 7: Para los pedidos entregados el mismo mes que el actual, obtener cuantos días hace que se entregaron.*/
delimiter $$
drop procedure if exists getProductosMes $$
create procedure getProductosMes()
begin
select datediff(curdate(),pedidos.fecentrega)
from pedidos
where month(pedidos.fecentrega) =month(curdate());

end $$
delimiter ;
--
call getProductosMes();

/*Ejercicio 9: Obtener la población del código postal de los proveedores (los primeros dos caracteres se refieren a la provincia y los tres últimos a la población).*/
delimiter $$
drop procedure if exists getPoblacion$$
create procedure getPoblacion()
begin
	select substring(proveedores.codpostal,3,5) as Poblacion
    from proveedores;
end $$

delimiter ;
--
call getPoblacion();

/*Ejercicio 10: Obtén el número de productos de cada categoría, haz que el nombre de la categoría se muestre en mayúsculas.*/
delimiter $$
drop procedure if exists getNumProdPerCat$$
create procedure getNumProdPerCat()
begin
	select count(productos.codproducto), upper(categorias.Nomcategoria)
    from productos join categorias on productos.codcategoria = categorias.codcategoria
    group by categorias.Nomcategoria;
end $$

delimiter ;
--
call getNumProdPerCat();

/*Ejercicio 11: Obtén un listado de productos por categoría y dentro de cada categoría del nombre de producto más corto al más largo.*/
delimiter $$
drop procedure if exists getNomProdPerCat$$
create procedure getNomProdPerCat()
begin 
select  categorias.Nomcategoria,productos.descripcion
from productos join categorias
on productos.codcategoria = categorias.codcategoria
order by length(productos.descripcion) asc;
end $$
delimiter ;
-- 
call getNomProdPerCat();

/* Ejercicio 12: Asegúrate de que los nombres de los productos no tengan espacios en blanco al principio o al final de dicho nombre. */
delimiter $$
drop procedure if exists trimear $$
create procedure trimear()
begin
select trim(productos.descripcion) from productos;
end $$
delimiter ;
--
call trimear();

/*Ejercicio 13: Lo mismo que en el ejercicio 2, pero ahora, además, sustituye el 4 y 5 número del resultado por las 2 últimas letras del nombre de la empresa.*/
/*
delimiter $$
drop function if exists getNewPassword $$
create function getNewPassword(codeP int)
	returns char(9)
	deterministic
begin
	declare passw char(9);
	declare empresa char(2);
    
    set passw =reverse((select proveedores.telefono
    from proveedores
    where proveedores.codproveedor = codeP));
    
    set empresa = substring((select proveedores.nomempresa from proveedores),length(nomempresa)-1,length(nomempresa));
    
    set passw = concat(substring(passw,1,3),empresa,substring(pass,6,length(passw)));
    
    return passw;
end $$
delimiter ;
--
select getNewPassword(1);
*/

/* Ejercicio 14: Obtén el 10 por ciento del precio de los productos redondeados a dos decimales.*/
delimiter $$
drop procedure if exists get10Percent$$
create procedure get10PErcent()
 select truncate((preciounidad*0.1),2) as '10 porciento precio'
 from productos;
end $$
delimiter ;
-- 
call get10Percent();

/* Ejercicio 15: Muestra un listado de productos en que aparezca el nombre del producto y el código de producto y el de categoría repetidos (por ejemplo para la tarta de azucar se mostrará “623623”).*/
delimiter $$
drop procedure if exists ej15$$
create procedure ej15()
begin
select productos.descripcion, concat(productos.codproducto, productos.codcategoria) from productos
where productos.codcategoria = productos.codproducto;
end $$
delimiter ;
-- 
call ej15();