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
        ON DELETE CASCADE ON UPDATE CASCADE
);
-- 
CREATE TABLE abogados (
    codAbogado INT UNSIGNED,
    numColegiado CHAR(9),
    codSujeto INT UNSIGNED,
    CONSTRAINT pk_abogados PRIMARY KEY (codAbogado),
    CONSTRAINT fk_abogados_sujetos FOREIGN KEY (codSujeto)
        REFERENCES sujetos (codSujeto)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
-- 
CREATE TABLE tipoCasos (
    codTipoCasos INT UNSIGNED,
    desTipoCaso VARCHAR(200),
    CONSTRAINT pk_tipoCasos PRIMARY KEY (codTipoCasos)
);
-- 
CREATE TABLE casos (
    codCaso INT UNSIGNED,
    codTipoCasos INT UNSIGNED,
    desCaso VARCHAR(200),
    codCliente INT UNSIGNED,
    presupuesto DECIMAL(7 , 2 ) UNSIGNED,
    CONSTRAINT pk_casos PRIMARY KEY (codCaso , codTipoCasos),
    CONSTRAINT fk_casos_tipoCasos FOREIGN KEY (codTipoCasos)
        REFERENCES tipoCasos (codTipoCasos)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_casos_clientela FOREIGN KEY (codCliente)
        REFERENCES clientela (codCliente)
        ON DELETE CASCADE ON UPDATE CASCADE
);
-- AbogadosenCasos(PK[[codcaso,codtipocaso]*,codabogado*,fecinicio], numdias)
CREATE TABLE abogadosEnCasos (
    codCaso INT UNSIGNED,
    codTipoCasos INT UNSIGNED,
    codAbogado INT UNSIGNED,
    fecInicio DATE,
    numDias INT(1) UNSIGNED,
    CONSTRAINT pk_abogadosEnCasos PRIMARY KEY (codCaso , codTipoCasos , codAbogado , fecInicio),
    CONSTRAINT fk_abogadosEnCasos_casos FOREIGN KEY (codCaso , codTipoCasos)
        REFERENCES casos (codCaso , codTipoCasos)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_abogadosEnCasos_abogados FOREIGN KEY (codAbogado)
        REFERENCES abogados (codAbogado)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
-- 
ALTER TABLE abogadosEnCasos
	DROP FOREIGN KEY fk_abogadosEnCasos_casos,
	DROP PRIMARY KEY;
--  
ALTER TABLE casos
	DROP CONSTRAINT fk_casos_tipocasos,
	ADD COLUMN tipoCaso SET('Civil','Penal','Laboral','Admin','Familiar') AFTER codCaso;
-- 
