# Diseño relacional

## Dependencias Funcionales

Una dependencia funcional es una relación entre dos conjuntos de atributos de una relación de una base de datos. Más concretamente, dado una serie de atributos $X$ y otra serie de atributos $Y$, se dice que $Y$ es funcionalmente dependiente de $X$ si y solo si para cada valor de $X$ existe un solo valor de $Y$.

También se dice que $X$ implica funcionalmente a $Y$ y se denota como $X \rightarrow Y$.

Dada unas tuplas $t1$ y $t2$ de una relación $R$, si $X \rightarrow Y$ entonces $t1[X] = t2[X] \rightarrow t1[Y] = t2[Y]$.

Cuando $Y \subseteq X$ se dice que $X$ determina trivialmente a $Y$.

### Inferencia de dependencias funcionales

Los Axiomas de Armstrong son un conjunto de reglas que permiten inferir nuevas dependencias funcionales a partir de dependencias funcionales existentes. Dado un conjunto de dependencias funcionales $F$, las reglas de Amstrong permiten inferir nuevas dependencias funcionales a partir de $F$.

Las reglas de inferencia de Armstrong son:

- **Reflexividad**: Si $Y \subseteq X$ entonces $X \rightarrow Y$.
- **Aumento**: $\forall W: X \rightarrow Y$ entonces $XW \rightarrow YW$.
- **Transitividad**: Si $X \rightarrow Y$ y $Y \rightarrow Z$ entonces $X \rightarrow Z$.

A partir de estos "axiomas" se pueden inferir nuevas reglas de dependencias funcionales:

- **Unión**: Si $X \rightarrow Y$ y $X \rightarrow Z$ entonces $X \rightarrow YZ$.
- **Pseudotransitividad**: $\forall W: X \rightarrow Y$ y $WY \rightarrow Z$ entonces $XW \rightarrow Z$.
- **Descomposición**: Si $X \rightarrow YZ$ entonces $X \rightarrow Y$ y $X \rightarrow Z$.

### Tipos de dependencias funcionales

- **Dependencias funcionales triviales**: Una dependencia funcional $X \rightarrow Y$ es trivial si y solo si $Y \subseteq X$.

- **Dependencias funcionales parciales**: Una dependencia funcional $X \rightarrow Y$ es parcial cuando existe un subconjunto propio $A \subset X, A \neq X$ tal que $A \rightarrow Y$.

- **Dependencias funcionales completas**: Una dependencia funcional $X \rightarrow Y$ es completa si y solo si no es parcial.

- **Dependencias funcionales transitivas**: Una dependencia funcional $X \rightarrow Z$ es transitiva si y solo si existe una dependencia funcional $X \rightarrow Y$ y $Y \rightarrow Z$, siendo $Y \rightarrow Z$ no trivial, $X \rightarrow Z$ no trivial y $Y \not\rightarrow X$. Aclaración: toda las dependencias funcionales parciales no trivial son transitivas.

- **Dependencias funcionales multivaluadas**: Una dependencia funcional $X \twoheadrightarrow Y$ es multivaluada si y solo si para cada valor de $X$ existe un y solo un conjunto de valores de $Y$. (Ejemplo: `MCCombo -> {Producto1, Producto2, Producto3}` y más concretamente `BigMacCombo -> {BigMac, Papas, Coca}`).

### Clausura de conjuntos de dependencias funcionales y de atributos

Dada una relación $R(A1, A2, ..., An)$ y un conjunto de dependencias funcionales $F$, la clausura de $F$ (denotada como $ F+ $) es el conjunto de dependencias funcionales que se pueden inferir a partir de $F$. Esto es:

$$ F+ = \{ X \rightarrow Y | F \models X \rightarrow Y \} $$

Dado un conjunto de atributos $X$, la clausura de $X$ con respecto a $F$ (denotada como $X^+_F$) es el conjunto de atributos $A_i$ tal que $X \rightarrow A_i$ se puede inferir a partir de $F$. Esto es:

$$ X^+_F = \{ A_i | F \models X \rightarrow A_i \} $$

Si volvemos a las claves candidatas, podemos decir que una clave candidata $CK$ es un conjunto de atributos tal que $CK^+ = A_1, A_2, ..., A_n = R$ y ningún subconjunto propio de $CK$ cumple con la misma condición.

Si queremos saber si dos conjuntos de atributos $X$ e $Y$ son equivalentes, podemos decir que $X = Y$ si y solo si $X^+_F = Y^+_F$.

**Algoritmo para calcular la clausura de un conjunto de atributos**:

```pseudo
1. Inicializar $X^+_F = X$.
2. Mientras haya cambios en $X^+_F$:
    1. Para cada dependencia funcional ($Y \rightarrow Z$) en $F$:
        1. Si $Y \subseteq X^+_F$ entonces agregar $Z$ a $X^+_F$.
3. Retornar $X^+_F$.
```

