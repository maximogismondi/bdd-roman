# SQL - Structured Query Language

Los lenguajes son las herramientas a travéz de las que interactuamos con los modelos de datos.

Dentro de los tipos de lenguaje se encuentran:

- **Lenguajes de definición de datos (DDL)**: Permiten definir la estructura y restricciones de los datos.
- **Lenguajes de manipulación de datos (DML)**: Permiten manipular los datos almacenados en la base de datos.
- **Lenguajes de control de datos (DCL)**: Permiten controlar el acceso a los datos.

SQL es declarativo, NO procedural, no le decimos cómo hacer las cosas, sino qué queremos hacer.

Se basa en el cálculo de tuplas

Trabajamos con tablas en vez de relaciones. Las filas y columnas vienen a ser las tuplas y atributos de las relaciones.

## DDL: Lenjuaje de definición de datos

Permiten definir la estuctura y restricciones de los datos.

### Esquema de una tabla

Un esquema sirve para definir la estructura de una tabla.

```sql
CREATE SCHEMA nombre_esquema [ AUTHORIZATION AuthID ] 
```

Ejemplo:

```sql
CREATE SCHEMA empresa AUTHORIZATION admin;
```

En un entorno puede haber varios esquemas agrupados en un catálogo.

Todo catálogo tiene un esquema llamado `information_schema` que describe a los demás esquemas del catálogo.

### Tablas

Para crear una tabla se utiliza la siguiente sintaxis:

```sql
CREATE TABLE nombre_tabla (
    definición_columna1,
    definición_columna2,
    ...
    definición_columnaN
    [ definición_restricción1,
    definición_restricción2,
    ...
    definición_restricciónM ] 
);
```

No es obligariorio pero si MUY recomendable que cada tabla tenga una clave primaria.

### Definición de columnas

```sql
nombre_columna tipo_dato [ resticciones ] 
```

### Tipos de datos

Numéricos:

- INT
- SMALLINT
- FLOAT(n)
- DOUBLE PRECISION
- NUMERIC(precisión, escala)

Strings:

- CHAR(n)
- VARCHAR(n)

Fecha y hora:

- DATE
- TIME
- TIMESTAMP (con o sin zona horaria)
- INTERVAL

Otros:

- BOOLEAN
- CLOB
- BLOB
- UUID

### Restricciones

- PRIMARY KEY
- FOREIGN KEY
- UNIQUE
- NULL o NOT NULL
- DEFAULT valor
- CHECK condición

Las resticciones se pueden definir luego de las columnas y usando **CONSTRAINT** se les puede dar un nombre.

```sql
CONSTRAINT nombre_restricción restricción (columna)
```

En una restricción de clave foránea se puede definir qué hacer en caso de que se intente borrar o actualizar un registro que tiene registros relacionados en otra tabla.

```sql
[ CONSTRAINT nombre_restricción ] 
FOREIGN KEY (columnas)
REFERENCES tabla_referencia (columnas_referenciadas)
[ ON DELETE SET NULL | CASCADE | RESTRICT | SET DEFAULT ]
[ ON UPDATE SET NULL | CASCADE | RESTRICT | SET DEFAULT ]
```

### Claves sustitutas

Una clave sustituta es una clave primaria que no tiene significado en el mundo real. Según el motor de base de datos, se puede usar un tipo de dato especial para las claves sustitutas.

Para PostgreSQL se puede usar el tipo de dato `SERIAL` o `BIGSERIAL`, para MySQL se puede usar `AUTO_INCREMENT`, para SQL Server se puede usar `IDENTITY`, para Oracle se puede usar `SEQUENCE` y triggers `BEFORE INSERT`, etc.

### Cambios en la estructura de una tabla

Una vez creadas algunas tablas, es posible que se necesite modificar su estructura. Para ello se pueden usar las siguientes sentencias:

```sql
ALTER TABLE nombre_tabla ADD COLUMN definición_columna;
ALTER TABLE nombre_tabla DROP COLUMN nombre_columna;
ALTER TABLE nombre_tabla RENAME TO nuevo_nombre_tabla;
ALTER TABLE nombre_tabla ALTER COLUMN nombre_columna SET NOT NULL;
ALTER TABLE nombre_tabla ALTER COLUMN nombre_columna DROP NOT NULL;
```

