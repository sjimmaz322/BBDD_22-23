drop database if exists bdProyectoSamuelJimenez;
--
create database if not exists bdProyectoSamuelJimenez;
--
use bdProyectoSamuelJimenez;
-- 
CREATE TABLE productos (
    id INT UNSIGNED AUTO_INCREMENT,
    tipo ENUM('Dado', 'Complemento'),
    color VARCHAR(20),
    detalle VARCHAR(100),
    precio DECIMAL(4 , 2 ),
    CONSTRAINT pk_productos PRIMARY KEY (id)
);
--
CREATE TABLE clientes (
    id INT UNSIGNED AUTO_INCREMENT,
    apellidos VARCHAR(50),
    nombre VARCHAR(50),
    apodo VARCHAR(20),
    direccion VARCHAR(100),
    CONSTRAINT pk_clientes PRIMARY KEY (id)
);
--
CREATE TABLE pedidos (
    numPedido INT UNSIGNED AUTO_INCREMENT,
    cliente INT UNSIGNED,
    fecha DATE,
    CONSTRAINT pk_pedidos PRIMARY KEY (numPedido),
    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (cliente)
        REFERENCES clientes (id)
        ON UPDATE CASCADE ON DELETE NO ACTION
);
--
CREATE TABLE infoPedidos (
    idProducto INT UNSIGNED,
    numPedido INT UNSIGNED,
    totalPedido DECIMAL(5 , 2 ),
    CONSTRAINT pk_detallePedidos PRIMARY KEY (idProducto , numPedido),
    CONSTRAINT fk_detallePedidos_productos FOREIGN KEY (idProducto)
        REFERENCES productos (id)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT fk_detallePedidos_pedidos FOREIGN KEY (numPedido)
        REFERENCES pedidos (numPedido)
        ON UPDATE CASCADE ON DELETE NO ACTION
);
--

INSERT INTO productos 
(id, tipo, color,detalle, precio)
VALUES
(1, 'Dado', 'Azul Tinta', 'D4 borde afilado',1.50);
-- 
INSERT INTO clientes
( id, apellidos, nombre, apodo, direccion)
values
(1, 'Jiménez Mazas', 'Samuel', 'Pache', 'C/ Gades 2 Bloque D Bajo 7');
--
INSERT INTO pedidos
(numPedido, cliente, fecha) 
VALUES
(1, 1, '2023-05-11');
-- 