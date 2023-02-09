DROP DATABASE IF EXISTS museo;
CREATE DATABASE IF NOT EXISTS museo;
USE museo;
-- 
CREATE TABLE IF NOT EXISTS empleados (
    codEmpleado INT UNSIGNED,
    nomEmpleado VARCHAR(30),
    ape1Empleado VARCHAR(30),
    ape2Empleado VARCHAR(30) NULL,
    fechIncorporacion DATE,
    CONSTRAINT PK_empleados PRIMARY KEY (codEmpleado)
);
-- 
CREATE TABLE IF NOT EXISTS artistas (
    codArtista INT UNSIGNED,
    nomArtista VARCHAR(50),
    fecNacimiento DATE,
    fecFallecimiento DATE,
    biografia text,
    CONSTRAINT PK_artistas PRIMARY KEY (codArtista)
);
-- 
CREATE TABLE IF NOT EXISTS estilos (
    codEstilo INT UNSIGNED,
    nomEstilo VARCHAR(50),
    augeEpoca VARCHAR(30),
    CONSTRAINT PK_estilos PRIMARY KEY (codEstilo)
);
-- 
CREATE TABLE IF NOT EXISTS salas (
    codSala INT UNSIGNED,
    nomSala VARCHAR(20),
    mCuadrados INT UNSIGNED,
    CONSTRAINT PK_salas PRIMARY KEY (codSala)
);
-- 
CREATE TABLE IF NOT EXISTS seguridad (
    codSeguridad INT UNSIGNED,
    nomEmpresa VARCHAR(20),
    codEmpleado INT UNSIGNED,
    codSala INT UNSIGNED,
    CONSTRAINT PK_seguridad PRIMARY KEY (codSeguridad),
    CONSTRAINT FK_seguridad_empleados FOREIGN KEY (codEmpleado)
        REFERENCES empleados (codEmpleado)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_seguridad_salas FOREIGN KEY (codSala)
        REFERENCES salas (codSala)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
-- 
CREATE TABLE IF NOT EXISTS restauradores (
    codRestaurador INT UNSIGNED,
    especialidad VARCHAR(20),
    codEmpleado INT UNSIGNED,
    CONSTRAINT PK_restauradores PRIMARY KEY (codRestaurador),
    CONSTRAINT FK_restauradores_empleados FOREIGN KEY (codEmpleado)
        REFERENCES empleados (codEmpleado)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
-- 
CREATE TABLE IF NOT EXISTS tipoObras (
    tipoObra VARCHAR(20),
    observaciones VARCHAR(200),
    CONSTRAINT PK_tipoObras PRIMARY KEY (tipoObra)
);
-- 
CREATE TABLE IF NOT EXISTS obras (
    codObra INT UNSIGNED,
    tipoObra VARCHAR(20),
    nomObra VARCHAR(50),
    codArtista INT UNSIGNED,
    codEstilo INT UNSIGNED,
    codSala INT UNSIGNED,
    CONSTRAINT PK_obras PRIMARY KEY (codObra),
    CONSTRAINT FK_obras_tipoObras FOREIGN KEY (tipoObra)
        REFERENCES tipoObras (tipoObra)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_obras_artistas FOREIGN KEY (codArtista)
        REFERENCES artistas (codArtista)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_obras_estilos FOREIGN KEY (codEstilo)
        REFERENCES estilos (codEstilo)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_obras_salas FOREIGN KEY (codSala)
        REFERENCES salas (codSala)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
-- 
CREATE TABLE IF NOT EXISTS restauraciones (
    codObra INT UNSIGNED,
    codRestaurador INT UNSIGNED,
    fecInicioRest DATE,
    fecFinREst DATE,
    observaciones VARCHAR(200),
    CONSTRAINT PF_restauraciones PRIMARY KEY (codObra , codRestaurador, fecInicioRest),
    CONSTRAINT FK_restauraciones_obra FOREIGN KEY (codObra)
        REFERENCES obras (codObra)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_restauraciones_restauradores FOREIGN KEY (codRestaurador)
        REFERENCES restauradores (codRestaurador)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
-- 
ALTER TABLE seguridad
	DROP COLUMN codSala,
    DROP FOREIGN KEY FK_seguridad_salas;
-- 
CREATE TABLE turnos (
    codTurno INT UNSIGNED,
    tipoTurno VARCHAR(6),
    CONSTRAINT PK_turnos PRIMARY KEY (codTurno)
);
-- 
CREATE TABLE detalleTurno (
    codSeguridad INT UNSIGNED,
    codSala INT UNSIGNED,
    codTurno INT UNSIGNED,
    fecInicioTurno DATE,
    fecFinTurno DATE,
    CONSTRAINT pk_detalleTurno PRIMARY KEY (codSeguridad , codSala , codTurno, fecInicioTurno),
    CONSTRAINT fk_detalleTurno_seguridad FOREIGN KEY (codSeguridad)
        REFERENCES seguridad (codSeguridad)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_detalleTurno_sala FOREIGN KEY (codSala)
        REFERENCES salas (codSala)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_detalleTurno_turnos FOREIGN KEY (codTurno)
        REFERENCES turnos (codTurno)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
-- 
ALTER TABLE restauradores
DROP FOREIGN KEY FK_restauradores_empleados,
ADD CONSTRAINT FK_restauradores_emple FOREIGN KEY (codEmpleado)
        REFERENCES empleados (codEmpleado)
        ON DELETE NO ACTION ON UPDATE CASCADE;
--
CREATE TABLE departamentos (
    codDepto INT UNSIGNED,
    nomDepto VARCHAR(30),
    CONSTRAINT PK_departamentos PRIMARY KEY (codDepto)
);
-- 
ALTER TABLE empleados
ADD COLUMN codDepto INT UNSIGNED,
ADD CONSTRAINT FK_empleados_departamentos FOREIGN KEY (codDepto)
	REFERENCES departamentos (codDepto)
	ON DELETE NO ACTION ON UPDATE CASCADE;
-- 
/*
Para el lunes:
Cambiar a la opción B de jerarquías.
Tareas Classroom.
*/
-- 
ALTER TABLE restauradores
DROP FOREIGN KEY FK_restauradores_emple,
ADD CONSTRAINT FK_restauradores_empleados FOREIGN KEY (codEmpleado)
	REFERENCES empleados (codEmpleado)
	ON DELETE CASCADE ON UPDATE CASCADE;
    
ALTER TABLE seguridad
DROP FOREIGN KEY FK_seguridad_empleados,
ADD CONSTRAINT FK_seguridad_empleado FOREIGN KEY (codEmpleado)
    REFERENCES empleados (codEmpleado)
    ON DELETE NO ACTION ON UPDATE CASCADE;
-- 
ALTER TABLE obras
DROP FOREIGN KEY FK_obras_tipoObras,
ADD CONSTRAINT FK_obras_tipoObra FOREIGN KEY (tipoObra)
	REFERENCES tipoObras (tipoObra)
	ON DELETE NO ACTION ON UPDATE SET NUll;
-- 
ALTER TABLE obras
DROP FOREIGN KEY FK_obras_artistas,
ADD CONSTRAINT FK_obras_artista FOREIGN KEY (codArtista)
	REFERENCES artistas (codArtista)
    ON DELETE SET NULL ON UPDATE CASCADE;
-- 
ALTER TABLE obras
DROP CONSTRAINT FK_obras_artista,
ADD CONSTRAINT FK_obras_artistas FOREIGN KEY (codArtista)
	REFERENCES artistas (codArtista)
    ON DELETE SET NULL ON UPDATE NO ACTION;
-- 
INSERT INTO estilos
(codEstilo,nomEstilo,augeEpoca)
VALUES
(1,'Barroco','Siglo XV'),
(2,'Neoclásico','Siglo XVI'),
(3,'Románico','Siglo V');
-- 
SELECT * FROM estilos;
-- 
DELETE FROM estilos 
WHERE
    codEstilo = 2;
-- 
SELECT * FROM estilos;
-- 
UPDATE estilos 
SET 
    codEstilo = 2
WHERE
    codEstilo = 3;
-- 
SELECT * FROM estilos;
-- 