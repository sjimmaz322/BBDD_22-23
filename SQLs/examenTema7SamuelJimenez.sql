-- Samuel Alejandro Jiménez Mazas

/*Ejercicio 1*/
DROP PROCEDURE IF EXISTS p1;
delimiter $$
CREATE PROCEDURE p1()
	BEGIN
		SELECT tests.codtest, materias.codmateria
		FROM tests LEFT JOIN materias ON tests.codmateria = materias.codmateria
        WHERE datediff(tests.fecpublic, tests.feccreacion)>3;
	END $$
delimiter ;
--
call p1();
--
/*Ejercicio 2*/
DROP FUNCTION IF EXISTS p2;
delimiter $$
CREATE FUNCTION p2(numAlumn char(12))
RETURNS varchar(20)
DETERMINISTIC
	BEGIN
		DECLARE usuario VARCHAR(20);
        SET usuario = 
        (SELECT concat(lower(left(alumnos.nomalum,1)),''
        ,right(alumnos.nomalum,1),''
        ,substring(alumnos.ape1alum,length(alumnos.ape1alum)/2-1,3),''
        ,dayofmonth(alumnos.fecnacim)
        ,'@micentro.es'
        )
        FROM alumnos
        WHERE alumnos.numexped = numAlumn
        );
	RETURN usuario;
	END $$
delimiter ;
--
SELECT p2(1);
--
/*Ejercicio 3*/
DROP PROCEDURE IF EXISTS p3;
delimiter $$
CREATE PROCEDURE p3(in numAlumn char(12))
	BEGIN
		SELECT numAlumn, count(respuestas.numpreg), respuestas.codtest, respuestas.numrepeticion
        FROM alumnos JOIN respuestas ON alumnos.numexped = respuestas.numexped
					 JOIN preguntas ON respuestas.codtest = preguntas.codtest
		WHERE respuestas.numexped = numAlumn 
			AND respuestas.respuesta = preguntas.resvalida
            AND (SELECT count(respuestas.numpreg)
				FROM respuestas JOIN preguntas ON respuestas.codtest = preguntas.codtest
                WHERE respuestas.numexped = numAlumn ) > 4
        GROUP BY respuestas.codtest, respuestas.numrepeticion
        ORDER BY respuestas.codtest DESC, respuestas.numrepeticion DESC;
    END $$
delimiter ;
--
call p3(1);
--
/*Ejercicio 4*/
DROP PROCEDURE IF EXISTS p4;
delimiter $$
CREATE PROCEDURE p4()
	BEGIN
		SELECT materias.nommateria, materias.cursomateria, respuestas.codtest
        FROM materias join matriculas on materias.codmateria = matriculas.codmateria
					  join alumnos on matriculas.numexped = alumnos.numexped
                      join respuestas on alumnos.numexped = respuestas.numexped
		-- WHERE (SELECT count((respuestas.numexped)))>2
        GROUP BY materias.nommateria, materias.cursomateria, respuestas.codtest
        ORDER BY materias.nommateria, materias.cursomateria;
    END $$
delimiter ;
--
call p4();
--
/*Ejercicio 5*/
DROP PROCEDURE IF EXISTS p5;
delimiter $$
CREATE PROCEDURE p5()
	BEGIN
		SELECT alumnos.numexped, concat(alumnos.ape1alum,' ',ifnull(alumnos.ape2alum,''),', ',alumnos.nomalum)
        FROM alumnos
        WHERE alumnos.numexped NOT IN (SELECT matriculas.numexped
									   FROM materias join matriculas on materias.codmateria = matriculas.codmateria)
                                        AND alumnos.numexped IN (
                                        SELECT respuestas.numexped
                                        from respuestas)
                                        ;
    END $$
delimiter ;
--
call p5();
--
/*Ejercicio 6*/
DROP VIEW IF EXISTS catTest;
CREATE VIEW catTest as 

	(
    SELECT materias.codmateria, materias.nommateria, tests.codtest, tests.descrip, preguntas.resvalida,   
		count(distinct(preguntas.numpreg)), if(tests.repetible=1,'Repetible','No repetible')
    FROM materias join tests on materias.codmateria = tests.codtest
				  join preguntas on tests.codtest = preguntas.codtest
	GROUP BY materias.codmateria, materias.nommateria, tests.codtest, tests.descrip, preguntas.resvalida
    );
--
select * from catTest;
--
/*Ejercicio 7*/