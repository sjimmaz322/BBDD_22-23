DROP DATABASE IF EXISTS p81SamuelJimenez;
--
CREATE DATABASE IF NOT EXISTS p81SamuelJimenez;
--
USE p81SamuelJimenez;
--
CREATE TABLE facturas(
codigoUnico int,
fechaEmision DATE,
descripcion varchar(30),
totalImporte DECIMAL(6,2),
constraint pk_facturas PRIMARY KEY (codigoUnico)
);
--
Select * from facturas;