-- Samue Alejandro Jiménez Mazas
-- 20 de marzo de 2023
use empresaclase;
-- 
-- 1. Prepara una rutina que, dado el número de un departamento, devuelva el presupuesto del mismo.

drop function if exists getPresuDepto;
delimiter $$
create function getPresuDepto(numDepto int)
--
returns int
deterministic
--
begin
--
declare presupuesto int;
	set presupuesto = (SELECT 
    departamentos.presude
FROM
    departamentos
WHERE
    departamentos.numde = numdepto);
--
return presupuesto;
--
end $$
--
delimiter ;
--
select getPresuDepto(110) as Presupuesto;
--
-- 2. Prepara una rutina que, dado el número de un empleado, nos devuelva la fecha de ingreso en la empresa y el numero de su director/a.

drop procedure if exists getFechaYDirectEm;
delimiter $$
create procedure getFechaYDirectEm(in numEmpleado int, out fecIngreso date, out numDirector int, out nomDirector varchar(20))
begin

set fecIngreso = (SELECT 
    empleados.fecinem
FROM
    empleados
WHERE
    empleados.numem = numEmpleado);

set numDirector = (SELECT 
    dirigir.numempdirec
FROM
    dirigir
        JOIN
    departamentos ON dirigir.numdepto = departamentos.numde
        JOIN
    empleados ON departamentos.numde = empleados.numde
WHERE
    empleados.numem = numEmpleado);

set nomDirector = (select empleados.nomem from empleados where empleados.numem = numDirector);
end$$



delimiter ;
-- 
call getFechaYDirectEm(130, @fecha, @numero, @nombre);

select concat('Empezó el',@fecha,' - el número de su director es ', @numero,' - y el nombre de su director es ', @nombre);
--
-- 3. Prepara una rutina que nos devuelva el nombre de todos los empleados y el nombre del último departamento que ha dirigido (si es que  ha dirigido alguno)

delimiter $$
drop procedure if exists getEmpleadosYDirecciones $$
create procedure getEmpleadosYDirecciones ()
begin
	
    SELECT 
    empleados.nomem,
    departamentos.nomde,
    dirigir.fecinidir,
    dirigir.fecfindir
FROM
    empleados
        LEFT JOIN
    dirigir ON empleados.numem = dirigir.numempdirec
        LEFT JOIN
    departamentos ON dirigir.numdepto = departamentos.numde
    where dirigir.numdepto = (select d1.numdepto
							  from dirigir as d1
							  where d1.numdepto = dirigir.numdepto
                              order by d1.fecinidir desc
                              limit 1) or dirigir.numdepto is null
	
    order by empleados.nomem;
end $$
delimiter ;
--
call getEmpleadosYDirecciones();