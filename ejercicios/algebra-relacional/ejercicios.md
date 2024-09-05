# Ejercicio algebra relacional

[Base de datos]([http://dbis-uibk.github.io/relax/calc/gist/552932a29392f8272951e01ada813ae1/imdbsample/0]("Base de datos"))

1. Mostrar los actores cuyo nombre sea Brad.
σfirst_name='Brad' actors

2. Mostrar el nombre y apellido de directores catalogados como de 'Sci-Fi' (ciencia ficción)
con una probabilidad mayor igual a 0.5.

3. Mostrar los nombres de las películas filmadas por James(I) Cameron que guren en la
base.

4. Mostrar los nombres y apellidos de las actrices que trabajaron en la película 'Judgment
at Nuremberg'

5. Muestre los actores que trabajaron en todas las películas de Woody Allen de la base.

    ```relational-algebra
    DIRECTOR = σfirst_name='Woody'∧last_name='Allen'directors
    DIRECTOR_MOVIES = π movie_id (movies_directors ⨝ movies_directors.director_id=directors.id DIRECTOR)
    ALL_ACTOR_ROLES = π actor_id,movie_id roles
    ACTORS_IN_ALL_DIRECTOR_MOVIES = ALL_ACTOR_ROLES ÷ DIRECTOR_MOVIES
    ACTORS_NAMES_IN_ALL_DIRECTOR_MOVIES = π first_name, last_name (actors ⨝ roles.actor_id=actors.id    ACTORS_IN_ALL_DIRECTOR_MOVIES)
    ACTORS_NAMES_IN_ALL_DIRECTOR_MOVIES
    ```

6. Directores que abarcaron, al menos, los mismos géneros que Welles (géneros en directores).

    ```relational-algebra
    DIRECTOR = πid σlast_name='Welles'directors
    DIRECTOR_GENRES = π genre (directors_genres ⨝ directors_genres.director_id = directors.id DIRECTOR)
    ALL_DIRECTOR_GENRES = π director_id, genre directors_genres
    RESULT_DIRECTORS = ALL_DIRECTOR_GENRES ÷ DIRECTOR_GENRES
    RESULT_DIRECTORS_NAMES = π first_name,last_name (directors ⨝ directors.id = directors_genres.director_id    RESULT_DIRECTORS)
    RESULT_DIRECTORS_NAMES
    ```

7. Actores que filmaron más de una película en algún año a partir de 1999.

    ```relational-algebra
    MOVIES_AFTER_YEAR = π id σ year ≥ 1999 movies
    ROLES_IN_MOVIES = π actor_id, movie_id roles ⨝ roles.movie_id = movies.id MOVIES_AFTER_YEAR
    ROLES_IN_MOVIES_2 = ρ roles_2 ROLES_IN_MOVIES
    ACTOR_MORE_THAN_ONE_MOVIE = π roles.actor_id (ROLES_IN_MOVIES ⨝ roles.actor_id = roles_2.actor_id ∧ roles.movie_id ≠ roles_2.movie_id ROLES_IN_MOVIES_2)
    RESULT_ACTORS_NAMES = π first_name, last_name (actors ⨝ actors.id = roles.actor_id ACTOR_MORE_THAN_ONE_MOVIE)
    RESULT_ACTORS_NAMES
    ```

8. Listar las películas del último año.

    ```relational-algebra
    ALL_MOVIES = π id, name, year (movies)
    MOVIES_1 = ρ m1 (ALL_MOVIES)
    MOVIES_2 = ρ m2 (ALL_MOVIES)
    NOT_LAST_YEAR_MOVIES = π m1.id, m1.name, m1.year (σ m1.year < m2.year (MOVIES_1 ⨯ MOVIES_2))
    LAST_YEAR_MOVIES = π name (ALL_MOVIES - NOT_LAST_YEAR_MOVIES)
    LAST_YEAR_MOVIES
    ```

9. Películas del director Spielberg en las que actuó Harrison (I) Ford.

    ```relational-algebra
    DIRECTOR = π id (σ last_name = 'Spielberg' (directors))
    ACTOR = π id (σ first_name = 'Harrison (I)' ∧ last_name = 'Ford' (actors))

    DIRECTOR_MOVIES = π movie_id (movies_directors ⨝ movies_directors.director_id = directors.id DIRECTOR)
    ACTOR_ROLES = π movie_id (roles ⨝ roles.actor_id = actors.id ACTOR)

    MOVIES_OF_DIRECTOR_WITH_ACTOR = (DIRECTOR_MOVIES ∩ ACTOR_ROLES)
    MOVIES_NAMES = π name (movies ⨝ movies.id = movies_directors.movie_id MOVIES_OF_DIRECTOR_WITH_ACTOR)
    MOVIES_NAMES
    ```

10. Películas del director Spielberg en las que no actuó Harrison (I) Ford.

11. Películas en las que actuó Harrison (I) Ford que no dirigió Spielberg.

12. Directores que filmaron películas de más de tres géneros distintos, uno de los cuales sea
'Film-Noir'.

    ```relational-algebra
    G1 = π genre, director_id (ρ g1 (σ genre='Film-Noir'directors_genres))
    G2 = π genre, director_id (ρ g2 (directors_genres))
    G3 = π genre, director_id (ρ g3 (directors_genres))

    G12 = π g1.genre, g2.genre, g1.director_id (G1 ⨝ g1.director_id = g2.director_id ∧ g1.genre ≠ g2.genre G2)

    G123 = π g1.director_id (G12 ⨝ g1.director_id = g3.director_id ∧ g1.genre ≠ g3.genre ∧ g2.genre ≠ g3.genre G3)

    DIRECTOR_NAMES = π first_name, last_name (G123 ⨝ g1.director_id = directors.id directors)

    DIRECTOR_NAMES
    ```