### Eliminación de tablas

Para eliminar una tabla se usa la siguiente sentencia:

```sql
DROP TABLE nombre_tabla [ CASCADE ]
```

La opción `CASCADE` permite eliminar una tabla y todas las tablas que dependen de ella.

### Indices

Un índice es una estructura de datos que mejora la velocidad de las operaciones de búsqueda en una tabla a costa de aumentar el tiempo de las operaciones de inserción, actualización y eliminación y de ocupar más espacio en disco.

Para crear un índice se usa la siguiente sentencia:

```sql
CREATE [ UNIQUE ] INDEX nombre_indice
ON nombre_tabla (expresion1 [ , ..., expresionN ]
[ INCLUDE (columna1 [ , ..., columnaN ]) ] 
[ WHERE condición ]
);
```

Además se crear índices que incluyan varias columnas no indexadas, para ello se usa el `INCLUDE`. Esto nos permite buscar por las columnas indexadas y obtener las columnas no indexadas sin tener que acceder a la tabla.

La claúsula `WHERE` permite crear un índice parcial o condicional. Tiene sentido porque un índice pequeño es más rápido de leer que uno grande.

Para eliminar un índice se usa la siguiente sentencia:

```sql
DROP INDEX nombre_indice
```

## DML: Lenguaje de manipulación de datos

Permiten manipular los datos almacenados en la base de datos.

### SELECT

El comando para efectuar consultas en SQL es `SELECT`.

```sql
SELECT columna1 [, columna2, ..., columnaN ]
FROM tabla1 [, tabla2, ..., tablaN ]
[ WHERE condición ];
```

En la claúsula `FROM` se pueden consultar por un o muchas tablas y hacer una combinación de ellas resultará en un producto cartesiano.

Otra forma de hacer el producto cartesiano es con la claúsula `CROSS JOIN`.

```sql
SELECT columna1, columna2
FROM tabla1
CROSS JOIN tabla2;
```

En la claúsula `WHERE` se pueden poner condiciones para filtrar los resultados.

### Comentarios

Los comentarios en SQL se pueden hacer de 2 formas:

```sql
-- Comentario de una línea
/* Comentario de varias líneas */
```

### DISTINCT

El `DISTINCT` permite obtener valores únicos, el `ALL` permite obtener todos los valores. Es decir que si usamos `DISTINCT`, no habrá 2 valores duplicados de esa expresión ya que aplica a la fila completa.

```sql
SELECT DISTINCT columna1 [, columna2, ..., columnaN ]
FROM tabla1 [, tabla2, ..., tablaN ]
[ WHERE condición ];
```

### Expresiones

Las expresiones pueden ser:

- Nombres de columnas (se puede usar nombre_tabla.nombre_columna para evitar ambigüedades)
- Valores constantes
- Funciones con o sin argumentos
- Operadores aplicados a expresiones

Si se usa un * se obtienen todas las columnas de la/s tabla/s.

### Operadores

- Aritméticos: +, -, *, /, %
- Comparación: =, <>, <, <=, >, >=
- Lógicos: AND, OR, NOT
- Concatenación: ||
- De pertenencia: IN, NOT IN
- De rango: BETWEEN, NOT BETWEEN
- De coincidencia: LIKE, NOT LIKE
- De nulidad: IS NULL, IS NOT NULL
- De existencia: EXISTS, NOT EXISTS

### Rangos

Para hacer consultas por rangos se usa la claúsula `BETWEEN`.

```sql
expresion BETWEEN valor1 AND valor2
```

es equivalente a

```sql
expresion >= valor1 AND expresion <= valor2
```

### Comparación con nulos

Para comparar con nulos se usa la claúsula `IS NULL` o `IS NOT NULL`.

Si usamos cualquier operador de comparación con un nulo, el resultado será desconocido y por defecto siempre será falso, ya que nose puede determinar ninguna condición de comparación.

### Funciones de conversión

Para convertir un tipo de dato a otro se usan las siguientes funciones:

