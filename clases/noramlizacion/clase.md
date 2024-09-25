# Diseño relacional

## Dependencias Funcionales

Una dependencia funcional es una relación entre dos conjuntos de atributos de una relación de una base de datos. Más concretamente, dado una serie de atributos `X` y otra serie de atributos `Y`, se dice que `Y` es funcionalmente dependiente de `X` si y solo si para cada valor de `X` existe un solo valor de `Y`.

También se dice que `X` implica funcionalmente a `Y` y se denota como `X -> Y`.

Dada unas tuplas `t1` y `t2` de una relación `R`, si `X -> Y` entonces `t1[X] = t2[X] -> t1[Y] = t2[Y]`.

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

Algoritmo para calcular la clausura de un conjunto de atributos

```pseudo
1. Inicializar $X^+_F = X$.
2. Mientras haya cambios en $X^+_F$:
    1. Para cada dependencia funcional ($Y \rightarrow Z$) en $F$:
        1. Si $Y \subseteq X^+_F$ entonces agregar $Z$ a $X^+_F$.
3. Retornar $X^+_F$.
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

Un esquema de base de datos está en FNBC cuando no existen dependencias transitivas `CK \rightarrow Y` con `CK` una clave candidata. Es decir, eliminamos la posibilidad de tener dependencias `X \rightarrow Y` donde `Y` es un atributo primo.

Dicho de otra forma, una relación está en FNBC cuando para toda dependencia funcional no trivial `X \rightarrow Y`, `X` es superclave.

El problema que resuelve la FNBC se da cuando en una relación, existen varias claves candidatas que se superponen. En este caso, la FNBC garantiza que no existan dependencias transitivas entre ellas.

El problema de la FNBC es que no garantiza que se mantengas las dependencias funcionales de forma explícita.

### Cuarta Forma Normal (4FN)

Un esquema de base de datos está en 4FN si y solo si para toda dependencia multivaluada `X \twoheadrightarrow Y`, `X` es superclave.

- Propiedad: Si `R` está en 4FN entonces `R` está en FNBC.

  - **¿Demostración?**
  - Toda dependencia funcional, es una dependencia multivaluada. $X \rightarrow Y$ es equivalente a $X \twoheadrightarrow Y$.
  - Luego, si un esquema está en 4FN, no puede haber dependencias funcionales no triviales `X \rightarrow Y` donde `X` no sea superclave.

Lo más facil es primero pasar a FNBC y luego eliminar las dependencias multivaluadas donde `X` no sea superclave.

### Quinta Forma Normal (5FN)

Un esquema de base de datos está en 5FN si y solo si para toda dependencia de junta `X \rightarrow\rightarrow Y`, `X` es superclave.

Es algo medio raro, pero se da cuando tenemos dependencias de junta, es decir, dependencias que no se pueden expresar como dependencias funcionales.

Las dependencias de junta ocurren cuando se puede descomponer una relación en dos o más relaciones sin pérdida de información.
