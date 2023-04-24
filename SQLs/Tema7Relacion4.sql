-- Tema 7 relación 4
use empresaclase;
/* EJER 26 */
drop procedure if exists proc_ejer_6_4_26;
delimiter $$

create procedure proc_ejer_6_4_26()
begin
	-- call proc_ejer_6_4_26();
    -- el ejercicio pide que los borremos, pero, para verlo vamos a hacer una selección:
	/*select numem
	from empleados 
    where salarem >= (select avg(salarem)
					  from empleados as e
                      where e.numde = empleados.numde);
	*/
    -- HAGAMOS AHORA EL BORRADO COMO PIDE EL EJERCICIO
    delete from empleados 
    where salarem >= (select avg(salarem)
					  from empleados as e
                      where e.numde = empleados.numde);
end $$
delimiter ;

/* EJER 27 */
drop procedure if exists proc_ejer_6_4_27;
delimiter $$

create procedure proc_ejer_6_4_27()
begin
	-- call proc_ejer_6_4_27();
    -- el ejercicio pide que actualicemos, pero, para verlo vamos a hacer una selección:
	/*select numem
	from empleados 
    where salarem > 0.50*(select max(salarem)
					  from empleados as e
                      where e.numde = empleados.numde);
	*/
    -- HAGAMOS AHORA LA ACTUALIZACIÓN COMO PIDE EL EJERCICIO
    update empleados 
    set salarem = salarem*0.95
    where salarem > 0.50*(select max(salarem)
					  from empleados as e
                      where e.numde = empleados.numde);
end $$
delimiter ;
-- 40 - Para la base de datos de turismo rural, queremos obtener las casas disponibles para una zona y un rango de fecha dados.
drop procedure if exists ejer40;
delimiter $$
create procedure ejer40(fecha1 date, fecha2 date, codigoZona int)
begin
select casas.codcasa, casas.codzona
from casas 
where codcasa not in (
			select codcasa from reservas
            where fecanulacion is null and (feciniestancia between fecha1 and fecha2)
			or adddate(feciniestancia, interval numdiasestancia day) not between fecha1 and fecha2)
            and codzona = codigoZona;
end $$
delimiter ;
-- 