- `to_char(valor, formato)`: Convierte un valor a una cadena de texto. El formato es por ejemplo `fm000000` par un número entero de 6 dígitos con ceros a la izquierda.
- `to_date(cadena, formato)`: Convierte una cadena de texto a una fecha. El formato es por ejemplo `YYYY-MM-DD`.
- `to_number(cadena, formato)`: Convierte una cadena de texto a un número. El formato es por ejemplo `9999.99`.
- `to_timestamp(cadena, formato)`: Convierte una cadena de texto a una fecha y hora. El formato es por ejemplo `YYYY-MM-DD HH24:MI:SS`.

Se puede extraer un subcampo de una fecha con la función `extract`.

```sql
EXTRACT (parte FROM fecha)
```

### Casteo

Si bien no es una función, se puede hacer un casteo de un tipo de dato a otro con la siguiente sintaxis:

```sql
CAST(valor AS tipo)
```

### Otras funciones

- `COALESCE(valor1, valor2, ..., valorN)`: Devuelve el primer valor no nulo.
- `NULLIF(valor1, valor2)`: Devuelve nulo si los valores son iguales, de lo contrario devuelve el primer valor.
- `round(valor, decimales)`: Redondea un valor a la cantidad de decimales indicada.
- `upper(cadena)`: Convierte una cadena a mayúsculas.
- `lower(cadena)`: Convierte una cadena a minúsculas.
- `initcap(cadena)`: Convierte la primera letra de cada palabra a mayúsculas.
- `length(cadena)`: Devuelve la longitud de una cadena.
- `trim([LEADING | TRAILING | BOTH] caracteres FROM cadena)`: Elimina los caracteres indicados al principio, al final o en ambos extremos de una cadena.
- `ltrim(cadena)`: Elimina los espacios en blanco al principio de una cadena.
- `rtrim(cadena)`: Elimina los espacios en blanco al final de una cadena.
- `substr(cadena, posición, longitud)`: Devuelve una subcadena de una cadena.
- `replace(cadena, buscar, reemplazar)`: Reemplaza una subcadena por otra en una cadena.
- `to_ascii(cadena)`: Convierte una cadena a su representación ASCII.
- `to_hex(cadena)`: Convierte una cadena a su representación hexadecimal.
- `to_json(valor)`: Convierte un valor a su representación JSON.
- `to_xml(valor)`: Convierte un valor a su representación XML.

... y muchas más.

### Comparación con patrones

Para comparar con patrones se usa la claúsula `LIKE`.

- `%`: Cualquier cantidad de caracteres.
- `_`: Un solo caracter.

```sql
expresion LIKE patron
```

Un patrón puede ser una cadena de texto o una expresión regular (en algunos motores de base de datos).

Ejemplo:

```sql
SELECT *
FROM empleados
WHERE nombre LIKE '_A%';
```

Este ejemplo devolverá todos los empleados cuya nombre empiece con cualquier caracter, seguido de una A y cualquier cantidad de caracteres (incluyendo ninguno).

Por otro lado, si no importa si la A es mayúscula o minúscula, se puede usar la claúsula `ILIKE`.

```sql
SELECT *
FROM empleados
WHERE nombre ILIKE '_A%';
```

Finalmente muchos motores de base de datos permiten usar expresiones regulares o aproximaciones a ellas con la claúsula `SIMILAR TO`.

### Expresiones condicionales

Para hacer una expresión condicional se usa la claúsula `CASE`.

```sql
CASE
    WHEN condición1 THEN resultado1
    WHEN condición2 THEN resultado2
    ...
    ELSE resultadoN
END
```

Esto es equivalente a un `switch` o `if` en otros lenguajes de programación.

### Condición del WHERE

La condición del `WHERE` puede ser una combinación de condiciones con los operadores lógicos `AND`, `OR` y `NOT`.

Esta devolverá los registros cuyo resultado de la condición sea verdadero. Podemos pensar que se evalúa fila por fila (aunque no es necesariamente así).

### Alias

Para darle un nombre a una columna se usa la claúsula `AS`.

```sql
SELECT columna1 AS alias1, columna2 AS alias2
FROM tabla1 AS alias_tabla1, tabla2 AS alias_tabla2
[ WHERE condición ];
```

