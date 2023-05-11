drop database ProyectoSintaxis;
--
create database ProyectoSintaxis;
--
use ProyectoSintaxis;
--
CREATE TABLE IF NOT EXISTS Estructura (
    codEstructura INT,
    desEstructura VARCHAR(200),
    CONSTRAINT PK_Estructura PRIMARY KEY (codEstructura)
);
--
CREATE TABLE IF NOT EXISTS NaturalezaPredicado (
    codNaturalezaPredi INT,
    vozVerbo VARCHAR(30),
    verboCopulativo BOOLEAN,
    transitividad BOOLEAN,
    CONSTRAINT PK_NaturalezaPredicado PRIMARY KEY (codNaturalezaPredi)
);
--
CREATE TABLE IF NOT EXISTS ActitudHablante (
    codActitudHablante INT,
    desActitudHablante VARCHAR(200),
    CONSTRAINT PK_ActitudHablante PRIMARY KEY (codActitudHablante)
);
--
CREATE TABLE IF NOT EXISTS Enunciado (
    codEnunciado INT UNSIGNED,
    codEstructura INT,
    codNaturalezaPredi INT,
    texto VARCHAR(200) NOT NULL,
    tipo ENUM('Frase', 'Oración'),
    CONSTRAINT PK_Enunciado PRIMARY KEY (codEnunciado)
);
--
CREATE TABLE IF NOT EXISTS detalleActitud (
    codActitudHablante INT,
    descActitud VARCHAR(200),
    CONSTRAINT PK_detalleActitud PRIMARY KEY (codActitudHablante)
);  
--
-- Insersión de datos (Al no haber relaciones el orden de insersión de los datos en las tablas no importa)
--
insert into Estructura
(codEstructura, desEstructura)
values
(1,'Bimembre, separable en sujeto y predicado'),
(2,'Unimembre, no separable en sujeto y predicado');
--
insert into detalleActitud
(codActitudHablante, descActitud)
values
(1,'Enunciativa'),
(2,'Interrogativa'),
(3,'Exclamativas'),
(4,'Desiderativas'),
(5,'Dubitativas'),
(6,'Exhoratativas');
--
insert into ActitudHablante
(codActitudHablante,desActitudHablante)
values
(1,'Son las que usamos para transmitir información de manera objetiva.'),
(2,'El hablante realiza una pregunta.'),
(3,'El hablante transmite emociones y sentimientos. Van entre signos de exclamación para dar un mayor énfasis a la expresión.'),
(4,'El hablante manifiesta un deseo o sueño (en ocasiones van entre signos de exclamación como las exclamativas).'),
(5,'Con ellas expresamos dudas acerca de lo que decimos.'),
(6,'El hablante indica o expresa órdenes, reomendaciones o prohibiciones.');
-- 