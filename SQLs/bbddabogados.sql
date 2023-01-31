DROP DATABASE IF EXISTS abogados;
CREATE DATABASE IF NOT EXISTS abogados;
USE abogados;
-- 
/*
sujetos (PK(codsujeto), nomsujeto, ape1sujeto,ape2sujeto,dni,dirpostal,email,tlfcontacto)
clientela(PK(codcli), codsujeto*, estadocivil)
abogados(PK(codabogado), codsujeto*,numcolegiado)
tiposcasos(PK(codtipocaso),desTipoCaso)
casos(PK(codcaso,codtipocaso*),descaso,codcli*,presupuesto)
AbogadosenCasos(PK[[codcaso,codtipocaso]*,codabogado*,fecinicio], numdias)
*/
CREATE TABLE sujetos (
    codSujeto INT UNSIGNED,
    nomSujeto VARCHAR(20),
    ape1Sujeto VARCHAR(20),
    ape2Sujeto VARCHAR(20) NULL,
    dni CHAR(9),
    dirPostar VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    telefono CHAR(12),
    CONSTRAINT pk_sujetos PRIMARY KEY (codSujeto)
);
-- 
CREATE TABLE clientela (
    codCliente INT UNSIGNED,
    estadoCivil ENUM('S', 'C', 'D', 'V'),
    codSujeto INT UNSIGNED,
    CONSTRAINT pk_clientela PRIMARY KEY (codCliente),
    CONSTRAINT fk_clientela_sujetos FOREIGN KEY (codSujeto)
        REFERENCES sujetos (codSujeto)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
-- 
CREATE TABLE abogados (
    codAbogado INT UNSIGNED,
    numColegiado CHAR(9),
    codSujeto INT UNSIGNED,
    CONSTRAINT pk_abogados PRIMARY KEY (codAbogado),
    CONSTRAINT fk_abogados_sujetos FOREIGN KEY (codSujeto)
        REFERENCES sujetos (codSujeto)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
-- 
CREATE TABLE tipoCasos (
    codTipoCaso INT UNSIGNED,
    desTipoCaso VARCHAR(200),
    CONSTRAINT pk_tipoCasos PRIMARY KEY (codTipoCaso)
);
-- 
CREATE TABLE casos (
    codCaso INT UNSIGNED,
    codTipoCaso INT UNSIGNED,
    desCaso VARCHAR(200),
    codCliente INT UNSIGNED,
    presupuesto DECIMAL(7 , 2 ) UNSIGNED,
    CONSTRAINT pk_casos PRIMARY KEY (codCaso , codTipoCaso),
    CONSTRAINT fk_casos_tipoCasos FOREIGN KEY (codTipoCaso)
        REFERENCES tipoCasos (codTipoCaso)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_cassos_clientela FOREIGN KEY (codCliente)
        REFERENCES clientela (codCliente)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
-- AbogadosenCasos(PK[[codcaso,codtipocaso]*,codabogado*,fecinicio], numdias)
CREATE TABLE abogadosEnCasos (
    codCaso INT UNSIGNED,
    codTipoCaso INT UNSIGNED,
    codAbogado INT UNSIGNED,
    fecInicio DATE,
    numDias INT(1) UNSIGNED,
    CONSTRAINT pk_abgadosEnCasos PRIMARY KEY (codCaso , codTipoCaso , codAbogado , fecInicio),
    CONSTRAINT fk_abogadosEnCasos_casos FOREIGN KEY (codCaso , codTipoCaso)
        REFERENCES casos (codCaso , codTipoCaso)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_abogadosEnCasos_abogados FOREIGN KEY (codAbogado)
        REFERENCES abogados (codAbogado)
        ON DELETE NO ACTION ON UPDATE CASCADE
);