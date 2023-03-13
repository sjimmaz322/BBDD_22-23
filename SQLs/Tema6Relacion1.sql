-- Tema 6 relación de ejercicios 1
use empresaclase;
--
-- 1 - Obtener todos los datos de todos los empleados.
SELECT 
    *
FROM
    empleados;
--
-- 2 - Obtener la extensión telefónica de “Juan López”.
SELECT 
    extelem
FROM
    empleados
WHERE
    nomem = 'Juan' AND ape1em = 'López';
-- 

-- 
-- 3 - Obtener el nombre completo de los empleados que tienen más de un hijo.
SELECT 
    ape1em, ape2em, nomem
FROM
    empleados
WHERE
    ifnull(numhiem,0) > 1;
--
-- 4 - Obtener el nombre completo y en una sola columna de los empleados que tienen entre 1 y 3 hijos.
SELECT 
    CONCAT(ape1em,
            ' ',
            IFNULL(ape2em, ''),
            ', ',
            nomem) AS 'Nombre completo'
FROM
    empleados
WHERE
    ifnull(numhiem,0) >= 1 AND ifnull(numhiem,0) <= 3;
-- 
-- 5 - Obtener el nombre completo y en una sola columna de los empleados sin comisión.
SELECT 
    CONCAT(ape1em,
            ' ',
            IFNULL(ape2em, ''),
            ', ',
            nomem) AS 'Nombre completo'
FROM
    empleados
WHERE
    ifnull(comisem,0) = 0;
--
-- 6 - Obtener la dirección del centro de trabajo “Sede Central”.
SELECT 
    dirce
FROM
    centros
WHERE
    nomce = ' SEDE CENTRAL';
-- 
-- 7 - Obtener el nombre de los departamentos que tienen más de 6000 € de presupuesto.
SELECT 
    nomde
FROM
    departamentos
WHERE
    presude > 6000;
-- 
-- 8 - Obtener el nombre de los departamentos que tienen de presupuesto 6000 € o más.
SELECT 
    nomde
FROM
    departamentos
WHERE
    presude >= 6000;
-- 
-- 9 - Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa más de 1 año. (Añade filas nuevas para poder comprobar que tu consulta funciona).
SELECT 
    CONCAT(ape1em,
            ' ',
            IFNULL(ape2em, ''),
            ', ',
            nomem) AS 'Nombre completo'
FROM
    empleados
WHERE
    fecinem < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
--
-- 10 - Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa entre 1 y tres años. (Añade filas nuevas para poder comprobar que tu consulta funciona).
SELECT 
    CONCAT(ape1em,
            ' ',
            IFNULL(ape2em, ''),
            ', ',
            nomem) AS 'Nombre completo'
FROM
    empleados
WHERE
    fecinem BETWEEN DATE_SUB(CURDATE(), INTERVAL 3 YEAR) AND DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
    
--
--
--
-- Ejemplo de procedure ejercicio 12
delimiter $$
drop procedure if exists buscarExtelem $$
create procedure buscarExtelem (nombre varchar(60),apellido1 varchar(60))
begin
SELECT 
    extelem
FROM
    empleados
WHERE
    nomem = nombre AND ape1em = apellido1;
end $$
delimiter ;
-- 
call buscarExtelem("Juan","López");
--
--
-- 11 - Prepara un procedimiento almacenado que ejecute la consulta del apartado 1 y otro que ejecute la del apartado 5.
start transaction;
delimiter $$
drop procedure if exists mostrarEmpleados $$
create procedure mostrarEmpleados()
begin
select * from empleados;
end $$
--
drop procedure if exists mostrarEmpleadosSinComision $$
create procedure mostrarEmpleadosSinComision()
begin
SELECT 
    CONCAT(ape1em,
            ' ',
            IFNULL(ape2em, ''),
            ', ',
            nomem) AS 'Nombre completo'
FROM
    empleados
WHERE
    ifnull(comisem,0) = 0;
end $$

delimiter ;
commit;
--
call mostrarEmpleados();
call mostrarEmpleadosSinComision();
--
-- 13 - Prepara un procedimiento almacenado que ejecute la consulta del apartado 3 y otro para la del apartado 4 de forma que nos sirva para averiguar el nombre de aquellos que tengan el número de hijos que deseemos en cada caso.
Start transaction;
delimiter $$
drop procedure if exists mostrarEmpleadosConNHijos $$
create procedure mostrarEmpleadosConNHijos(in numHijos int)
begin
select  CONCAT(ape1em,
            ' ',
            IFNULL(ape2em, ''),
            ', ',
            nomem) AS 'Nombre completo'
from empleados
where numhiem > numHijos;
end $$
--
drop procedure if exists mostrarEmpleadosConXHijos $$
create procedure mostrarEmpleadosConXHijos(numHijosMin int, numHijosMax int)
begin
select  CONCAT(ape1em,
            ' ',
            IFNULL(ape2em, ''),
            ', ',
            nomem) AS 'Nombre completo'
