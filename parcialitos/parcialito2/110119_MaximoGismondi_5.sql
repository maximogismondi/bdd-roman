-- Active: 1726096306815@@localhost@5432@parcialito_sql
select a.padron, n.codigo as codigo_departamento, n.numero, n.nota
from alumnos a
    join notas n on a.padron = n.padron
where
    a.fecha_ingreso = (
        select max(fecha_ingreso)
        from alumnos
    );
-- Resultados --
-- padron,codigo_departamento,numero,nota
-- 88000,75,1,9
-- 88000,71,14,8
-- 88000,75,42,7
-- 88000,75,6,9