-- Unidad 7 relación de ejercicio nº6
/*
EJERCICIO 1:

Para la base de datos “empresa_clase” obtener, dado el código de un empleado, la contraseña de
acceso formada por:
i. Inicial del nombre + 10 caracteres. (11)
ii. Tres primeras letras del primer apellido + 5 caracteres. (8)
iii. Tres primeras letras del segundo apellido (o “LMN” en caso de no tener 2o
apellido) + 5 caracteres. (8)
iv. El último dígito del dni (sin la letra). (1)

La contraseña es un char(28)
*/

-- NO FUNCIONA!!!
drop function if exists tem7ejer1rel6;
delimiter $$
create function tem7ejer1rel6(idEmp int)
	returns char(28)
	deterministic
	begin
	RETURN (
        SELECT CONCAT(
            CHAR(ASCII(LEFT(empleados.nomem, 1)) + 10),
            CHAR(ASCII(SUBSTRING(empleados.ape1em, 1, 3)) + 5),
            CHAR(ASCII((SUBSTRING(empleados.ape2em, 1,3), 'LMN')) + 5)
        )
        FROM empleados
        WHERE numem = idEmp
    );
	end $$
delimiter ;
-- 
select tem7ejer1rel6(110);

-- Relación 4: 40, 26 y 27 para mañana, opcionales 22, 23, 30, 16, 17

/*

*/