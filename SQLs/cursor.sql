delimiter $$
drop procedure cursorSintaxis $$
-- 

declare categoria varchar(15);
declare textoEnun varchar(100)

declare cursor cursorEstructura for select Estructura.desEstructura, Enunciados.texto from Estructura join Enunciados on Estructura.codEstructura = Enunciados.codEstrucura;

open cursorEstructura;
fetch cursorEstructura into categoria, textoEnum;


close cursorEstructura;


delimiter ;
