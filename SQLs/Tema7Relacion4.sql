-- Tema 7 relación 4
use empresaclase;
-- 26 - Borrar de la tabla EMPLEADOS a los empleados cuyo salario (sin incluir la comisión) supere al salario medio de los empleados de su departamento.
DROP PROCEDURE IF EXISTS ejer26;
DELIMITER $$
CREATE PROCEDURE ejer26(IN numDepart INT)
BEGIN
	DECLARE avg_salary DECIMAL(10, 2);
	
	SELECT AVG(salarem)
	INTO avg_salary
	FROM empleados
	WHERE numde = numDepart;
	
	DELETE FROM empleados
	WHERE numde = numDepart 
	AND salarem - IFNULL(comisem, 0) > avg_salary;
END$$
DELIMITER ;

CALL ejer26(122);

-- 27 - Disminuir en la tabla EMPLEADOS un 5% el salario de los empleados que superan el 50% del salario máximo de su departamento.

DROP PROCEDURE IF EXISTS ejer27;
DELIMITER $$
CREATE PROCEDURE ejer27(IN numDepart INT)
BEGIN
	DECLARE max_salary DECIMAL(10, 2);
	
	SELECT MAX(salarem)
	INTO max_salary
	FROM empleados
	WHERE numde = numDepart;
	
	UPDATE empleados
    set salarem = salarem-(salarem*0.05)
	WHERE numde = numDepart 
	AND salarem > (max_salary/2);
END$$
DELIMITER ;

CALL ejer27(100);

-- 40 - Para la base de datos de turismo rural, queremos obtener las casas disponibles para una zona y un rango de fecha dados.

use gbdturrural2015;
DROP PROCEDURE IF EXISTS ejer40;
DELIMITER $$
CREATE PROCEDURE ejer40(IN fecha1 date, in fecha2 date)
BEGIN
	select reservas.codcasa, casas.codzona
	from reservas join casas on reservas.codcasa = casas.codcasa
	where reservas.fecreserva not between fecha1 and fecha2;
END$$
DELIMITER ;

CALL ejer40('2012-01-01','2012-01-31');
