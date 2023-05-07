drop database if exists bdProg;
--
create database if not exists bdProg;
--
use bdProg;
-- 
CREATE TABLE productos (
    id INT,
    descripcion VARCHAR(50),
    precio DECIMAL(4,2),
    CONSTRAINT pk_productos PRIMARY KEY (id)
);