Incluso se puede no poner el `AS` y simplemente poner el nombre de la tabla si el motor de base de datos lo permite.

```sql
SELECT columna1 alias1, columna2 alias2
FROM tabla1 alias_tabla1, tabla2 alias_tabla2
[ WHERE condición ];
```

Esto además le da un nombre a las tablas, lo que puede ser útil para evitar ambigüedades y nos permite mostrar el nombre en la tabla resultante.

### Ordenamiento

Se puede ordenar los resultados por una o más expresiones con la claúsula `ORDER BY`.

```sql
ORDER BY expresion1 [ ASC | DESC ] [ , expresion2 [ ASC | DESC ] ... ]
```

### Limitar filas devueltas y paginado

Se puede solicitar un número limitado de filas. De forma estandar se usa `FETCH FIRST` y `OFFSET`.

Fetch first buscara las primeras n filas desde el número de fila indicado por offset.

```sql
SELECT columna1, columna2
FROM tabla1
ORDER BY columna1
FETCH FIRST 10 ROWS ONLY
OFFSET 10 ROWS;
```

Esto devolverá las filas 11 a 20.

Ahora muchos motores de base de datos permiten usar `LIMIT` y `OFFSET`.

```sql
SELECT columna1, columna2
FROM tabla1
ORDER BY columna1
LIMIT 10
OFFSET 10;
```

Lo cual tendrá el mismo resultado.

Lo que más sentido tiene es usar `LIMIT` y `OFFSET` en conjunto con `ORDER BY` ya que de otra forma el resultado no será determinista.

### Joins

Los joins permiten combinar los resultados de dos o más tablas. Existen varios tipos de joins:

- `JOIN` o `INNER JOIN`: Devuelve los registros que tienen un valor coincidente en ambas tablas.
- `LEFT JOIN` o `LEFT OUTER JOIN`: Devuelve todos los registros de la tabla de la izquierda y los registros coincidentes de la tabla de la derecha, los registros de la tabla de la derecha que no tienen coincidencias en la tabla de la izquierda tendrán valores nulos.
- `RIGHT JOIN` o `RIGHT OUTER JOIN`: Devuelve todos los registros de la tabla de la derecha y los registros coincidentes de la tabla de la izquierda, los registros de la tabla de la izquierda que no tienen coincidencias en la tabla de la derecha tendrán valores nulos.
- `FULL JOIN` o `FULL OUTER JOIN`: Devuelve todos los registros cuando hay una coincidencia en la tabla de la izquierda o en la tabla de la derecha, los registros que no tienen coincidencias en la tabla de la izquierda o en la tabla de la derecha tendrán valores nulos.

Para hacer un join se usa la claúsula `JOIN`.

```sql
SELECT columna1, columna2
FROM tabla1
INNER | LEFT | RIGHT | FULL JOIN tabla2 ON tabla1.columna = tabla2.columna
[ ... ]
[ INNER | LEFT | RIGHT | FULL JOIN tablaN ON ... ];
```

Existe la claúsula `USING` que permite hacer un join por una columna que se llame igual en ambas tablas.

```sql
SELECT columna1, columna2
FROM tabla1
JOIN tabla2 USING (columna);
```

También se puede hacer un `NATURAL JOIN` que es un join implícito por todas las columnas que se llamen igual en ambas tablas.

```sql
SELECT columna1, columna2
FROM tabla1
NATURAL JOIN tabla2;
```

Por último, se pueden agrgar condiciones adicionales en la claúsula `ON` que no relacionen una tabla con otra.

```sql
SELECT columna1, columna2
FROM tabla1
JOIN tabla2 ON tabla1.columna = tabla2.columna
AND tabla2.columna2 = 'valor';
```

### Operadores de conjuntos

Los operadores de conjuntos permiten combinar los resultados de dos o más consultas.

- `UNION [ALL]` : Devuelve los registros de ambas consultas
- `INTERSECT [ALL]` : Devuelve los registros que están en ambas consultas
- `EXCEPT [ALL]` : Devuelve los registros que están en la primera consulta pero no en la segunda.

