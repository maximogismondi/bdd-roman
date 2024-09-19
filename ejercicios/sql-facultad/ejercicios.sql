-- ej 11
select *
from (
        select a.padron, n.padron as p
        from alumnos a
            inner join notas n on a.padron = n.padron
        where
            n.nota <= 4
    ) as t
    inner join notas n on t.padron = n.padron
where
    n.nota >= 4;

SELECT 1 as a where 1 in ( select nota from notas );

-- 5 Ejecute una consulta SQL que devuelva el padrón y nombre de los alumnos cuyo apellido es “Molina”.

select * from alumnos where apellido ILIKE 'MOLINA';

-- 6 Obtener el padrón de los alumnos que ingresaron a la facultad en el año 2010.

select *
from alumnos
where
    fecha_ingreso >= '2010-01-01'
    and fecha_ingreso <= '2010-12-31';

select *
from alumnos
where
    fecha_ingreso between '2010-01-01' and '2010-12-31';

-- 25 Obtener el promedio general de notas por alumno (cuantas notas tiene en promedio un alumno), considerando únicamente alumnos con al menos una nota.

Select avg(cantidad_notas.cantidad)
from (
        select count(nota) as cantidad
        from notas
        group by
            padron
    ) as cantidad_notas;

-- 22 Para cada alumno con al menos tres notas, devuelva su padrón, nombre, promedio de notas y mejor nota registrada.

select a.padron, a.nombre, avg(n.nota) as promedio, max(n.nota) as mejor_nota
from alumnos a
    inner join notas n on a.padron = n.padron
group by
    a.padron,
    a.nombre
having
    count(n.nota) >= 3;

-- 23 Obtener el código y número de la o las materias con mayor cantidad de notas registradas.

select codigo, numero
from notas n
group by
    codigo,
    numero
having
    count(codigo) >= ALL (
        select count(codigo)
        from notas
        group by
            codigo,
            numero
    )

with
    cantidad_notas as (
        select codigo, numero, count(codigo) as cantidad
        from notas
        group by
            codigo,
            numero
    )
select codigo, numero
from cantidad_notas
where
    cantidad = (
        select max(cantidad_notas.cantidad)
        from cantidad_notas
    );

-- 24 Obtener el padrón de los alumnos que tienen nota en todas las materias.

select padron
from notas
group by
    padron
having
    count(distinct (codigo, numero)) = (
        select count(*)
        from materias
    );

-- otra forma

select padron
from alumnos
where
    padron not in (
        select padron
        from (
                select padron, codigo, numero
                from alumnos, materias
                except
                select distinct
                    padron,
                    codigo,
                    numero
                from notas
            ) as alumnos_sin_todas_las_materias
    );

select *
from
    alumnos,
    notas n,
    notas n1,
    notas n2,
    notas n3,
    notas n4,
    materias,
    departamentos;