from empleados
where numhiem > numHijosMin and numhiem < numHijosMax;
end $$
delimiter ;
commit;
--
call mostrarEmpleadosConNHijos(2);
call mostrarEmpleadosConXHijos(1,3);
--
-- 14 - Prepara un procedimiento almacenado que, dado el nombre de un centro de trabajo, nos devuelva su dirección.
delimiter $$
drop procedure if exists mostrarDireccionCentro $$
create procedure mostrarDireccionCentro(nomCentro varchar(60))
begin
select dirce as Dirección
from centros
where nomce = nomcentro;
end $$
delimiter ;
--
call mostrarDireccionCentro(' SEDE CENTRAL');
--
-- 15 - Prepara un procedimiento almacenado que ejecute la consulta del apartado 7 de forma que nos sirva para averiguar, dada una cantidad, el nombre de los departamentos que tienen un presupuesto superior a dicha cantidad.
delimiter $$
drop procedure if exists mostrarDeptosConPresupuestoSuperiorA $$
create procedure mostrarDeptosConPresupuestoSuperiorA(presupuesto decimal(10,2))
begin
select nomde
from departamentos
where presude > presupuesto;
end $$
delimiter ;
--
call mostrarDeptosConPresupuestoSuperiorA(60000.00);
--
-- 16 - Prepara un procedimiento almacenado que ejecute la consulta del apartado 8 de forma que nos sirva para averiguar, dada una cantidad, el nombre de los departamentos que tienen un presupuesto igual o superior a dicha cantidad.
delimiter $$
drop procedure if exists mostrarDeptosConPresupuestoSuperiorOIgualA $$
create procedure mostrarDeptosConPresupuestoSuperiorOIgualA(presupuesto decimal(10,2))
begin
select nomde
from departamentos
where presude >= presupuesto;
end $$
delimiter ;
--
call mostrarDeptosConPresupuestoSuperiorOIgualA(6000.00);
--
-- 17 - Prepara un procedimiento almacenado que ejecute la consulta del apartado 9 de forma que nos sirva para averiguar, dada una fecha,
-- el nombre completo y en una sola columna de los empleados que llevan trabajando con nosotros desde esa fecha.
delimiter $$
drop procedure if exists mostrarEmpleadosContratadosDespuesDe $$
create procedure mostrarEmpleadosContratadosDespuesDe (fecha Date)
begin
select  CONCAT(ape1em,
            ' ',
            IFNULL(ape2em, ''),
            ', ',
            nomem) AS 'Nombre completo'
from empleados
where fecinem > fecha;
end$$
delimiter ;
--
call mostrarEmpleadosContratadosDespuesDe('2000-1-1');
--
-- 18 - Prepara un procedimiento almacenado que ejecute la consulta del apartado 10 de forma que nos sirva para averiguar, dadas dos fechas,
-- el nombre completo y en una sola columna de los empleados que comenzaron a trabajar con nosotros en el periodo de tiempo comprendido entre esas dos fechas.
delimiter $$
drop procedure if exists mostrarEmpleadosContratadosEntre $$
create procedure mostrarEmpleadosContratadosEntre (fechaMin date, fechaMax date)
begin
select  CONCAT(ape1em,
            ' ',
            IFNULL(ape2em, ''),
            ', ',
            nomem) AS 'Nombre completo'
from empleados
where fecinem between fechaMin and fechaMax;
end$$
delimiter ;
--
call mostrarEmpleadosContratadosEntre('2020-1-1','2022-1-1');
--
-- 19 - Prepara un procedimiento almacenado que ejecute la consulta del apartado 10 de forma que nos sirva para averiguar, dadas dos fechas,
-- el nombre completo y en una sola columna de los empleados que comenzaron a trabajar con nosotros fuera del periodo de tiempo comprendido entre esas dos fechas.
delimiter $$
drop procedure if exists mostrarEmpleadosContratadosFueraDe $$
create procedure mostrarEmpleadosContratadosFueraDe (fechaMin date, fechaMax date)
begin
select  CONCAT(ape1em,
            ' ',
            IFNULL(ape2em, ''),
            ', ',
            nomem) AS 'Nombre completo'
from empleados
where fecinem not between fechaMin and fechaMax;
end$$
delimiter ;
--
call mostrarEmpleadosContratadosFueraDe('2020-1-1','2022-1-1');
--

/*El ejercicio 2 lo hacemos como función*/
-- Vemos como hacer funciones
-- Se llaman únicamente poniendo el nombre de la función
delimiter $$
drop function if exists conseguirExtelem $$
create function conseguirExtelem(
nombre varchar(60), apellido varchar(60)
)

returns char(3)
DETERMINISTIC
begin

declare extension char(3);
/*
select extelem into extension
from empleados
where nomem = nombre and ape1em = apellido;
*/

set extension =(select extelem
from empleados
where nomem = nombre and ape1em = apellido);

return extension;
/*
return(
select extelem
from empleados
where nomem = nombre and ape1em = apellido);
*/

end $$
delimiter ;

-- 
/*
Funciones solo devuelven un valor, procedimientos pueden devolver N valores
*/

-- Ejercicio 2 como un procedimiento que devuelve un valor
delimiter $$
drop procedure if exists ejDevolExtProc$$
create procedure ejDevolExtProc(in nombreEm varchar(60),
in apellidoEm varchar(60),out extension char(3))
begin
set extension = (select extelem from empleados where
nomem = nombreEm and ape1em = apellidoEm);
end $$

delimiter ;

-- 
call ejDevolExtProc('Juan','López', @extEm);
select @extEm;