```sql
SELECT ... UNION | INTERSECT | EXCEPT [ALL] SELECT ...;
```

Las consultas deben tener la misma cantidad de columnas y los tipos de datos deben ser compatibles.

La opción `ALL` hace que se devuelvan todos los registros, de lo contrario se devuelven los registros únicos.

### Subconsultas / Consultas anidadas

Las subconsultas permiten hacer consultas dentro de otras consultas.

Estas se pueden usar como:

- Una tabla temporal
- Una lista de valores
- Un escalar

```sql
SELECT ...
FROM ... , (SELECT ... FROM ...) alias
```

Se puede usar un alias para luego referenciar la subconsulta.

### Operadores de comparación de conjuntos

Los operadores de comparación de conjuntos permiten comparar los resultados de dos o más consultas.

- `SOME` o `ANY` : Devuelve verdadero si al menos un registro cumple la condición
- `ALL` : Devuelve verdadero si todos los registros cumplen la condición

```sql
SELECT ...
FROM ...
WHERE columna (= | < | > | <= | >= | <>) (SOME | ANY | ALL) (SELECT ... FROM ...);
```

### Operador IN

El operador `IN` permite comparar una expresión con una lista de valores.

```sql
SELECT ...
FROM ...
WHERE columna IN (SELECT ... FROM ...);
```

Tiene el mismo comportamiento que hacer:

```sql
SELECT ...
FROM ...
WHERE columna = ANY (SELECT valor FROM ...);
```

O se puede dar una lista de valores.

```sql
SELECT ...
FROM ...
WHERE columna IN (valor1, valor2, ..., valorN);
```

Se puede usar con varias expresiones al mismo tiempo y eso devolverá verdadero si al menos una de las expresiones es verdadera.

### Consultas correlacionadas

Una consulta correlacionada es una subconsulta que depende de una consulta externa.

```sql
SELECT columna1, columna2
FROM tabla
WHERE columna OPERADOR (SELECT columna FROM tabla2 WHERE tabla2.columna = tabla.columna);
```

El problema de las consultas correlacionadas es que son muy lentas ya que se ejecutan por cada fila de la tabla externa.

### Operador EXISTS

El operador `EXISTS` permite verificar si una subconsulta devuelve algún registro.

```sql
SELECT ...
FROM ...
WHERE [ NOT ] EXISTS (SELECT ... FROM ...);
```

No mira los valores de la subconsulta, solo si devuelve algún registro, incluso si es nulo.

### Funciones de agregación

Las funciones de agregación permiten realizar cálculos sobre un conjunto de registros.

- `COUNT( [DISTINCT ] expresion)`: Cuenta el número de registros, si se usa `DISTINCT` cuenta los valores únicos. No cuenta los valores nulos. Pero si se usa `COUNT(*)` cuenta todos los registros (incluyendo los registros nulos).
- `SUM(expresion)`: Suma los valores de una columna.
- `AVG(expresion)`: Calcula el promedio de los valores de una columna.
- `MIN(expresion)`: Devuelve el valor mínimo de una columna.
- `MAX(expresion)`: Devuelve el valor máximo de una columna.

Todas las filas que hubieran sido devueltas, forman un grupo y se devolverá un solo valor para cada función.

### Agrupamiento

Se define como se agrupan las filas con la claúsula `GROUP BY`.

```sql
SELECT columna1, columna2, funcion_agregación(columna3)
FROM tabla
GROUP BY columna1, columna2;
```

De esta forma se agrupan todas las filas que tengan el mismo valor en columna1 y columna2 y se aplica la función de agregación a columna3.

Solo se puede mostrar en el `SELECT` las columnas que estén en el `GROUP BY` o las funciones de agregación.

Luego estas se pueden ordenar con el `ORDER BY` donde nuevamente solo se pueden ordenar por las columnas que estén en el `GROUP BY` o las funciones de agregación.

Si agrupamos por una clave primaria, entonces podemos agregar más columnas tanto al `SELECT` como al `GROUP BY` sin cambios en el resultado final pero con más información disponible.

### Filtrado de grupos

Para filtrar los grupos se usa la claúsula `HAVING`.

