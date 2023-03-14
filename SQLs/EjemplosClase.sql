use empresaclase;
--
-- Averiguar los nombres de los empleados que trabajan en el centro de la Calle Atocha
SELECT 
    empleados.numem,
    empleados.nomem,
    empleados.numde,
    departamentos.numde,
    departamentos.numce,
    centros.numce
FROM
    centros
        JOIN
    departamentos ON centros.numce = departamentos.numce
        JOIN
    empleados ON departamentos.numde = empleados.numde
WHERE
    centros.dirce LIKE '%atocha%';
--
-- Obten una lista de nombres de centros y nombres de departamentos (el departamento en el que están)
SELECT 
    centros.numce, centros.nomce, departamentos.nomde
FROM
    centros
        LEFT JOIN
    departamentos ON centros.numce = departamentos.numce
ORDER BY numce;
-- 
-- Averigua nombre de los empleados y el director del departamento
SELECT 
    centros.nomce AS 'Nom Centro',
    empleados.nomem AS 'Nom Empleado',
    departamentos.nomde AS 'Nom Depto',
    dirigir.numempdirec AS 'Num Director',
    emp.nomem AS Director
FROM
    centros
        JOIN
    departamentos ON centros.numce = departamentos.numce
        JOIN
    empleados ON departamentos.numde = empleados.numde
        JOIN
    dirigir ON departamentos.numde = dirigir.numdepto
        JOIN
    empleados AS emp ON dirigir.numempdirec = emp.numem
WHERE
    fecfindir IS NULL
ORDER BY nomce , nomde , empleados.nomem;
