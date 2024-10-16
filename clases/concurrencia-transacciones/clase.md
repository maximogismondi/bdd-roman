# Concurrencia en bases de datos

En las bases de datos reales, múltiples usuarios realizan operaciones de lectura y escritura simultaneamente.

El objetivo es ser los más fair posible con los usuarios, distibuyendo las tareas e intercalandolas para que la latencia sea la menor posible.

La concurrencia no solo se puede implementar con muchos procesadores, sino también con un solo procesador, utilizando el tiempo de manera equitativa.

A estos sistemas se les llama "monoprocesador", "multiprocesador" y si se replican y se distribuyen en distintos lugares, se les llama "distribuidos".

## Transacciones

Una transacción es una secuencia de operaciones que se ejecutan como una sola unidad lógica de trabajo. Una secuencia ordenada de instrucciones atómicas.

Antes del multitasking, las transacciones se serializaban, es decir, hasta no terminar una, no se podía empezar otra.

Hoy en día sabemos que en general, serializar es una mala idea, ya que se pierde tiempo de procesamiento y se empeora la experiencia de usarios cuyas transacciones son livianas.

Es por eso que se ejecutan múltiples transacciones simultaneamente, y se intercalan tanto en monoprocesadores como en multiprocesadores.

El problema es que si las transacciones comparten recursos, debe haber un overhead para que no se pisen entre ellas.

Esta técnica de procesamiento de transacciones concurrentes se llama "concurencia solapada".

En esta técnica el scheduler de los sitemas operativos se encarga de intercalar las transacciones de manera que no se pisen entre ellas tanto en monoprocesadores como en multiprocesadores.

## Modelo de datos

Consideramos que nuestra base de datos está formada por **items**.

Un item puede representar:

- El valor de un atributo de una fila determinada.
- Un bloque de disco.
- Una fila de una tabla.
- Una tabla.

Las **intrucciones atómicas** que se pueden realizar sobre los items son:

- **read_item(X)**: Lee el valor del item X y se carga en memoria.
- **write_item(X)**: Escribe el valor que está en memoria en el item X en la base de datos.

El tamaño de un item, se conoce como **granularidad** es decir si consideramos la granularidad a nivel de tabla, entonces un item es una tabla si consideramos la granularidad a nivel de fila, entonces un item es una fila, etc.

El código que la transacción ejecute, involucrará la manipulación de los datos en memoria y por ende sabes que podrían existir condiciones de carrera. Esto normalmente se resuelve con **locks** y lo implementan los SGBD.

Por otro lado, hacer una orden de escritura no es lo mismo que hacer la escritura en sí en el medio de almacenamiento. El nuevo valor puede quedar temporalmente en buffers hasta que se flushée al disco.

## ACID

- **Atomicidad**: Una transacción es una unidad atómica de trabajo. O se ejecuta completamente o no se ejecuta en absoluto.
- **Consistencia**: Una transacción lleva la base de datos de un estado consistente a otro estado consistente. Es decir no se deben romper las reglas de integridad.
- **Aislamiento**: Las transacciones se ejecutan de manera aislada, es decir, no se ven entre ellas.
- **Durabilidad**: Una vez que el SGBD informa que la transacción se ha completado, debe garantizar la persistencia de los cambios realizados.

## Implementación de SGDB

### Recuperación

Los SGBD deben garantizar que si ocurre un fallo, la base de datos pueda recuperarse a un estado consistente.

### Instrucciones especiales

Las transacciones se implementan con una serie de instrucciones especiales:

- **begin**: Inicia una transacción.
- **commit**: Finaliza una transacción e indica que se ha completado con exito y se espera que se almacenen los cambios de forma persistente.
- **abort**: Finaliza una transacción e indica que no se ha completado con exito y se espera que se reviertan los cambios (rollback).

## Anomalías

Cuando se ejecutan múltiples transacciones concurrentemente, pueden ocurrir anomalías que violen las propiedades ACID.

### Dirty read

Se presenta cuando una transacción T2 lee un item X que ha sido modificado por otra transacción T1 y que aún no ha sido confirmada. Luego T1 aborta y los cambios se pierden pero T2 ya leyó el valor.

### Lost update

