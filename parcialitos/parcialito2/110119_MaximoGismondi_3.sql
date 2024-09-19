select
    c.codigo as codigo_carrera,
    d.codigo as codigo_departamento,
    round(avg(n.nota), 2) as promedio -- Redondeo a 2 decimales
from
    carreras c
    join inscripto_en i on c.codigo = i.codigo
    join alumnos a on i.padron = a.padron
    join notas n on a.padron = n.padron
    join materias m on n.codigo = m.codigo
    and n.numero = m.numero
    join departamentos d on m.codigo = d.codigo
group by
    c.codigo,
    d.codigo
order by c.codigo, d.codigo;
-- Resultados --
-- codigo_carrera,codigo_departamento,promedio
-- 5,61,7.00
-- 5,62,7.25
-- 6,61,8.80
-- 6,62,7.00
-- 9,71,6.71
-- 9,75,6.69
-- 10,71,6.75
-- 10,75,6.50