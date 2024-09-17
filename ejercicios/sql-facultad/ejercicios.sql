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