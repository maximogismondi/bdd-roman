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

## Ordenamiento
