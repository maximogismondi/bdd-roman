# Modelo lógico relacional

## Modelo lógico

Es un paso intermedio entre el modelo conceptual y el modelo interno que formaliza las descripciones del modelo conceptual.

Esta es una de las capas ANSI/SPARC.

## Estructura del modelo relacional

### Formalización

Nombre de la relación: R
Lista de atributos: A1, A2, ..., An

Juntos forman el **esquema de la relación**: R(A1, A2, ..., An)

Cada atributo Ai tiene un **dominio** que es un conjunto de valores permitidos: Dom(Ai)

Una relación R con un esquema R(A1, A2, ..., An) es un subconjunto del producto cartesiano de los dominios de los atributos: Dom(A1) x Dom(A2) x ... x Dom(An)

### Tuplas

Un elemento de la relación R es una tupla que es un conjunto de valores que pertenecen a los dominios de los atributos de la relación.

Una tupla pertenece al producto cartesiano de los dominios de los atributos de la relación.

El **valor** de un atributo Ai en una tupla t se denota t[Ai] o t.Ai

La **cardinalidad** de una relación R es el número de tuplas que contiene: n(R)

### Representación

Una forma útil de representar una relación es mediante una tabla donde las filas representan las tuplas y las columnas los atributos.

Otra nomenclatura utilizada, más vinculada al nivel físico es usar **archivos** en lugar de tablas, **registros** en lugar de filas y **campos** en lugar de columnas.

## Restricciones del modelo relacional

### Resticcion de dominio

Especifican que dado un atributo A de una relación R, el valor del atributo A en una tupla t debe pertenecer al dominio dom(A).

Pueden ser $N$, $R$, caracteres, fechas, booleanos

Pueden ser nulos.

Deben ser atributos atómicos (no se permiten compuestos o multivaluados).

### Restricción de unicidad

No pueden existir 2 tuplas que coincidan en los valores de TODOS los atributos. Pero generalmente uusaremos un subconjunto de atributos $S_k \subseteq (A_1, A_2, ..., A_n)$ de la relación R. Dada 2 tuplas $s$, $t$ $\in$ R las mismas difieren en al menos un atributo de $S_k$.

Cuando un subconjunto de atributos $S_k$ de una relación R tiene la propiedad de unicidad, se dice que $S_k$ es una superclave de R.

Nos interesa encontrar la superclave minimal, es decir, la superclave que no tiene subconjuntos propios que sean superclaves.

A estas superclaves minimales se las llama claves candidatas o simplemente claves.

De entre todas las claves candidatas se elige una como **clave primaria**. La indicamos con una línea subrayada en el esquema.

Ejemplo: Peliculas(nombre_pelicula, año, director, cant_oscares)

- (nombre_pelicula, año) es una superclave. Pero no es minimal, ya que (nombre_pelicula) también es superclave.

Ahora si queremos permitir que haya 2 películas con el mismo nombre, pero no con el mismo año, entonces debemos crear un atributo "id" que nos permita identificar a cada película.

Esta clave se conoce como **clave sustituta** o **clave surrogada**.

Las clave que dependen de los datos son las **claves naturales**.

### Esquemas de base de datos

En una BDD se almacenan múltiples esquemas de relaciones, muchas veces relacionados entre sí.

En un modelo relacional, una BDD se representa mediante un esquema de base de datos relacional.

Este es un conjunto de esquemas de relaciones junto con una serie de **restricciones de integridad**.

### Restricciones de integridad

- **Restricciones de integridad de entidad**: asegura que la clave primaria de una relación no puede ser nula.

La clave primaria no puede ser nula, ya que es la forma de identificar a una tupla.

- **Restricciones de integridad referencial**: Cuando un conjunto de atributos FK de una relación R hace referencia a la clave primaria de otra relación S, entonces para cada tupla t de R, el valor de FK en t debe coincidir con el valor de la clave primaria de S en alguna tupla de S a menos que FK sea nulo.

Es decir, que si quiero hacer una relación con otra relación debe existir aquel valor en la otra relación.

