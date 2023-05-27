-- Insersión de datos 
--
insert into Estructura
	(codEstructura, desEstructura)
values
	(1,'Personal'),
	(2,'Impersonal');
--
insert into NaturalezaPredicado
	(codNaturalezaPredi, vozVerbo,verboCopulativo, transitividad)
values
	(1, 'pasiva', true, true),
    (2, 'activa', false, false),
    (3, 'pasiva', false, true),
    (4, 'pasiva', true, false),
    (5, 'activa', true, true),
    (6, 'pasiva', false, false),
    (7, 'activa', false, true),
    (8, 'activa', true, false);
--
insert into ActitudHablante
	(codActitudHablante,desActitudHablante)
values
	(1, 'Negativa'),
	(2,'Afirmativa'),
	(3,'Exclamativa'),
	(4,'Interrogativa'),
	(5,'Desiderativa'),
	(6,'Dubitativa'),
	(7,'Exhortatuva o de orden');
--  
insert into Enunciados
	(codEnunciado, codEstructura, codNaturalezaPredi, texto, tipo)
values
	(1, 1, 7, 'Me seco la cara con una toalla muy suave', 'Oración'),
    (2, 1, 7, '¡Que tengas suerte!', 'Oración'),
    (3, 1, 7, 'El tabaco perjudica la salud', 'Oración'),
    (4, 2, 6, 'Se alquila apartamento grande y silencioso', 'Oración'),
    (5,2,1,'Perro bonito', 'Frase');
--
insert into detalleActitud
	(codEnunciado, codActitudHablante, descActitud)
values
	(1, 2, 'Indica una afirmación'),
	(2, 5, 'Expresa deseo'),
	(3, 2, 'Indica una afirmación'),
	(4, 2, 'Indica una afirmación');