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