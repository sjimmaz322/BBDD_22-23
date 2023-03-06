-- Tema 6 relación de ejercicios 1
use empresaClase;
--
-- 1 - Obtener todos los datos de todos los empleados.
SELECT 
    *
FROM
    empleados;
--
-- 2 - Obtener la extensión telefónica de “Juan López”.
SELECT 
    extelem
FROM
    empleados
WHERE
    nomem = 'Juan' AND ape1em = 'López';
-- 
-- 3 - Obtener el nombre completo de los empleados que tienen más de un hijo.
SELECT 
    ape1em, ape2em, nomem
FROM
    empleados
WHERE
    numhiem > 1;
--
-- 4 - Obtener el nombre completo y en una sola columna de los empleados que tienen entre 1 y 3 hijos.
SELECT 
    CONCAT(ape1em,
            ' ',
            IFNULL(ape2em, ''),
            ', ',
            nomem) AS 'Nombre completo'
FROM
    empleados
WHERE
    numhiem >= 1 AND numhiem <= 3;
-- 
-- 5 - Obtener el nombre completo y en una sola columna de los empleados sin comisión.
SELECT 
    CONCAT(ape1em,
            ' ',
            IFNULL(ape2em, ''),
            ', ',
            nomem) AS 'Nombre completo'
FROM
    empleados
WHERE
    comisem = 0 OR comisem IS NULL;
--
-- 6 - Obtener la dirección del centro de trabajo “Sede Central”.
SELECT 
    dirce
FROM
    centros
WHERE
    nomce = ' SEDE CENTRAL';
-- 
-- 7 - Obtener el nombre de los departamentos que tienen más de 6000 € de presupuesto.
SELECT 
    nomde
FROM
    departamentos
WHERE
    presude > 6000;
-- 
-- 8 - Obtener el nombre de los departamentos que tienen de presupuesto 6000 € o más.
SELECT 
    nomde
FROM
    departamentos
WHERE
    presude >= 6000;
-- 
-- 9 - Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa más de 1 año. (Añade filas nuevas para poder comprobar que tu consulta funciona).
SELECT 
    CONCAT(ape1em,
            ' ',
            IFNULL(ape2em, ''),
            ', ',
            nomem) AS 'Nombre completo'
FROM
    empleados
WHERE
    fecinem < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
--
-- 10 - Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa entre 1 y tres años. (Añade filas nuevas para poder comprobar que tu consulta funciona).
SELECT 
    CONCAT(ape1em,
            ' ',
            IFNULL(ape2em, ''),
            ', ',
            nomem) AS 'Nombre completo'
FROM
    empleados
WHERE
    fecinem BETWEEN DATE_SUB(CURDATE(), INTERVAL 3 YEAR) AND DATE_SUB(CURDATE(), INTERVAL 1 YEAR);