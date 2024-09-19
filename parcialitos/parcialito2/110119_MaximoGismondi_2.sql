select a.padron, a.apellido
from alumnos a
where
    a.padron in (
        select distinct
            padron
        from notas
        where (codigo, numero) in ((75, 40), (75, 41))
    )
    and a.padron not in (
        select distinct
            padron
        from notas
        where (codigo, numero) in ((62, 05), (75, 01))
    );
-- Resultados --
-- padron,apellido
-- 83000,Gómez
-- 84000,López
-- 85000,Fernández