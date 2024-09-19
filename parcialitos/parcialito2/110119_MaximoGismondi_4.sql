select a.padron, a.apellido, round(avg(n.nota), 2) as promedio
from alumnos a
    join notas n using (padron)
group by
    a.padron,
    a.apellido
having
    count(distinct (n.codigo, n.numero)) > 4
    and avg(n.nota) >= 6;
-- Resultados --
-- padron,apellido,promedio
-- 73000,Molina,6.60
-- 86000,Díaz,7.80