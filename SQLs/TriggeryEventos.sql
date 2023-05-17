-- Apuntes Triggers y Eventos

-- Triggers: Paso por paso
/*
delimiter $$
Create Trigger (nombre del trigger)
[cuando saltará] before o after + insert, update o delete 
ON (nombre de la tabla donde actua) 
for each row 
begin
[aquí se declara alguna var si se tiene que usar]
if (condición) then
begin

end;

end if;
end$$

delimiter ;
*/
-- EJEMPLO
/*
signals con 01xxx provocan warnings
signals con otro provoca errores
*/
drop trigger mitrigger;
DELIMITER $$
CREATE TRIGGER mitrigger BEFORE UPDATE ON departamentos
FOR EACH ROW
BEGIN
-- 	DECLARE numero int;
	if (new.presude < old.presude) then
		begin
			set new.presude = old.presude;
            -- SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'El presupuesto no se modificará';
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El presupuesto no se modificará';
		end;
	end if;
END $$
DELIMITER ;

UPDATE departamentos 
SET 
    presude = 100
WHERE
    numde = 112;
    
    
/*
EVENTOS PASO A PASO

delimiter $$
create event (nombre)
on schedule
	every (numero) (unidad temporal)
    starts '(fecha de inicio)'
    ends (fecha de fin)
do
	begin
		(llamada a un método o código)
    end $$
    
delimiter ;
*/

-- EJEMPLO
delimiter $$
create procedure subirSueldoAnti()
BEGIN
    UPDATE empleados
    SET salarem = salarem * 1.0005; -- Aumentar el salario en un 0.05%
END $$
DELIMITER ;

delimiter $$
	drop event if exists subidaAntiguedad $$
    create event subidaAntiguedad
    on schedule
    every 1 year
    starts '2023-01-01'
    
    do
		begin
			call subirSueldoAnti();       
        end $$
delimiter ;