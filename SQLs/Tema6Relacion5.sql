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