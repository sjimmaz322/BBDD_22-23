DROP DATABASE IF EXISTS repaso6feb;
CREATE DATABASE IF NOT EXISTS repaso6feb;
USE repaso6feb;
-- 
/*
ciudadanos([idCiu], nomCiu, ape1Ciu, ape2Ciu,dirCiu);
deptos ([idDepto], nomDepto, presupuesto);
profesores ([idProf, idDepto*], idCiu*,fecIncorporacion);
grupos([codGrupo],nomGrupo);
alumno([idAlum],idCiu*,codGrupo*, fecIngreso);
asignaturas([codAsignatura],nomAsignatura, horasSemanales);
imparten([(idProf,idDepto)*,codAsignatura*,codGrupo*], anioAcademico);
*/
-- 
CREATE TABLE IF NOT EXISTS ciudadanos (
    idCiu INT UNSIGNED,
    nomCiu VARCHAR(30),
    ape1 VARCHAR(30),
    ape2 VARCHAR(30) NULL,
    dirCiu VARCHAR(100),
    CONSTRAINT pk_ciudadanos PRIMARY KEY (idCiu)
);
-- 
CREATE TABLE IF NOT EXISTS deptos (
    idDepto INT UNSIGNED,
    nomDepto VARCHAR(20),
    presupuesto DECIMAL(7 , 2 ),
    CONSTRAINT pk_deptos PRIMARY KEY (idDepto)
);
-- 
CREATE TABLE IF NOT EXISTS profesores (
    idProf INT UNSIGNED,
    idDepto INT UNSIGNED,
    idCiu INT UNSIGNED,
    fecIncorporacion DATE,
    CONSTRAINT pk_profesores PRIMARY KEY (idprof , idDepto),
    CONSTRAINT fk_profesores_depto FOREIGN KEY (idDepto)
        REFERENCES deptos (idDepto)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_profesores_ciudadanos FOREIGN KEY (idCiu)
        REFERENCES ciudadanos (idCiu)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
-- 
CREATE TABLE IF NOT EXISTS grupos (
    codGrupo INT UNSIGNED,
    nomGrupo VARCHAR(30),
    CONSTRAINT pk_grupos PRIMARY KEY (codGrupo)
);
-- 
CREATE TABLE IF NOT EXISTS alumnos (
    idAlum INT UNSIGNED,
    idCiu INT UNSIGNED,
    codGrupo INT UNSIGNED,
    fecIncorporacion DATE,
    CONSTRAINT pk_alumnos PRIMARY KEY (idAlum),
    CONSTRAINT fk_alumnos_ciudadanos FOREIGN KEY (idCiu)
        REFERENCES ciudadanos (idCiu)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_alumnos_grupos FOREIGN KEY (codGrupo)
        REFERENCES grupos (codGrupo)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
-- 
CREATE TABLE IF NOT EXISTS asignaturas (
    codAsignatura INT UNSIGNED,
    nomAsignatura VARCHAR(30),
    CONSTRAINT pk_asignaturas PRIMARY KEY (codAsignatura)
);
-- 
CREATE TABLE IF NOT EXISTS imparten (
    idProf INT UNSIGNED,
    idDepto INT UNSIGNED,
    codAsignatura INT UNSIGNED,
    codGrupo INT UNSIGNED,
    anioAcademico CHAR(4),
    CONSTRAINT pk_imparten PRIMARY KEY (idProf , idDepto , codAsignatura , codGrupo),
    CONSTRAINT fk_imparten_profesores FOREIGN KEY (idProf , idDepto)
        REFERENCES profesores (idProf , idDepto)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_imparten_asignaturas FOREIGN KEY (codAsignatura)
        REFERENCES asignaturas (codAsignatura)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_imparten_grupo FOREIGN KEY (codGrupo)
        REFERENCES grupos (codGrupo)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
-- 
/*
ALTER TABLE profesores
	ADD COLUMN codGrupoTut int unsigned,
	ADD CONSTRAINT fk_profesores_grupos FOREIGN KEY (codGrupoTut) 
		REFERENCES grupos(idGrupo) 
        ON DELETE NO ACTION ON UPDATE CASCADE;
*/
-- 
ALTER TABLE grupos
	ADD COLUMN profTutor int unsigned,
	ADD COLUMN deptoTutor int unsigned,
	ADD CONSTRAINT fk_grupos_profesores FOREIGN KEY (profTutor,deptoTutor) 
		REFERENCES profesores (idProf,idDepto) 
		ON DELETE NO ACTION ON UPDATE CASCADE;
-- 