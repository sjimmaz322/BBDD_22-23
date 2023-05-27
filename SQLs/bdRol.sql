DROP DATABASE IF EXISTS bdRol;
CREATE DATABASE bdRol;
USE bdRol;

-- Tabla Usuarios
CREATE TABLE usuarios (
    codUsuario INT AUTO_INCREMENT,
    nombre VARCHAR(50),
    edad INT,
    direccion VARCHAR(100),
    fecCumpleanios DATE,
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
        on update cascade on delete cascade
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
        on update cascade on delete cascade
);
-- 
insert into usuarios
(nombre,edad, direccion, fecCumpleanios)
values
('Samuel Jiménez',29,'Calle Gades 2','1994-01-01'),
('Nacho',41,'Calle Perico','1981-09-19'),
('Alberto',30,'Calle Noria','1993-02-07');
--
insert into jugadores
(apodo, sistemaPredilecto,rolPreferido,codUsuario)
values
('Pache','DnD 5e','DM',1),
('Nachota','RyF','PJ',2),
('Elross','Anima: Beyond Fantasy','PJ',3);
--
insert into personajes
(nombre, arquetipo, trasfondo, nivel, alineacion, idJugador)
values
('Zan','Bardo','Prueba 1', 1,'Good',1),
('Thor','Guerrero','Prueba 2', 1,'Good',1),
('Paulo','Monje','Prueba 3', 1,'Good',1);
--
delimiter $$
create procedure borrarJugadoresSinUsuario()
BEGIN
   delete from jugadores
   where codUsuario is null;
END $$
DELIMITER ;
-- 
delimiter $$
create procedure borrarPersonajesSinJugador()
BEGIN
   delete from personajes
   where idJugador is null;
END $$
DELIMITER ;
--
call borrarPersonajesSinJugador();
call borrarJugadoresSinUsuario(); 
--
delimiter $$
	drop event if exists eliminalNulos $$
    create event eliminaNulos
    on schedule
    every 1 day
    starts curdate()
    do
		begin
			call borrarPersonajesSinJugador();
			call borrarJugadoresSinUsuario(); 
            
        end $$
delimiter ;
--
-- select * from usuarios;