Esta FK es conocida como **clave foránea** y puedo ser la referencia a una clave primaria de otra relación o tener un valor nulo.

Ahora si la clave foránea pertenece a la clave primaria, esta NO puede ser nula, por la restricción de integridad de entidad.

Para especificar una PK o FK usar la siguiente notación:

PK: {A1, A2, ..., An}
FK: {B1, B2, ..., Bm}, {C1, C2, ..., Cn}, ..., {Z1, Z2, ..., Zk}

## Operaciones

### Operaciones de consulta

Se consultan los datos de la relación.

No es necesario chequear las restricciones ya que no se modifican los datos, solo se leen.

### Operaciones de actualización

En estas relaciones se deben hacer los chequeos que garanticen que las restricciones se cumplen.

Un SGBD debe garantizar que las operaciones de actualización no violen las restricciones de integridad y rechazar aquellas que las violen.

- **Inserción**: Se inserta una nueva tupla en la relación.

Pueden violar restricciones de dominio, unicidad y integridad de entidad o referencial.

- **Eliminación**: Se elimina una tupla de la relación.

Pueden violar restricciones de integridad referencial.

Cuando se borra una tupla de una relación, se debe chequear que no haya tuplas en otras relaciones que hagan referencia a la tupla que se está borrando.

En este caso hay 3 estrategias:

- Rechazar la eliminación
- Borrar en cascada
- Poner a nulo los valores de las claves foráneas
- Poner a un valor por defecto

- **Modificación**: Se modifica una tupla de la relación.

Debo revisar las restricciones de dominio siempre que modifique un atributo.

Debo revisar las restricciones de unicidad y de integridad de entidad si modifico la clave primaria.

Debo revisar las restricciones de integridad referencial si modifico la clave foránea o si modifico la clave primaria para que no haya referencias antiguas.

### Transacciones

Es un conjunto de operaciones que se ejecutan como una sola unidad o no se ejecutan en absoluto.

Por ejemplo, si tengo una operación de transferencia de dinero entre cuentas, debo asegurarme que se descuente de una cuenta y se acredite en otra. Por lo que si una de las operaciones falla, debo deshacer la otra.

## Pasaje de modelo conceptual a modelo relacional

En nuestro caso de modelo entidad-relación haremos el pasaje a modelo relacional.

### Pasaje de tipo de entidad

Cada tipo de entidad del modelo ER, se convierte en una relación del modelo relacional.

### Pasaje de atributos multivaluados

En el caso de tener un atributo multivaluados, se creará una nueva relación con la clave primaria de la relación original y los atributos compuestos o multivaluados como atributos y parte de la clave primaria de la nueva relación.

### Pasaje de atributos compuestos

En el caso de tener un atributo compuesto, lo descompondremos en sus atributos más simples, en las "hojas" del árbol de atributos.

### Pasaje de atributos derivados

En el caso de los derivados se pueden calcular en tiempo de ejecución, por lo que no se almacenan en la base de datos. Pero si se almacenan por cuestiones de performance, se deben actualizar cada vez que se modifiquen los atributos de los que dependen.

### Pasaje de interrelación

Cuando quiero hacer un pasaje de interrelación al modelo relacional, debemos crear una relación nueva con las claves primarias de las relaciones que se relacionan. Se pueden agregar atributos adicionales que se obtienen de la interrelación pero estos NO forman parte de la clave primaria.

Lo que más debemos tener en cuenta cuando hacemos el pasaje es la cardialidad máxima.

Pasaje de **interrelación N:M**

- **Estrategia de claves cruzadas**: Creamos una nueva relación con la clave primaria compuesta de ambas claves primarias de las relaciones que se relacionan. Por ejemplo en el caso de estudiantes y materias, la clave primaria de la nueva relación será la clave primaria de estudiantes y la clave primaria de materias.

Pasaje de **interrelación 1:1**