### Cubrimiento minimal

Un conjunto de dependencias funcionales $F$ es minimal si y solo si no se pueden eliminar dependencias funcionales de $F$ sin que la clausura de $F$ cambie.

Este cubrimiento minimal se puede obtener a partir de un conjunto de dependencias funcionales $F$ y se denota como $F_m$.

Las reglas para reducir un conjunto de dependencias funcionales son:

- **Implicante atómico**:Todo implicado (lado derecho) de una dependencia funcional de $F_m$ debe ser un único atributo, es decir simple. $X \rightarrow AB$ se reduce a $X \rightarrow A$ y $X \rightarrow B$.
- **Determinante reducido**: Todo determinante (lado izquierdo) de una dependencia funcional de $F_m$ es reducido, en el sentido de no contener atributos redundantes. Es decir, si tenemos $AB \rightarrow C$ y $A \rightarrow B$ entonces se reduce la dependencia funcional de $AB \rightarrow C$ a $A \rightarrow C$.
- **Dependencias funcionales fundamentales**: $F_m$ no contiene dependencias funcionales redundantes. Es decir, si tenemos $X \rightarrow Y$, $Y \rightarrow Z$ y $X \rightarrow Z$ entonces se elimina la dependencia funcional $X \rightarrow Z$ ya que se puede inferir a partir de las otras dos.

Para hayar esto, debemos seguir los siguientes pasos:

1. Dejar todos los implicantes atómicos.
2. Simplificar los determinantes redundantes. Si tenemos $B \subset A^+_F$ y $AB \rightarrow C$ entonces podemos reducir la dependencia funcional a $A \rightarrow C$.
3. Eliminar las dependencias funcionales redundantes. Si tenemos $X \rightarrow Y$ y $Y \subset X^+_{F-\{X\rightarrow Y\}}$ entonces eliminamos la dependencia funcional $X \rightarrow Y$.

### Tipos de claves

- **Superclave**: Un conjunto de atributos $X$ es una superclave si y solo si $X^+_F = R$ donde $R$ es el conjunto de atributos de la relación y $F$ es un conjunto de dependencias funcionales.
- **Clave candidata**: Una superclave minimal, es decir, una superclave que no contiene subconjuntos propios que sean superclaves.
- **Clave primaria**: Una clave candidata que se elige como clave principal de la relación.

**Algoritmo para encontrar claves candidatas**:

Dado un $R(A1, A2, ..., An)$ y un conjunto de dependencias funcionales $F$, el algoritmo para encontrar las claves candidatas es:

```pseudo
1. Hayar el cubrimiento minimal $F_m$ de $F$. Inicializar $C = R$.
2. Detectar atributos independientes del cálculo $A_i$ (atributos que no están en ninguna dependencia funcional), y eliminarlos de $C$ y reservarlos para después. $C$ = $C - A_i$.
3. Eliminar atributos equivalentes de $C$ (dejar solo uno de los atributos equivalentes). $Ae_1$ y $Ae_2$ son equivalentes si $Ae_1^+_{F_m} = Ae_2^+_{F_m}$. Entonces podemos eliminar $Ae_2$ de $C$. $C = C - Ae_2$. Y reemplazar $Ae_2$ por $Ae_1$ en todas las dependencias funcionales de $F_m$.
4. Se forman $K$ con todos los elementos que sean sólo implicantes $A_i$ (estén sólo en parte izquierda), se calcula $K^+_{F_m}$ y si es todo $R$ entonces $K$ es clave candidata.
5. Si $K$ no resulto clave, se busca el conjunto de elementos que estén entre los implicantes pero que puedan ser implicados, pero a su vez que no sean implicados directamente por los elemntos de $K$. Se obtiene entonces $Aid$ tal que todos los elementos sean implicantes y que sean determinantes de dependencias funcionales que a su vez no sean determinantes de dependencias funcionales de $K$ es decir $K^+_{F_M} \cap Aid = \emptyset$. 

Ahora si construimos claves formadas por $K$ y subconjuntos de $Aid$. De modo que tomamos primero subconjuntos de tamaño 1, verificamos si son claves candidatas y si lo son, las agregamos a la lista de claves candidatas y eliminamos a los elementos de $Aid$, luego seguimos con subconjuntos de tamaño 2, y así sucesivamente hasta que no queden más subconjuntos posibles de tamaño $n$ en la vuelta $n$, es decir hasta que $|Aid| < n$.

Con esto habremos formado un conjunto $K$ de claves candidatas.

6. Agregar los atributos independientes al final de cada clave candidata.

7. Para cada atributo equivalente eliminado en el paso 3, se calculan todas las nuevas claves candidatas que se pueden formar con estos atributos y se agregan a la lista de claves candidatas.
```

## Atributos primos

Un atributo $A$ es primo si y solo si $A$ es parte de alguna clave candidata.