```sql
SELECT columna1, columna2, funcion_agregación(columna3)
FROM tabla
GROUP BY columna1, columna2
HAVING condición;
```

Esto nos permite filtrar posteriormente a la formación de grupos.

Esto es importante porque en la clausa `WHERE` se filtran las filas antes de agruparlas, mientras que en la claúsula `HAVING` se filtran los grupos después de agruparlos.

### Inserción de registros

Para insertar registros en una tabla se usa la siguiente sentencia:

```sql
INSERT INTO nombre_tabla [ (columna1, columna2, ..., columnaN) ]
VALUES (valor1, valor2, ..., valorN) [ , (valor1, valor2, ..., valorN) ... ];
```

Se revisan todas las regas de integridad.

Si falla alguna regla, no se inserta nada.

También se puede insertar registros de una consulta.

```sql
INSERT INTO nombre_tabla [ (columna1, columna2, ..., columnaN) ]
SELECT columna1, columna2, ..., columnaN
FROM tabla;
```

Con la opción `RETURNING` se puede devolver los valores de las columnas que se insertaron.

```sql
INSERT INTO nombre_tabla [ (columna1, columna2, ..., columnaN) ]
VALUES (valor1, valor2, ..., valorN)
RETURNING columna1, columna2, ..., columnaN;
```

Esto es útil para obtener valores generados automáticamente como claves sustitutas.

### Actualización de registros

Para actualizar registros en una tabla se usa la siguiente sentencia:

```sql
UPDATE nombre_tabla
SET columna1 = valor1, columna2 = valor2, ..., columnaN = valorN
[ WHERE condición ];
```

Nuevamente se revisan todas las reglas de integridad.

En caso de no haber una condición, se actualizan todos los registros. (generalmente no es lo que se quiere).

Se puede usar el propio valor de la columna para actualizarla.

```sql
UPDATE nombre_tabla
SET columna1 = columna1 + 1
WHERE condición;
```

### Eliminación de registros

Para eliminar registros en una tabla se usa la siguiente sentencia:

```sql
DELETE FROM nombre_tabla
[ WHERE condición ];
```

Nuevamente se revisan todas las reglas de integridad.

En caso de no haber una condición, se eliminan todos los registros. (generalmente no es lo que se quiere).

### Transacciones

Una transacción es un conjunto de operaciones que se ejecutan como una sola unidad. Si una operación falla, se deshacen todas las operaciones anteriores.

Para iniciar una transacción se usa la siguiente sentencia:

```sql
BEGIN TRANSACTION;
comando1;
[ comando2; ... ]
COMMIT;
```

Una vez que se hace un `COMMIT`, no se pueden deshacer las operaciones.

El comando `ROLLBACK` deshace todas las operaciones de la transacción.

Se pueden usar `SAVEPOINT` para marcar un punto de guardado en la transacción.

### Vistas

Una vista es una tabla virtual que se crea a partir de una consulta.

No existe fisicamente en la base de datos, solo se almacena la consulta.

Se puede usar como una tabla normal para hacer consultas.

Tiene ciertas ventajas:

- Simplifica las consultas, reduciendo la complejidad de posteriores consultas.
- Permite restringir el acceso a las tablas.
- Cambios en la representación de los datos sin cambiar la estructura de las tablas.

Para crear una vista se usa la siguiente sentencia:

```sql
CREATE VIEW nombre_vista 
[ (columna1, columna2, ..., columnaN) ]
AS consulta_SQL
[ WITH [ CASCADED | LOCAL ] CHECK OPTION ];
```

En cuanto a inserciones, actualizaciones y eliminaciones, se pueden hacer en una vista si cumple con las siguientes condiciones:

- Tiene una única tabla base en el `FROM`.
- No tiene operadores de conjuntos.
- No usa agrupamientos.
- No limita el número de filas.
- Solo se pueden actualizar valores de las columnas accedidas directamente.

El `WITH CHECK OPTION` permite que no se puedan insertar registros que no cumplan con la condición de la vista. Es decir que si se inserta un registro en la vista, este debe ser visible en la vista, caso contrario no se inserta. Si se usa `CASCADED` se aplica a todas las vistas que dependan de la vista, si se usa `LOCAL` solo se aplica a la vista.