- **Estrategia claves cruzadas**: Podemos o crear una relación nueva con los atributos de las claves primarias de las relaciones que se relacionan y la clave primaria de la nueva relación será o bien la clave primaria de una o de la otra relación, en cualquier otro caso, está no será minimal.
- **Estrategia clave foránea**: Podemos agregar la clave foránea de una relación a la otra, pero en este caso, la clave foránea puede ser nula. En este caso debemos elegir aquella cuya participación sea mayor (total en el mejor caso). Por ejemplo en el caso de departamentos y gerentes, tiene más sentido que el departamento tenga la clave foránea del gerente, ya que un gerente puede no tener un departamento asignado pero un departamento siempre tiene un gerente asignado.
- **Estrategia única relación**: Podemos crear una tabla que tenga todos los atributos de las relaciones que se relacionan y la clave primaria de la nueva relación será la clave primaria de una de las relaciones.

Es mejor usar la estrategia de la nueva relación cuando la participación es parcial en ambos casos y la estrategia de clave foránea cuando la participación es total para alguna de las relaciones evitando así la nulidad de la clave foránea. Cuando la participación es total en ambas relaciones, se puede usar la estrategia de la única relación.

En todos los casos las estrategias son válidas y dependen del contexto.

Lo que no se debe hacer es crear clave foráneas en ambas relaciones, ya que esto produce problemas, como que no se referencien mutuamente.

Pasaje de **interrelación 1:N**

- **Estrategia claves cruzadas**: Podemos crear una nueva relación con las claves primarias de las relaciones que se relacionan y la clave primaria de la nueva relación será la clave primaria de la relación que tiene cardinalidad 1. Por ejemplo en el caso de futbolistas y equipos, la clave primaria de la nueva relación será la clave primaria del futbolista ya que un futbolista solo puede pertenecer a un equipo pero un equipo puede tener muchos futbolistas.
- **Estrategia clave foránea**: Podemos agregar la clave foránea de la relación que tiene cardinalidad 1 a la relación que tiene cardinalidad N. Por ejemplo en el caso de futbolistas y equipos, la clave foránea será la clave primaria del equipo en la relación de futbolistas.

### Pasaje de entidades débiles

- **Estrategia clave foránea**: Podemos agregar la clave foránea de la entidad fuerte a la entidad débil. Por ejemplo en el caso de empleados y dependientes, la clave foránea será la clave primaria del empleado en la relación de dependientes.

En este caso la clave foránea no puede ser nula, ya que la clave foránea es la clave primaria de la entidad debil. No usamos otra estrategia ya que no partimos de una interrelación.

### Pasaje de generalización / especialización

- **Estrategia relacion general y relaciones especializadas**: Podemos crear una relación que representa a la generalización y muchas relaciones que representan a las especializaciones. La clave primaria de la relación generalización será clave foránea y clave primaria de las relaciones de especialización. Por ejemplo en el caso de vehículos, la relación generalización será vehículos y las relaciones de especialización serán autos y motos.
- **Estrategia relaciones especializadas**: Podemos crear una relación que representa a cada especialización y se duplicaran los atriburos de la generalización. Por ejemplo en el caso de vehículos, la relación autos tendrá los atributos de vehículos y los atributos de autos y la relación motos tendrá los atributos de vehículos y los atributos de motos. Esto NO sirve para generalizaciones parciales.

### Pasaje de uniones

- **Estrategia relación supertipo y relaciones subtipos**: Podemos crear una relación que representa al supertipo y muchas relaciones que representan a los subtipos. En las relaciones de subtipos se usarán claves foráneas para representar la relación con el supertipo. Dependiendo del tipo de unión se puede considerar primaria o no.

### Pasaje de interrelacions ternarias

Cuando todos son N se debe usar:

- **Estrategia claves cruzadas**: se debe crear una relación que tenga como clave primaria las claves primarias de las relaciones que se relacionan.

Cuando hay una relación 1 se debe usar:

- **Estrategia clave cruzadas**: igual que el anterior pero la clave primaria de la relación que tiene cardinalidad 1 debe ser clave foránea pero NO clave primaria.

Cuando hay muchas relaciones 1:

- **Estrategia clave cruzadas**: igual que el anterior pero ahora tenemos más opciones para que una clave foránea NO sea clave primaria, siempre aquella que tenga cardinalidad N debe ser clave primaria.