Se presenta cuando dos transacciones T1 y T2 leen un item X, T1 modifica el item y luego T2 modifica el mismo item. Si T1 se confirma antes que T2, los cambios de T2 se pierden.

### Unrepeatable read

Se presenta cuando una transacción T2 lee un item X dos veces y entre las dos lecturas, otra transacción T1 modifica el item X. Luego T2 lee dos valores distintos.

### Dirty write

Se presenta cuando dos transacciones T1 y T2 escriben en un item X. Si T1 se hace primero y T2 se hace después, luego T2 se confirma y T1 se aborta, los cambios de T1 no se revierten y se pierden o bien se pierden los cambios de T2.

### Phantom

Se produce cuando una transacción T1 observa un conjunto de ítems que satisfacen un predicado (condición) y luego otra transacción T2 inserta o elimina un ítem que satisface el predicado. Luego T1 vuelve a observar el conjunto de ítems y ve un conjunto distinto.

## Serializabilidad

### Notación

- **Rt(X)**: La transacción T lee el item X.
- **Wt(X)**: La transacción T escribe el item X.
- **bt**: La transacción T comienza.
- **ct**: La transacción T termina.
- **at**: La transacción T aborta.

Con esta notación, podemos escribir una transacción de forma general como una lista de instrucciones:

$$T = {I_t^1; I_t^2; ...; I_t^{m(t)}}$$ donde $I_t^i$ es una instrucción de la transacción T y $m(t)$ es la cantidad de instrucciones de la transacción T.

Ejemplo:

- $T_1 = {b_{T_1}; R_{T_1}(X); W_{T_1}(Y); c_{T_1}}$
- $T_2 = {b_{T_2}; R_{T_2}(Y); W_{T_2}(X); c_{T_2}}$

### Solapamiento

El **solapamiento** de dos transacciones $T_1$ y $T_2$ es una lista de $m(T_1) + m(T_2)$ instrucciones en donde cada instrucción de $T_1$ y $T_2$ aparece una única vez y las instrucciones de cada transacción aparecen en el mismo orden que en la transacción original.

Existen:

$$ \frac{(m(T_1) + m(T_2))!}{m(T_1)! \cdot m(T_2)!} $$

### Ejecución serial

la pregunta es si dicho solapamiento es o no **serializable**.

Dado un conjunto de transacciones $T_1, T_2, ..., T_n$, una ejecución serial, es aquella en que las transacciones se ejecutan por completo una detrás de la otra.

Existen $n!$ posibles ordenamientos de las transacciones.

### Equivalencia

Ahora para que está ejecución sea serializable, debe ser **equivalente** a alguna ejecución serial.

Existen distintos criterios para determinar si dos ejecuciones son equivalentes:

- **Equivalencia de resultado**: Si ambos órdenes de la ejecución dejan la base de datos en el mismo estado.
- **Equivalencia de conflicto**: Si ambos órdenes de ejecución tienen los mismos conflictos. Está es muy fuerte porque no depende del estado inicial de la base de datos.
- **Equivalencia de visibilidad**: Cuando en cada órden de ejecución, cada lectura $R_{t_i}(X)$ lee el mismo valor escrito por la transacción $j$, $W_{t_j}(X)$. Además se pide que en ambos órdenes la última modificación de cada item $X$ haya sido hecho por la misma transacción.

### Conflictos

Un **conflicto** es una relación entre dos instrucciones de dos transacciones distintas que acceden al mismo item, donde al menos una de las instrucciones es de escritura.

Existen tres tipos de conflictos:

- ($R_{t_i}(X), W_{t_j}(X)$): Lectura-Escritura.
- ($W_{t_i}(X), R_{t_j}(X)$): Escritura-Lectura.
- ($W_{t_i}(X), W_{t_j}(X)$): Escritura-Escritura.

Todo par de instrucciones consecutivas ($I_1, I_2$) de un solapanmiento que no tengan conflictos, puede ser invertido sin cambiar la serializabilidad.

### Grafos de precedencia

La serializabilidad se puede determinar mediante un **grafo de precedencia**.

Dado un conjunto de transacciones $T_1, T_2, ..., T_n$, se construye un grafo dirigido $G = (V, E)$ donde:

