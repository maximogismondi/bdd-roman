select
    i.codigo as codigo_carrera,
    n.codigo as codigo_departamento,
    round(avg(n.nota), 2) as promedio -- Redondeo a 2 decimales
from inscripto_en i
    join notas n on i.padron = n.padron
group by
    i.codigo,
    n.codigo
order by i.codigo, n.codigo;
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