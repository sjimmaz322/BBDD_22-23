DROP DATABASE IF EXISTS BDCLASES;
CREATE DATABASE IF NOT EXISTS BDCLASES;
USE BDCLASES;

CREATE TABLE departamentos (
    codDepto INT UNSIGNED,
    numDepto INT UNSIGNED,
    CONSTRAINT PK_departamentos PRIMARY KEY (codDepto)
);

CREATE TABLE profesores (
    codDepto INT UNSIGNED,
    codProfesor INT UNSIGNED,
    nomProfesor VARCHAR(50),
    fecIncorporacion DATE,
    salario DECIMAL(6 , 2 ),
    codPostar CHAR(5),
    telefono CHAR(9),
    CONSTRAINT PK_profesores PRIMARY KEY (codProfesor , codDepto),
    CONSTRAINT FK_profesores_departamentos FOREIGN KEY (codDepto)
        REFERENCES departamentos (codDepto)
);

CREATE TABLE asignaturas (
    codAsignatura INT UNSIGNED,
    nomAsignatura VARCHAR(20),
    curso VARCHAR(20),
    CONSTRAINT pk_asignaturas PRIMARY KEY (codAsignatura)
);

CREATE TABLE impartir (
    codAsignatura INT UNSIGNED,
    codDepto INT UNSIGNED,
    codProfesor INT UNSIGNED,
    observaciones VARCHAR(500),
    CONSTRAINT FK_impartir_asignaturas FOREIGN KEY (codAsignatura)
        REFERENCES asignaturas (codAsignatura),
    CONSTRAINT FK_impartir_profesores FOREIGN KEY (codDepto , codProfesor)
        REFERENCES profesores (codDepto , codProfesor)
);