- $V$: Los nodos son las transacciones $T_1, T_2, ..., T_n$.
- $E$: Los arcos entre los nodos $T_i$ y $T_j$ (con $i \neq j$) si y solo si existe un conflicto entre algún par de instrucciones de $T_i$ y $T_j$. Si existe ($W_{t_i}(X), R_{t_j}(X)$), ($W_{t_i}(X), W_{t_j}(X)$) o ($R_{t_i}(X), W_{t_j}(X)$).

Cada arco $(T_i, T_j)$ en el grafo representa una **precedencia** entre las transacciones $T_i$ y $T_j$ e indeica que para que el resultado sea equivalente por conflictos a una ejecución serial, entocnes en dicha ejecución serial $T_i$ debe preceder a $T_j$ (es decir debe ejecutarse antes de $T_j$).

Un orden de ejecución es serializable si y solo si el grafo de precedencia no tiene ciclos.

Si un orden de ejecución es serializable por conflictos, el orden de ejecución seria el equivalente a la ejecución de las transacciones en algunos de los ordenes topológicos del grafo de precedencia.

## Control de concurrencia basado en locks

El SGBD utiliza locks para bloquear a los recursos (items) y no permitir que mas de una transacción los use en forma simultanea.

Son insertadas por el SGBD y como instrucciones especiales en el medio de la transacción.

Una vez insertados, las transacciones compiten entre ellas por su ejecución.

Se puede garantizar la serializabilidad si se siguen las reglas de los locks.

### Instrucciones de locks

- **lock**: Bloquea el item X. $L(X)$
- **unlock**: Desbloquea el item X. $U(X)$

En general los SGBD al menos implementan dos tipos de locks:

- **Lock de lectura (shared lock)**: Permite que múltiples transacciones lean el item X, pero solo una puede escribirlo.
- **Lock de escritura (exclusive lock)**: Permite que solo una transacción lea o escriba el item X.

Entonces las transacciones deben ser las siguientes:

- **lock-shared**: $L_{sh}(X)$
- **lock-exclusive**: $L_{ex}(X)$
- **unlock-shared**: $U_{sh}(X)$
- **unlock-exclusive**: $U_{ex}(X)$

Ahora debemos seguir las siguientes reglas:

- si se quiere hacer un lock de lectura no debe haber un lock de escritura.
- si se quiere hacer un lock de escritura no debe haber un lock de lectura ni de escritura.

### Protocolo de lock de dos fases

2PL, two-phase lock, es un protocolo de control de concurrencia que garantiza la serializabilidad.

Para esto NO se puede tomar un lock sobre un item 2 veces en la misma transacción. Es decir, solo se puede tomar una vez el lock y debe ser liberado la última vez que se use.

<!-- COMPLETAR PAG 49-64 en adelante -->

## Implementación de aislamiento

### Nivel de aislamiento

SQL permite definir el nivel de aislamiento de las transacciones ya sea a nivel global:

```sql
SET TRANSACTION ISOLATION LEVEL (READ UNCOMMITTED | READ COMMITTED | REPEATABLE READ | SERIALIZABLE);
```

y/o definir el nivel para una transacción en particular:

```sql
START TRANSACTION [ISOLATION LEVEL (READ UNCOMMITTED | READ COMMITTED | REPEATABLE READ | SERIALIZABLE)];
```

### Tabla de anomalías

| Nivel de aisalmiento | Lectura sucia | Leer no repetible | Fantasma |
|----------------------|---------------|-------------------|----------|
| READ UNCOMMITTED     | Error         | Error             | Error    |
| READ COMMITTED       | OK            | Error             | Error    |
| REPEATABLE READ      | OK            | OK                | Error    |
| SERIALIZABLE         | OK            | OK                | OK       |

Si bien la anomalía de lectura sucia no se menciona en el estándar, la misma debería ser proscripta en todos los niveles de aislamiento y prácticamente todos los SGBD la evitan.

## Implementaciones

El nivel de granularidad es la fila, para minimizar el bloqueo de recursos y maximizar la concurrencia.

Para evitar incosistencias de lectura se utiliza un control de concurrencia multiversión (MVCC).

Hay como 12 tipos de locks.

<!-- HAY MAS COSITAS -->