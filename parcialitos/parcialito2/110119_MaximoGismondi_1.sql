with
    materias_promocionadas as (
        select padron, count(*) as cantidad
        from notas
        where
            nota >= 7
        group by
            padron
    )
select a.padron, a.apellido
from
    alumnos a
    join materias_promocionadas mp using (padron)
where
    mp.cantidad = (
        select max(cantidad)
        from materias_promocionadas
    );
-- Resultados --
-- padron,apellido
-- 83000,Gómez
-- 85000,Fernández
-- 88000,Vargas
-- 86000,Díaz