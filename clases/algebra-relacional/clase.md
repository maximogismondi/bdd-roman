# Algebra y cálculos relacional

Para interactuar con un modelo es necesario utilizar un **lenguaje**.

Aquellos que permiten extraer información de un modelo de datos se denominan **lenguajes de manipulación de datos**. o **DML** (Data Manipulation Language).

Estos pueden ser:

- **Procedurales**: Se especifica cómo se debe hacer algo. Indicando los pasos a seguir y las operaciones a realizar. Estos son de más bajo nivel.
- **Declarativos**: Se especifica qué se quiere hacer. Indicamos que reusltados queremos obtener, pero no cómo obtenerlos. Estos son de más alto nivel.

El lenguaje práctico más conocido es **SQL** (Structured Query Language), que es un lenguaje declarativo.

Los lenguajes formales del modelo relacional son:

## Álgebra relacional

Es un lenguaje procedural.

Provee un marco formal de operaciones para el modelo relacional.

Se emplea como base para optimizar la ejecución de consultas.

Se especifican los procedimientos de consulta de datos a partir de un conjunto de **operaciones**.

Una operación es una función cuyos operandos son una o más relaciones y cuyo resultado es una relación.

$$ O: R_1 x R_2 x \ldots x R_n \rightarrow S $$

La aridad es la cantidad de operandos que recibe una operación.

Estas operaciones se pueden combinar para formar una **expresión**.

Las operaciónes básicas son las siguientes:

### Selección

Es un operador unario que selecciona un subconjunto de tuplas de una relación que satisfacen una condición.

Se denota con el símbolo $σ$.

Utilizaremos condiciones atómicas de la forma:

- $A_i ⊙ A_j$
- $A_i ⊙ c_i$ con $c_i$ constante y $\in dom(A_i)$

Donde $⊙$ es un operador de comparación:

- $=$ o $≠$ (igual o distinto)
- $<$, $≤$, $>$, $≥$ (menor, menor o igual, mayor, mayor o igual), solo para atributos cuyos dominios estén ordenados

Una condición se construye combinando condiciones atómicas con los operadores lógicos $∧$ (y), $∨$ (o) y $¬$ (no).

**Ejemplo:**

> Seleccionar aquellos jugadores del mundial que pertenecen al club local “Barcelona” y que nacieron antes del 2000.

$σ_{(\text{local\_club}=“Barcelona”)∧(birth\_year <2000)}(Players)$

### Proyección

Es un operador unario que selecciona los posibles valores de un subconjunto de atributos de una relación.

Se denota con el símbolo $π$.

Es decir que dado una relación $R(A_1, A_2, \ldots, A_n)$, un subconjunto de atributos $B = (B_1, B_2, \ldots, B_m)$, donde $B ⊆ A$, la proyección de $R$ sobre $B$, denotada $π_B(R)$, es una relación cuyas tuplas representan los posible valores de los atributos en $B$ para las tuplas de $R$.

Podemos pensar que lo que hace es proyectar cada tupla de R a un espacio de menor dimensión en que solo se encuentran los atributos de B.

**Ejemplo:**

> Liste las posiciones de juego de los jugadores.

$π_{playing\_position}(Players)$

### Asignación

Es un operador unario que asigna un nombre a una relación.

Se denota con el símbolo $←$ y nos permite "guardar" el resultado de una operación para poder utilizarlo en otra/s operación/es.

### Redominación

Es operador unario que cambia el nombre de los atributos de una relación.

Se denota con el símbolo $ρ$.

Dada una relación $R(A_1, A_2, \ldots, A_n)$, y una lista de $n$ nombres de atributos $B = (B_1, B_2, \ldots, B_n)$, la redominación de $R$ con $B$, denotada $ρ_{S(B_1, B_2, \ldots, B_n)}(R)$ produce una relación de nombre $S$ con atributos $B$ y cuyas tuplas son las mismas que las de $R$.

$ρ_{S}(R)$ Produce una reolación que sólo cambia el nombre de la relación de $R$ a $S$.

### Unión

Es una operación binaria que combina dos relaciones R(A_1, A_2, \ldots, A_n) y S(B_1, B_2, \ldots, B_m), la **union** $ R \cup S $ es una relación que contiene todas las tuplas de R y S.

Es necesario que tengan el mismo grado.

Además deben coincidin sus dominios. Es decir, $dom(A_i) = dom(B_i)$ para todo i. Esta condición se denomina **compatibilidad de unión** o **compatibilidad de tipo**.

### Intersección

Es una operación binaria que combina dos relaciones R(A_1, A_2, \ldots, A_n) y S(B_1, B_2, \ldots, B_m), la **intersección** $ R ∩ S $ es una relación que contiene todas las tuplas que estén tanto en R como en S.

Es necesario que tengan el mismo grado.

Al igual que en la unión, deben coincidin sus dominios.

### Diferencia

