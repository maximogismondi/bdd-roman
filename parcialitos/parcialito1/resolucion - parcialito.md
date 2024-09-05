# Resolución

## Ejercicio 1

| Relación | Clave Primaria | Claves Candidatas | Claves Foráneas | Aclaraciones |
|:-:|:-:|:-:|:-:|:-:|
|A(A1)|{A1}|{A1}||No se puede garantizar la participación total con B mediante C|
|B(A1, B1)|{A1, B1}|{A1, B1}|{A1} ref A||
|D(A1,A1_2,B1)|{A1,A1_2,B1}|{A1,A1_2,B1}|{A1_2} ref A {A1,B1} ref B||
|E(E1,E2,E3)|{E1,E2}|{E1,E2}|||
|F(F1,F2)|{F1}|{F1}|||
|G(A1,E1,E2,F1,G1)|{A1,E1,E2,F1}|{A1,E1,E2,F1}|{A1} ref A {E1,E2} ref E {F1} ref F||
|H(F1,H1,H2)|{H1}|{H1}|{F1} ref F|No se puede garantizar que F1 no sea nulo|

Aclaraciones:

No estoy muy seguro para la relación de D, como diferenciar el A1 que viene del propio B con el A1 que se interelaciona con A. Le puse A1 y A1_2 pero no estoy seguro si es correcto. De todas formas aclaré en las claves foráneas cual es cual.

## Ejercicio 2

### Ejercicio A

Consulta:

```relax
COMEDY_MOVIES_IDS = π movie_id σ genre='Comedy' movies_genres
COMEDY_MOVIES = π id, name, year (movies ⨝ movies.id = movies_genres.movie_id COMEDY_MOVIES_IDS)

CM1 = ρ cm1 (COMEDY_MOVIES)
CM2 = ρ cm2 (COMEDY_MOVIES)

NON_OLDESTS_COMEDY_MOVIES = π cm1.id, cm1.name, cm1.year (σ cm1.year > cm2.year (CM1 ⨯ CM2))

OLDESTS_COMEDY_MOVIES = COMEDY_MOVIES - NON_OLDESTS_COMEDY_MOVIES
OLDESTS_COMEDY_MOVIES
```

Resultado:

| movies.id | movies.name | movies.year |
|:-:|:-:|:-:|
|64833|'City Lights'|1931|

### Ejercicio B

Consulta:

```relax
ACTOR = π id σ first_name = 'Ferdy' ∧ last_name = 'Mayne' actors
MOVIES_WITH_ACTOR = ρ actor_movies (π movie_id (roles ⨝ actors.id = roles.actor_id ACTOR))

MOVIES_PARTICIPATIONS = π actor_id, movie_id roles 
ACTORS_IN_MOVIES = π actor_id (MOVIES_PARTICIPATIONS ÷ MOVIES_WITH_ACTOR) - ACTOR

ACTORS_IN_MOVIES_NAMES = π first_name, last_name (actors ⨝ actors.id = roles.actor_id ACTORS_IN_MOVIES)
ACTORS_IN_MOVIES_NAMES
```

Resultado:
| actors.first_name | actors.last_name |
|:-:|:-:|
|'André'|'Morell'|
