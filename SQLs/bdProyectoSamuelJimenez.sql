Drop database if exists bdProyectoSamuelJimenez;
--
CREATE DATABASE bdProyectoSamuelJimenez;
--
USE bdProyectoSamuelJimenez;
-- Tabla Jugadores
CREATE TABLE jugadores (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    apodo VARCHAR(50),
    edad INT,
    CONSTRAINT pk_jugadores PRIMARY KEY (id)
);
-- Tabla Personajes
CREATE TABLE personajes (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(255),
    arquetipo VARCHAR(255),
    trasfondo TEXT,
    nivel INT,
    alineacion VARCHAR(255),
    idJugador INT,
    CONSTRAINT pk_personajes PRIMARY KEY (id),
    CONSTRAINT fk_personajes_jugadores FOREIGN KEY (idJugador)
        REFERENCES jugadores (id)
);
-- Tabla Partidas
CREATE TABLE partidas (
    numPartida INT AUTO_INCREMENT,
    nomDirector VARCHAR(255),
    nombreCampania VARCHAR(255),
    numSesiones INT,
    sistema VARCHAR(255),
    idPersonaje INT,
    CONSTRAINT pk_partidas PRIMARY KEY (numPartida),
    CONSTRAINT fk_partidas_personajes FOREIGN KEY (idPersonaje)
        REFERENCES personajes (id)
);
--
INSERT INTO jugadores (nombre, apodo, edad) VALUES ('Samuel', 'Pache', 29);
-- 
INSERT INTO personajes
(nombre, arquetipo, trasfondo, nivel, alineacion, idJugador)
VALUES 
('Zanerius Manosuaves', 'Bardo', 'Un bardo errante en busca de diversión', 1, 'Caótico neutral', 1);
-- 