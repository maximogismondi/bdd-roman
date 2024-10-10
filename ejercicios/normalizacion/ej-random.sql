with minimos_tiempos as (
    select c.id_carrera, c.nro_piloto, c.cod_equipo, c.id_circuito, c.ms_mejor_vuelta
    from carreras as c
    where c.ms_mejor_vuelta = (
        select min(ms)
        from carreras as c2
        where c2.id_circuito = c.id_circuito
    )
)
select m.ms_mejor_vuelta, p.nombre as piloto, e.nombre as equipo, c.nombre as circuito
from minimos_tiempos as m
join pilotos    as p using(cod_equipo, cod_pilotos)
join equipos    as e using(cod_equipo)
join circuitos  as c using(id_circuito)

--

with minimos_tiempos_circuito as (
    select id_circuito, min(ms_mejor_vuelta) as ms_mejor_vuelta
    from carreras
    group by id_circuito
)
select ci.nombre_circuito, p.nombre, p.nacionalidad, e.nombre, ca.ms_mejor_vuelta
from carreras ca
join equipos e on ca.cod_equipo = e.cod_equipo
join pilotos p on ca.cod_piloto = p.cod_piloto
join circuitos ci on ca.id_circuito = ci.id_circuito
join minimos_tiempos_circuito mtc
    on ca.id_circuito = mtc.id_circuito
    and ca.ms_mejor_vuelta = mtc.ms_mejor_vuelta

--

select ca.cod_equipo, ca.nro_piloto, SUM(ci.longitud_km * ca.vueltas_finalizadas) as cantidad_km
from carreras   as ca
join circuitos  as ci using(id_circuito)
group by cod_equipo, nro_piloto
having cantidad_km > 500000

--

R   = (A, B, C, D, E, F, G)
Fd  = {
    A→BD,
    B→CD,
    AC→E,
    BF→G,
    G→B
}

# Paso 1 Fmin

## 1.1 Dejar todos los implicantes atómicos

Fd  = {
    A→B,
    A→D,
    B→C,
    B→D,
    AC→E,
    BF→G,
    G→B
}

## 1.2 Simplicficar determinantes redundantes

Fd = {
    A   → B,
    A   → D,
    B   → C,
    B   → D,
    A   → E,
    BF  → G,
    G   → B
}

## 1.3 Eliminar dfs redundantes

Fmin = {
    A   → B,
    B   → C,
    B   → D,
    A   → E,
    BF  → G,
    G   → B
}

# Paso 2 Claves candidatas

## 2.1 Detectar atributos independientes

Ai = {}

## 2.2 Detectar atributos equivalentes

Ae = {}

## 3.3 Detectar atributos SOLO implicantes (izquierda)

K = {A, F}
K+ = {A, B, C, D, E, F, G}

Entonces K es clave candidata
CC = {AF}

# Paso 3 Normalizar

R   = (A, B, C, D, E, F, G)

Fmin = {
    A   → B,
    B   → C,
    B   → D,
    A   → E,
    BF  → G,
    G   → B
}

## 3.1 Armar una relación para cada dependencia funcional

R1 = (A, B)     F1 = {A → B}            CC1 = {A}
R2 = (B, C)     F2 = {B → C}            CC2 = {B}
R3 = (B, D)     F3 = {B → D}            CC3 = {B}
R4 = (A, E)     F4 = {A → E}            CC4 = {A}
R5 = (B, F, G)  F5 = {BF → G, G → B}    CC5 = {BF, GF}
R6 = (G, B)     F6 = {G → B}            CC6 = {G}

## 3.2 Si no hay alguna en la que esté la clave candidata, agregarla

R7 = (A, F)     F7 = {}                 CC7 = {AF}

## 3.3 Eliminar relaciones redundantes

R1  = (A, B)     F1 = {A → B}            CC1 = {A}
R2  = (B, C)     F2 = {B → C}            CC2 = {B}
R3  = (B, D)     F3 = {B → D}            CC3 = {B}
R4  = (A, E)     F4 = {A → E}            CC4 = {A}
R56 = (B, F, G)  F5 = {BF → G, G → B}    CC5 = {BF, GF}
R7  = (A, F)     F7 = {}                 CC7 = {AF}

## 3.4 Unir esquemas con la misma clave candidata

R14 = (A, B, E) F1 = {A → B, A → E}     CC1 = {A}
R23 = (B, C, D) F2 = {B → C, B → D}     CC2 = {B}
R56 = (B, F, G) F5 = {BF → G, G → B}    CC5 = {BF, GF}
R7  = (A, F)    F7 = {}                 CC7 = {AF}