Por ende un atributo $A$ es no primo si y solo si $A$ no es parte de ninguna clave candidata.

## Formas normales

Son una serie de estructuras con las que un esquema de base de datos cumplir o no. Estas estructuras son:

- **Primera Forma Normal (1FN)**
- **Segunda Forma Normal (2FN)**
- **Tercera Forma Normal (3FN)**
- **Forma Normal de Boyce-Codd (FNBC)**
- **Cuarta Forma Normal (4FN)**
- **Quinta Forma Normal (5FN)**

Cada forma normal es más restrictiva que la anterior, es decir, si un esquema cumple con la forma normal `n` también cumple con la forma normal `n-1`.

Estas formas normales se utilizan para evitar redundancia y anomalías en la base de datos.

### Primera Forma Normal (1FN)

Un esquema de base de datos está en 1FN si y solo si todos los atributos son atómicos, es decir, no se pueden dividir en partes más pequeñas.

Esto implica que no deben existir atributos compuestos ni atributos multivaluados.

### Segunda Forma Normal (2FN)

Un esquema de base de datos está en 2FN si y solo si está en 1FN y todos los atributos no primos son dependencias funcionales completas de las claves candidatas.

Para ello debemos identificar las dependencias funcionales parciales y descomponer la relación en varias relaciones.

#### Descomposición de una relación

Partimos de una **relación universal**: una relación que contiene todos los atributos de la relación original.

$$ R(A_1, A_2, ..., A_n) $$

Dada esta relación universal $R$ y un conjunto de dependencias funcionales $F$ decimos que un conjunto de relaciones:

$$\{R_1(B_{11}, B_{12}, ..., B_{1n_1}), R_2(B_{21}, B_{22}, ..., B_{2n_2}), ..., R_m(B_{m1}, B_{m2}, ..., B_{mn_m})\}$$

es una descomposición de $R$ si y solo si todos los atributos de $R$ están presentes en la unión de las relaciones descompuestas, es decir:

$$ \bigcup_{i=1}^{n} A_i = \bigcup_{i=1}^{m}\bigcup_{j=1}^{n_i} B_{ij} $$

Esta descomposición debe tener las siguientes propiedades:

- **Sin pérdida de información**: La unión de las relaciones debe ser igual a la relación original.
- **Preservación de dependencias funcionales**: Las dependencias funcionales de la relación original deben ser preservadas en las relaciones descompuestas. Las dependencias funcionales originales se pueden inferir a partir de las dependencias funcionales de las relaciones descompuestas.

### Tercera Forma Normal (3FN)

Un esquema de base de datos está en 3FN si y solo si está en 2FN y no existen dependencias funcionales transitivas $CK_i \rightarrow Y$ de atributos no primos (donde $Y \not\subseteq CK_i$), con $CK_i$ una clave candidata.

Otra forma de expresarlo es que para toda dependencia funcional no trivial $X \rightarrow Y$, o bien $X$ es una superclave o bien $Y - X$ contiene solo atributos primos.

### Forma Normal de Boyce-Codd (FNBC)

Un esquema de base de datos está en FNBC cuando no existen dependencias transitivas $CK \rightarrow Y$ con $CK$ una clave candidata. Es decir, eliminamos la posibilidad de tener dependencias $X \rightarrow Y$ donde $Y$ es un atributo primo.

Dicho de otra forma, una relación está en FNBC cuando para toda dependencia funcional no trivial $X \rightarrow Y$, $X$ es superclave.

El problema que resuelve la FNBC se da cuando en una relación, existen varias claves candidatas que se superponen. En este caso, la FNBC garantiza que no existan dependencias transitivas entre ellas.

El problema de la FNBC es que no garantiza que se mantengas las dependencias funcionales de forma explícita.

### Cuarta Forma Normal (4FN)

Un esquema de base de datos está en 4FN si y solo si para toda dependencia multivaluada $X \twoheadrightarrow Y$, $X$ es superclave.

- Propiedad: Si $R$ está en 4FN entonces $R$ está en FNBC.

  - **¿Demostración?**
  - Toda dependencia funcional, es una dependencia multivaluada. $X \rightarrow Y$ es equivalente a $X \twoheadrightarrow Y$.
  - Luego, si un esquema está en 4FN, no puede haber dependencias funcionales no triviales $X \rightarrow Y$ donde $X$ no sea superclave.

Lo más facil es primero pasar a FNBC y luego eliminar las dependencias multivaluadas donde $X$ no sea superclave.

### Quinta Forma Normal (5FN)

Un esquema de base de datos está en 5FN si y solo si para toda dependencia de junta $X \rightarrow\rightarrow Y$, $X$ es superclave.

Es algo medio raro, pero se da cuando tenemos dependencias de junta, es decir, dependencias que no se pueden expresar como dependencias funcionales.

Las dependencias de junta ocurren cuando se puede descomponer una relación en dos o más relaciones sin pérdida de información.
