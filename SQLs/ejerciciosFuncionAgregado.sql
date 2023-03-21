use empresaclase;
-- 
-- Count cuenta celdas
SELECT 
    departamentos.numde AS 'Núm Depto',
    departamentos.nomde AS Departamento,
    COUNT(*) AS 'Número de empleados',
    COUNT(DISTINCT (empleados.numde)) AS 'Número departamentos',
    SUM(empleados.salarem) AS 'Coste salarial',
    MAX(empleados.salarem) AS 'Salario máximo',
    MIN(empleados.salarem) AS 'Salario mínimo',
    AVG(empleados.salarem) AS 'Salario medio'
FROM
    empleados
        JOIN
    departamentos ON empleados.numde = departamentos.numde
GROUP BY empleados.numde;

-- Rutina que devuelva el número de extensiones que utiliza un departamentos

drop function if exists getNumExtensionesDepto;
delimiter $$
create function getNumExtensionesDepto(numDeparta int)
returns int
deterministic
begin
declare numExtensiones int;
set numExtensiones = (SELECT 
    
    COUNT(DISTINCT (empleados.extelem)) AS 'Número extensiones'
FROM
    empleados
        JOIN
    departamentos ON empleados.numde = departamentos.numde
    where departamentos.numde = numDeparta
GROUP BY departamentos.numde);

return numExtensiones;
end $$

delimiter ;
--
select getNumExtensionesDepto(112)as extensiones;
