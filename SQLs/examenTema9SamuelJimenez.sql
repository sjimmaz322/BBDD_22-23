/*Samuel Alejandro Jiménez Mazas*/
-- EXAMEN UNIDAD 9
USE GBDgestionaTests;
-- 
-- PREGUNTA 1
-- 
drop trigger if exists p1Insersion;
DELIMITER $$
CREATE TRIGGER p1Insersion BEFORE INSERT ON preguntas
FOR EACH ROW
BEGIN
	if (new.numpreg in (select preguntas.numpreg from preguntas where codtest = new.codtest) ) then
		begin
			SIGNAL SQLSTATE '04500' SET MESSAGE_TEXT = 'No puede haber preguntas repetidas';
		end;
	end if;
END $$
DELIMITER ;
--
INSERT INTO preguntas VALUES (1,3,'5 + 7','-2','12','0','b');
-- 
drop trigger if exists p1Mod;
DELIMITER $$
CREATE TRIGGER p1Mod BEFORE UPDATE ON preguntas
FOR EACH ROW
BEGIN
	if ((old.textopreg = new.textopreg) and (old.resvalida = new.resvalida)) then
		begin
        
        set new.textopreg = old.textopreg,
        new.resvalida = old.resvalida;
			
			SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'No se puede duplicar una pregunta mediante modificación';
		end;
	end if;
END $$
DELIMITER ;
-- 
update preguntas 
set textopreg = '5 + 7',
resvalida = 'b'
where codtest = 3;
-- 
-- PREGUNTA 2
--
delimiter $$
create event bonoTest
on schedule
	every 1 year
    starts '2023-06-20'
    ends date_add('2023-06-20', interval 10 year)
do
	begin
		-- Se comenta la llamada por no ser un método realmente creado
		-- incrementaNotas();
    end $$
delimiter ;
-- 
-- PREGUNTA 3
-- 
drop trigger if exists p3;
DELIMITER $$
CREATE TRIGGER p3 BEFORE UPDATE ON matriculas
FOR EACH ROW
BEGIN
	if (new.nota > 10) then
		begin
        set new.nota = 10;			
			SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'La nota no puede superar el 10';
		end;
	end if;
END $$
DELIMITER ;
-- 
update matriculas
set nota = 11
where numexped = 1;
-- 
-- PREGUNTA 5
-- 
drop trigger if exists p4;
DELIMITER $$
CREATE TRIGGER p4 BEFORE INSERT ON alumnos
FOR EACH ROW
BEGIN

	if (length(new.nomuser)<6 or (new.nomuser not regexp  '(^[a-z0-9]+)([=_?!]{1})')) then
		begin
			SIGNAL SQLSTATE '04500' SET MESSAGE_TEXT = 'Nombre de usuario no válido';
		end;
        
        
	if (new.email not regexp  '(^[a-z]*[0-9]*)(@)(%)(\.[a-z]{3})') then
		begin
			SIGNAL SQLSTATE '04500' SET MESSAGE_TEXT = 'Email no válido';
		end;
        
    if (new.telefono not regexp '(^[6|7|9]{1}[0-9]{2}) ([0-9]{3}) ([0-9]{3})') then
		begin
			SIGNAL SQLSTATE '04500' SET MESSAGE_TEXT = 'Formato de teléfono no válido';
		end;
    end if;
    end if;
	end if;
END $$
DELIMITER ;
-- 
delete from alumnos where numexped = 70;
--
INSERT INTO alumnos 
(`numexped`, `email`, `telefono`, `nomuser`)
VALUES 
('70', '132456798@hotmail.com', '987 654 321', 'alumnoa');
--
-- PREGUNTA 5
-- 
drop trigger if exists p5;
DELIMITER $$
CREATE TRIGGER p5 BEFORE INSERT ON preguntas
FOR EACH ROW
BEGIN
	if ((new.resa = new.resb) or (new.resb = new.resc) or (new.resc = new.resa) ) then
		begin
			SIGNAL SQLSTATE '04500' SET MESSAGE_TEXT = 'No puede haber respuestas repetidas en una misma pregunta';
		end;
	end if;
END $$
DELIMITER ;
-- 
delete from preguntas where codtest = 1 and numpreg = 6;
--
insert into preguntas
(codtest, numpreg, textopreg, resa, resb, resc, resvalida)
values
-- (1,6, '1 + 1'.'2','2','2','a');
(1,6,'1 + 1 ','2','6','6','a');