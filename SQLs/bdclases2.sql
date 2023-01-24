DROP DATABASE IF EXISTS BDCLASES2;
CREATE DATABASE IF NOT EXISTS BDCLASES2;
USE BDCLASES2;

-- Ejercicio 2

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

-- Ejercicio 3 -- Almacén

CREATE TABLE IF NOT EXISTS categorias (
    codCat INT UNSIGNED,
    nomCategoria VARCHAR(20),
    proveedor VARCHAR(30),
    CONSTRAINT PK_categoria PRIMARY KEY (codCat)
);

CREATE TABLE IF NOT EXISTS productos (
    refProd INT UNSIGNED,
    descrip VARCHAR(50),
    precioBase DECIMAL(10 , 2 ),
    precioVenta DECIMAL(10 , 2 ),
    CONSTRAINT PK_productos PRIMARY KEY (refProd)
);

CREATE TABLE IF NOT EXISTS ventas (
    codVenta INT UNSIGNED,
    fecVenta DATE,
    cliente VARCHAR(30),
    CONSTRAINT PK_ventas PRIMARY KEY (codVenta)
);

CREATE TABLE IF NOT EXISTS lin_ventas (
    codVenta INT UNSIGNED,
    refProd INT UNSIGNED,
    cantidad INT UNSIGNED,
    CONSTRAINT pk_lin_ventas PRIMARY KEY (codVenta , refProd),
    CONSTRAINT fk_lin_ventas_ventas FOREIGN KEY (codVenta)
        REFERENCES ventas (codVenta)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_lin_ventas_productos FOREIGN KEY (refProd)
        REFERENCES productos (refProd)
        ON DELETE NO ACTION ON UPDATE CASCADE
); 
-- 
ALTER TABLE productos
	ADD COLUMN codCat INT UNSIGNED AFTER refProd,
    ADD CONSTRAINT fk_productos_categorias FOREIGN KEY (codCat)
    REFERENCES categorias(codCat)
    ON DELETE NO ACTION ON UPDATE CASCADE;
-- 
ALTER TABLE lin_ventas
	DROP CONSTRAINT fk_lin_ventas_productos;
-- 
ALTER TABLE productos
	DROP PRIMARY KEY,
    ADD CONSTRAINT pk_productos PRIMARY KEY (refProd, codCat);
--
ALTER TABLE lin_ventas
	ADD COLUMN codCat INT UNSIGNED,
    DROP INDEX fk_lin_ventas_productos,
    ADD CONSTRAINT fk_lin_ventas_productos FOREIGN KEY (refProd, codCat)
		REFERENCES productos (refProd, codCat)
		ON DELETE NO ACTION ON UPDATE CASCADE,
	DROP CONSTRAINT fk_lin_ventas_ventas,
    DROP PRIMARY KEY,
    ADD CONSTRAINT pk_lin_ventas PRIMARY KEY (refProd, codCat, codVenta),
    ADD CONSTRAINT fk_linventas_ventas FOREIGN KEY (codVenta)
		REFERENCES ventas (codVenta)
        ON DELETE NO ACTION ON UPDATE CASCADE;
	

