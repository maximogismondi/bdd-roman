with
    materias_requeridas as (
        select n.codigo, n.numero
        from notas n
        where
            n.padron = 83000
            and n.nota >= 4
    )
select padron
from alumnos a
where
    not exists (
        select 1
        from
            materias_requeridas mr
            left join notas n on mr.codigo = n.codigo
            and mr.numero = n.numero
            and a.padron = n.padron
        where
            n.nota is null
    ) -- and a.padron <> 83000 -- si excluyeramos al propio 83000
;
-- Resultados --
-- padron
-- 83000
-- 84000
-- 85000