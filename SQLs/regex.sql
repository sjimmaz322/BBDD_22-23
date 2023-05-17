-- REGEX
/*
[not] Like -> es el operador básico para usar regexs
% es como el * del sistema operativo -> Es cualquier cadena
_ es como el ? del sistema operativo -> Cualquier caracter
^ -> cadenas que empiecen por un caracter determinado
$ -> cadenas que terminen por un caracter determinado
(a|b|c) -> | separa las opciones es como poner o
[0-9] números del 0 al 9
^[XY] que empiece por X o Y
^ dentro del corchete sirve para negar
[]{n} -> Siendo n el número de coincidencias del caracter dentro del corchete
*/

/*
^: Representa el inicio de una cadena.
$: Representa el final de una cadena.
.: Representa cualquier carácter individual.
[]: Representa un conjunto de caracteres permitidos.
*: Representa cero o más repeticiones del carácter anterior.
+: Representa una o más repeticiones del carácter anterior.
?: Representa cero o una repetición del carácter anterior.
*/

select * from empleados
where nomem rlike '^c';