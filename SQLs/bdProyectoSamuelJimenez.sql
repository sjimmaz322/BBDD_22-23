Drop database if exists bdProyectoSamuelJimenez;
--
CREATE DATABASE bdProyectoSamuelJimenez;
--
USE bdProyectoSamuelJimenez;
-- Tabla Usuarios
CREATE TABLE usuarios (
    codUsuario INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    edad INT,
    direccion varchar(100),
    fecCumpleanios Date,
    CONSTRAINT pk_usuarios PRIMARY KEY (codUsuario)
);
-- Tabla Jugadores
CREATE TABLE jugadores (
    id INT AUTO_INCREMENT,
    apodo VARCHAR(50),
    sistemaPredilecto VARCHAR(100),
    rolPreferido ENUM('PJ', 'DM'),
    codUsuario INT,
    CONSTRAINT pk_jugadores PRIMARY KEY (id),
    CONSTRAINT fk_jugadores_usuarios FOREIGN KEY (codUsuario)
        REFERENCES usuarios (codUsuario)
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
insert into usuarios(nombre,edad, direccion, fecCumpleanios)values('Samuel Jiménez',29,'Calle Gades 2','1994-01-01');
-- 
insert into jugadores(apodo, sistemaPredilecto, rolPreferido, codUsuario)values('Pache','Anima: Beyond Fantasy','DM',1);
-- 
insert into personajes(nombre, arquetipo,trasfondo,nivel, alineacion, idJugador)values('Zanerius Manosuaves','Bardo','Un viajero con ganas de un buen rato',1,'Caótico neutral',1);
-- 
insert into partidas(nomDirector, nombreCampania, numSesiones, sistema, idPersonaje)values('Pache','El santuario',3,'DnD 5e',1);