-- PARCIAL 2024 C1 (Tema 1)

-- EQUIPOS(cod equipo, nombre, veces campeon)
-- PILOTOS(cod equipo, nro piloto, nombre, apellido, nacionalidad, carreras ganadas)
-- CIRCUITOS(id circuito, nombre circuito, pais, vueltas, longitud km)
-- CARRERAS(id carrera, fecha, id circuito, cod equipo, nro piloto, posicion, vueltas finalizadas, ms mejor vuelta, puntos ganados)

select
    pil.cod_equipo, pil.nro_piloto, pil.nacionalidad,
    eq.nombre as nombre_equipo,
    ci.nombre_circuito, count(id_carrera) as cantidad_carreras
from (
    select cod_equipo, nro_piloto
    from pilotos
    -
    select UNIQUE (cod_equipo, nro_piloto)
    from carreras
    where posicion > 3 or ms_mejor_vuelta < 60 * 1000
) as pil
join carreras ca using(cod_equipo, nro_piloto)
join equipos eq using(cod_equipo)
join circuitos ci using(id_circuito)
group by
    pil.cod_equipo, pil.nro_piloto, pil.nacionalidad,
    eq.nombre,
    ci.cod_circuito, ci.nombre_circuito

--

select pil.nombre_piloto, AVG(car.puntos_ganados) as promedio_puntos
from pilotos pil
join carreras car using(cod_equipo, nro_piloto)
group by pil.cod_equipo, pil.nro_piloto, pil.nombre_piloto
order by promedio_puntos desc
limit 3

-- π, σ, ρ, ×, ∪, −, ∩, ⋊⋉, ÷

menos_rapidas =
    π 1.id_carrera
    (
        CARRERAS ⋈
        1.ms_mejor_vuelta > 2.ms_mejor_vuelta
        CARRERAS
    )

todas = π id_carrera (carreras)
mas_rapidas = p mr (todas - menos_rapidas)

carreras_mas_rapida =
    carreras
    ⋈ carreras.id_carrera = mr.id_carrera
    mas_rapidas

detalles =
    carreras_mas_rapida
    ⋈ carreras.cod_equipo = pilotos.cod_equipo
    and carreras.nro_piloto = pilotos.nro_piloto
    pilotos

π carreras.ms_mejor_vuelta, piloto.nombre, piloto.apellido, piloto.nro_piloto

--

Relaciones:

-- No se puede garantizar que todos los A's tengan al menos un B asociado
-- No se puede garantizar que 2 H's distintos tengan siempre distinto E asociado

A(A1, A2)
CC = {A1}
PK = {A1}
FK = {}

B(A1, B1, B2)
CC = {A1, B1}
PK = {A1, B1}
FK = {{A1} ref A}

D(A1, B1, E1, A1^, D1)
CC = {A1, B1, E1}
PK = {A1, B1, E1}
FK = {{A1^} ref A, {A1, B1} ref B, {E1} ref E}

E(E1, E2, E3)
CC = {E1}
PK = {E1}
FK = {}

F(F1, F2)
CC = {F1, F2}
PK = {F1, F2}
FK = {}

G(E1, F1, F2)
CC = {E1, F1, F2}
PK = {E1, F1, F2}
FK = {{E1} ref E, {F1, F2} ref F}

H(H1, E1)
CC = {H1}
PK = {H1}
FK = {{E1} ref E}

--

R(A,B,C,D,E,F,G,H)
Fm = {
    AB  -> C,
    C   -> D,
    EG  -> H,
    H   -> D,
    D   -> B,
    B   -> E,
    D   -> G,
}

R1(A,B,C)
R2(A,C,D,E)
R3(E,G,H)

Busco F1, F2, F3, CC1, CC2, CC3

F1 = {  
    AB  -> C,
    C   -> B,
}
CC1 = {AC, AB}
FNBC no por C -> B
FN3 SI!

F2 = {
    C   -> D,
    AD  -> C,
    D   -> E,
}
CC2 = {AC, AD}
FNBC no por D -> E y C -> D
FN3 no por D -> E
FN2 no por D -> E
FN1 SI!

F3 = {
    EG  -> H,
    H   -> G
    H   -> E,
}
CC3 = {H, EG}
FNBC SI!

--

R(A,B,C,D,E)
Fm = {
    A   -> C,
    B   -> D,
    E   -> C,
    AD  -> E,
    C   -> A,
}
CC = {AB, BC, BE}

Descomposicón 3FN:

R1(AC)
R2(BD)
R3(EC)
R4(ADE)
R5(CA)
R6(AB) -- porque no hay ninguna CC entre todas las relaciones

Paso 2: Borro redundancias

R1(AC)  CC1: {A,C}      FF1 = {A -> C, C -> A}
R2(BD)  CC2: {B}        FF2 = {B -> D}
R3(EC)  CC3: {E}        FF3 = {E -> C}
R4(ADE) CC4: {AD, ED}   FF4 = {AD -> E, E -> A}
R6(AB)  CC5: {AB}       FF5 = {}

Termine ???

--

Persona(DNI, Nombre, Direccion, Localidad, Coodigo Postal, Nombre Hijo, Edad Hijo, Nombre de la escuela donde vota, Direccion Escuela, Localidad Escuela, Codigo Postal Escuela)

F = {
    Localidad -> Codigo Postal,
    Codigo Postal -> Localidad,
    Localidad, Nombre Escuela -> Direccion Escuela,
    nombre hijo, DNI hijo -> Edad hijo,
}

