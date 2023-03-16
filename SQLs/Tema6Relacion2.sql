-- Tema 6 Relación de ejercicios 2
use empresaclase;
/*
Como el apartado 6 pero generalizado para poder buscar el rango que deseemos.
Como el apartado 7 pero generalizado para poder buscar las extensiones del departamento que queramos.
*/
--
-- Ejercicio 3 : Obtener todos los datos de todos los empleados y el nombre del departamento al que pertenecen.
SELECT 
    empleados.nomem, departamentos.nomde
FROM
    empleados
        JOIN
    departamentos ON empleados.numde = departamentos.numde;
--
-- Ejercicio 4: Obtener la extensión telefónica y el nombre del centro de trabajo de “Juan López”.
SELECT 
    empleados.extelem, centros.nomce
FROM
    empleados
        JOIN
    departamentos ON empleados.numde = departamentos.numde
        JOIN
    centros ON departamentos.numce = centros.numce
WHERE
    empleados.nomem = 'Juan'
        AND empleados.ape1em = 'López';
-- 
-- Ejercicio 5: Obtener el nombre completo y en una sola columna de los empleados del departamento “Personal” y “Finanzas”.
SELECT 
    CONCAT(empleados.ape1em,
            ' ',
            IFNULL(empleados.ape2em, ''),
            ', ',
            empleados.nomem) AS 'Nombre Completo'
FROM
    empleados
        JOIN
    departamentos ON empleados.numde = departamentos.numde
WHERE
    departamentos.nomde = 'Personal'
        OR departamentos.nomde = 'Finanzas';
--
-- Ejercicio 6: Obtener el nombre del director actual del departamento “Personal”.
SELECT 
    CONCAT(empleados.ape1em,
            ' ',
            IFNULL(empleados.ape2em, ''),
            ', ',
            empleados.nomem) AS 'Nombre Completo'
FROM
    empleados
        JOIN
    dirigir ON empleados.numem = dirigir.numempdirec
        JOIN
    departamentos ON dirigir.numdepto = departamentos.numde
WHERE
    departamentos.nomde = 'Personal';
--
-- Ejercicio 7: Obtener el nombre de los departamentos y el presupuesto que están ubicados en la “SEDE CENTRAL”.
SELECT 
    departamentos.nomde, departamentos.presude
FROM
    departamentos
        JOIN
    centros ON departamentos.numce = centros.numce
WHERE
    trim(centros.nomce) = 'SEDE CENTRAL';
-- 
-- Ejercicio 8: Obtener el nombre de los centros de trabajo cuyo presupuesto esté entre 100000 € y 150000 €.
SELECT 
    centros.nomce
FROM
    centros
        JOIN
    departamentos ON centros.numce = departamentos.numce
WHERE
    departamentos.presude >= 100000
        AND departamentos.presude <= 150000;
--
-- Ejercicio 9: Obtener las extensiones telefónicas del departamento “Finanzas”. No deben salir extensiones repetidas.
SELECT 
    distinct empleados.extelem
FROM
    empleados
        JOIN
    departamentos ON empleados.numde = departamentos.numde
WHERE
    departamentos.nomde = 'Finanzas';
--
-- Ejercicio 10: Obtener el nombre completo y en una sola columna de todos los directores que ha tenido el departamento cualquiera.
SELECT 
    CONCAT(empleados.ape1em,
            ' ',
            IFNULL(empleados.ape2em, ''),
            ', ',
            empleados.nomem) AS 'Nombre Completo'
FROM
    empleados
        JOIN
    dirigir ON empleados.numem = dirigir.numempdirec;
-- 
-- Ejercicio 13: Como el apartado 3 pero generalízalo para que podamos buscar los empleados de un solo departamento.
drop procedure if exists encontrarEmpleadoYDepto;
delimiter $$
create procedure encontrarEmpleadoYDepto(in numDepto int)
begin
SELECT 
    empleados.nomem, departamentos.nomde
FROM
    empleados
        JOIN
    departamentos ON empleados.numde = departamentos.numde
    where empleados.numde = numDepto;
end $$
delimiter ;

call encontrarEmpleadoYDepto(112);
--
-- Ejercicio 14: Como el apartado 4. pero generalízalo para buscar el director del departamento que queramos en cada caso.
delimiter $$
drop procedure if exists encontrarDirector$$
create procedure encontrarDirector(in numdepartamento int)
begin
SELECT 
    CONCAT(empleados.ape1em,
            ' ',
            IFNULL(empleados.ape2em, ''),
            ', ',
            empleados.nomem) AS 'Nombre Completo'
FROM
    empleados
        JOIN
    dirigir ON empleados.numem = dirigir.numempdirec
    WHERE dirigir.numdepto = numdepartamento;
end $$
delimiter ;
-- 
call encontrarDirector(112);
--
-- Ejercicio 15: Como el apartado 5 pero generalízalo para buscar por el centro que queramos.