-- Tema 7 - Apuntes
-- Agrupar por departamento quitando lo que tengan menos de 3 personas.

SELECT -- (6)
    numde, COUNT(*)
FROM -- (1)
    empleados
WHERE -- (2)
    salarem > 900
GROUP BY numde -- (3)
HAVING COUNT(*) > 2 -- (4)
ORDER BY COUNT(*) DESC; -- (5)

/*
Podemos usar GROUP BY sin HAVING
Pero no un HAVING sin GROUP BY
*/