Para eliminar una vista se usa la siguiente sentencia:

```sql
DROP VIEW nombre_vista;
```

### With

Permite crear una consulta auxiliar temporal que se puede usar en la consulta principal.

Permite evitar la repetición de consultas al asignar un nombre a una consulta.

```sql
WITH nombre_cte (columna1, columna2, ..., columnaN) AS (
    consulta
)
SELECT ...
FROM nombre_cte
[ WHERE condición ];
```

### With Recursivo

La opción `RECURSIVE` permite hacer una consulta recursiva.

```sql
WITH RECURSIVE nombre_cte (columna1, columna2, ..., columnaN) AS (
    consulta_inicial
    UNION
    consulta_recursiva
)
SELECT ...
```

Esta consulta recursiva se puede usar para hacer búsquedas en profundidad en una estructura jerárquica.

Esta recursión se detiene cuando la consulta recursiva no devuelve ningún registro nuevo.

## DCL: Lenguaje de control de acceso a los datos

Permiten controlar el acceso a los datos para bases de datos multiusuario.

Hay bastantes diferencias entre los motores de base de datos en cuanto a la implementación de estas sentencias.

Vamos a ver un sistema de usuarios, roles y permisos.

### Usuarios

Para crear un usuario se usa la siguiente sentencia:

```sql
CREATE USER nombre_usuario [ WITH PASSWORD 'contraseña' ];
```

Para eliminar un usuario se usa la siguiente sentencia:

```sql
DROP USER nombre_usuario;
```

### Roles

Un rol es un conjunto de permisos que se pueden asignar a un usuario.

Muchas veces los roles son "polimorfico" con los usuarios.

La idea de todas formas es que los roles se asignen a los usuarios.

Para crear un rol se usa la siguiente sentencia:

```sql
CREATE ROLE nombre_rol;
```

Para eliminar un rol se usa la siguiente sentencia:

```sql
DROP ROLE nombre_rol;
```

Para asignar un rol a un usuario se usa la siguiente sentencia:

```sql
GRANT nombre_rol TO nombre_usuario;
```

Para quitar un rol a un usuario se usa la siguiente sentencia:

```sql
REVOKE nombre_rol FROM nombre_usuario;
```

### Permisos

Se pueden dar una serie de permisos a un usuario o rol.

Para ello se usa la siguiente sentencia:

```sql
GRANT privilegio1 [, privilegio2, ..., privilegioN ]
ON [ nombre_tabla | DATABASE nombre_base_datos ]
TO nombre_usuario | nombre_rol;
[ WITH GRANT OPTION ];
```

Los privilegios pueden ser:

- `SELECT`: Permite leer los datos de una tabla.
- `INSERT`: Permite insertar registros en una tabla.
- `UPDATE`: Permite actualizar registros en una tabla.
- `DELETE`: Permite eliminar registros de una tabla.
- `TRIGGER`: Permite crear triggers en una tabla.
- `CREATE`: Permite crear tablas.

Un ejemplo de permisos sería:

El `WITH GRANT OPTION` permite que el usuario o rol pueda dar los permisos a otros usuarios o roles.

### Vistas para restricciones de acceso

Se pueden dar permisos por columnas o filas mediante el uso de vistas.

Para ello se crea una vista que filtra los datos y se dan los permisos a la vista al usuario o rol.

## Fuera del alcanze de este curso

- **Stored Procedures**: Son subrutinas almacenadas en la base de datos que se pueden invocar desde una aplicación.
- **Triggers**: Son procedimientos almacenados que se ejecutan automáticamente cuando se produce un evento en la base de datos.
- **Windows Functions**: Son funciones que se aplican a un conjunto de filas y devuelven un único valor.
- **Materialized Views**: Son vistas que almacenan los resultados de una consulta para mejorar el rendimiento.
- **EXPLAIN**: Permite ver el plan de ejecución de una consulta.
- **Customize Types**: Permite crear tipos de datos personalizados.
- **Customize Functions**: Permite crear funciones personalizadas.
