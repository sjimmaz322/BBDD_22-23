use empresaclase;
-- 
-- Count cuenta celdas
select count(*) as 'Número de empleados', count(distinct(empleados.numde))as 'Número departamentos'
-- select count(empleados.numem)
from empleados;
-- 
select sum(empleados.salarem) as 'Coste salarial'
from empleados;