Es una operación binaria que combina dos relaciones R(A_1, A_2, \ldots, A_n) y S(B_1, B_2, \ldots, B_m), la **diferencia** $ R - S $ es una relación que contiene todas las tuplas de R que no estén en S.

Es necesario que tengan el mismo grado.

Al igual que en la unión, deben coincidin sus dominios.

### Producto cartesiano

Es una operación binaria que combina dos relaciones R(A_1, A_2, \ldots, A_n) y S(B_1, B_2, \ldots, B_m), el **producto cartesiano** $ R × S $ es una relación que contiene todas las combinaciones de tuplas de R y S.

Es decir, produce una nueva relación T con grado $n+m$ y cuyas tuplas son de la forma $(r, s)$, donde $r$ es una tupla de R y $s$ es una tupla de S.

El esquema de relación resultante de T es $T(A_1, A_2, \ldots, A_n, B_1, B_2, \ldots, B_m)$. Salvo, si algún atributo de R y S tiene el mismo nombre. En ese caso, por convención, se le especifica el nombre de la relación de origen $"R.A_i"$ o $"S.B_i"$.

NO requiere compatibilidad de tipo.

### Árboles de consulta

Para cada expresión de álgebra relacional se puede construir un árbol de consulta que representa el orden de ejecución de las operaciones.

### Junta

Es una operación binaria que combina dos relaciones R(A_1, A_2, \ldots, A_n) y S(B_1, B_2, \ldots, B_m), la **junta** $ R ⨝_{cond} S $ es una relación que contiene todas las tuplas de R y S que satisfacen una condición de igualdad. Básicamente es una combinación entre el producto cartesiano y la selección.

Solo se admite una condición que involucre a atributos de ambas relaciones o a una expresión que involucre a atributos de ambas relaciones.

El caso más general se denomina **junta theta** (theta join) y se denota con el símbolo $⨝$.

Cuando la junta sólo utiliza la igualdad en sus condiciones atómicas se denomina **junta por igual** (equijoin) y se denota con el símbolo $⨝_{=}$.

Por último si el atributo de igualdad tiene el mismo nombre en ambas relaciones, se puede omitir el subíndice y usar una notación más simple. Este se denomina **junta natural** (natural join) y se denota con el símbolo $*$. Además, evita la redundancia de atributos ya que elimina las columnas duplicadas.

Un ejemplo podría ser: $R * S$. Donde R y S tienen un atributo en común.

Ahora, si tienen más de un atributo en común, deben ser iguales en todos los atributos para que se realice la junta.

No es muy recomendable utilizar la junta natural ya que puede ser confuso y un cambio en la estructura de las tablas puede afectar el resultado de la consulta.

### División

Es una operación binaria que combina dos relaciones R(A_1, A_2, \ldots, A_n) y S(B_1, B_2, \ldots, B_m) $Y = A - B$, la **división** $ R ÷ S $ es una relación T(Y) que contiene todas las tuplas que:

- $t$ pertenece a $π_Y(R)$
- Para cada tupla $t_s \in S$, existe una tupla $t_r \in R$ tal que $t_r[Y] = t_s$ y $t_r[B] = t_s$.

De cierta forma es una "inversa" del producto cartesiano.

Propiedad: T es la relación mde mayor cardinalidad posible contenida en $π_Y(R)$ y que cumple que $T x S ⊆ R$.

Es decir, si $R(A)$ y $S(B)$, la división de R por S es una relación que contiene todas las tuplas de R que están relacionadas con todas las tuplas de S y devuelve todos los A que tienen todos los B de S.

Por ejemplo: si tenemos:

- Aprobaciones(alumno, TP)
- Requisitos(TP)

Entonces: $Aprobaciones ÷ Requisitos$ nos devolverá los alumnos que aprobaron todos los TP.

## Conjuntos completos de operadores

Un conjunto completo de operadores es aquel que permite expresar cualquier consulta.

Incialmente teníamos:

- Selección $σ$
- Proyección $π$
- Redominación $ρ$
- Unión $∪$
- Intersección $∩$
- Diferencia $-$
- Producto cartesiano $×$
- Junta $⨝$
- Junta natural $*$
- División $÷$

Ahora podemos tomar un subconjunto de estos operadores y obtener un **conjunto completo de operadores**:

- Selección $σ$
- Proyección $π$
- Redominación $ρ$
- Unión $∪$
- Diferencia $-$
- Producto cartesiano $×$

Ya que a partir de estos podemos obtener el resto de los operadores.

## Operadores adicionales

Las vamos a nombrar, pero no vamos a profundizar en ellas.

- La proyección generalizada: permite proyectar y hacer operaciones sobre los valores de los atributos.
- La agregación: permite realizar operaciones de agregación sobre los valores de los atributos, es decir, operaciones como contar, sumar, promediar, etc.
- La junta externa: permite obtener las tuplas que no tienen correspondencia en la otra relación en una junta, es decir NO se descartan las tuplas que no tienen una contra parte en la otra relación (left join y right join).
