DROP DATABASE IF EXISTS BDCLASES2;
CREATE DATABASE IF NOT EXISTS BDCLASES2;
USE BDCLASES2;

CREATE TABLE IF NOT EXISTS departamentos  (
    codDepto INT UNSIGNED,
    numDepto INT UNSIGNED,
    CONSTRAINT PK_departamentos PRIMARY KEY (codDepto)
);

CREATE TABLE IF NOT EXISTS profesores (
    codDepto INT UNSIGNED,
    codProfesor INT UNSIGNED,
    nomProfesor VARCHAR(20),
    ape1Profesor VARCHAR(20),
    ape2Profesoer VARCHAR(20) NULL,
    fecIncorporacion DATE,
    salario DECIMAL(6 , 2 ),
    codPostar CHAR(5),
    telefono CHAR(9),
    jefe INT UNSIGNED,
    CONSTRAINT PK_profesores_departamentos PRIMARY KEY (codProfesor , codDepto),
    CONSTRAINT FK_profesores_departamentos FOREIGN KEY (codDepto)
        REFERENCES departamentos (codDepto)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_profesores_profesores FOREIGN KEY (jefe)
        REFERENCES profesores (codProfesor)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS asignaturas (
    codAsignatura INT UNSIGNED,
    nomAsignatura VARCHAR(20),
    curso VARCHAR(20),
    CONSTRAINT pk_asignaturas PRIMARY KEY (codAsignatura)
);


CREATE TABLE IF NOT EXISTS impartir (
    codAsignatura INT UNSIGNED,
    codDepto INT UNSIGNED,
    codProfesor INT UNSIGNED,
    observaciones VARCHAR(500),
    CONSTRAINT PK_impartir Primary key (codAsignatura, codDepto, codProfesor),
    CONSTRAINT FK_impartir_asignaturas FOREIGN KEY (codAsignatura)
        REFERENCES asignaturas (codAsignatura)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_impartir_profesores FOREIGN KEY (codDepto , codProfesor)
        REFERENCES profesores (codDepto , codProfesor)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
