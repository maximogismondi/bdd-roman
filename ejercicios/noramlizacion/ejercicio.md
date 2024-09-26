# Ejercicios

## Ejercicio 1

Esquema relacional: $S(A, B, C, D)$

Conjunto de dependencias funcionales: $F = \{A \rightarrow B, B \rightarrow C\}$

Buscar con algebra relacional, las tuplas que contradicen a $F$.

```rel
S1 = ρ s1 (S)
S2 = ρ s2 (S)

S1 ⨝ (s1.A = s2.A ∧ s1.B ≠ s2.B) ∨ (s1.B = s2.B ∧ s1.C ≠ s2.C) S2
```

## Ejercicio 2

Esquema relacional: $R(A, B, C, D, E)$

$F = \{C \rightarrow E, C \rightarrow B, B \rightarrow A, A \rightarrow D\}$
$F^+ = \{C \rightarrow E, C \rightarrow B, B \rightarrow A, A \rightarrow D\} \cup \{C \rightarrow A, B \rightarrow D, C \rightarrow D\}$

## Ejercicio 3

Esquema relacional: $R(A, B, C, D)$

$F = \{BC \rightarrow A, AD \rightarrow CB, CD \rightarrow AB, A \rightarrow D\}$

Aplicamos el algoritmo de Armstrong para encontrar las dependencias funcionales que se pueden deducir de $F$.

### Paso 1

$F_1 = \{BC \rightarrow A, AD \rightarrow C, AD \rightarrow B, CD \rightarrow A, CD \rightarrow B, A \rightarrow D\}$

### Paso 2

Como $A \rightarrow D$, entonces podemos reducir $AD \rightarrow C$ a $A \rightarrow C$.

Como $A \rightarrow D$, entonces podemos reducir $AD \rightarrow B$ a $A \rightarrow B$.

$F_2 = \{BC \rightarrow A, A \rightarrow C, A \rightarrow B, CD \rightarrow A, CD \rightarrow B, A \rightarrow D\}$

### Paso 3

- Pruebo sacar $BC \rightarrow A$.
- Entonces chequeo si $A \subset BC^+_{F_2 - \{BC \rightarrow A\}}$ -> No llego por lo que la tengo que dejar

$-$

- Pruebo sacar $A \rightarrow C$.
- Entonces chequeo si $C \subset A^+_{F_2 - \{A \rightarrow C\}}$ -> No llego por lo que la tengo que dejar

$-$

- Pruebo sacar $A \rightarrow B$.
- Entonces chequeo si $B \subset A^+_{F_2 - \{A \rightarrow B\}}$ -> Llego por lo que la puedo sacar
- $F_3 = \{BC \rightarrow A, A \rightarrow C, CD \rightarrow A, CD \rightarrow B, A \rightarrow D\}$

$-$

- Pruebo sacar $CD \rightarrow A$.
- Entonces chequeo si $A \subset CD^+_{F_3 - \{CD \rightarrow A\}}$ -> Llego por lo que la puedo sacar
- $F_4 = \{BC \rightarrow A, A \rightarrow C, CD \rightarrow B, A \rightarrow D\}$

$-$

- Pruebo sacar $CD \rightarrow B$.
- Entonces chequeo si $B \subset CD^+_{F_4 - \{CD \rightarrow B\}}$ -> No llego por lo que la tengo que dejar

$-$

- Pruebo sacar $A \rightarrow D$.
- Entonces chequeo si $D \subset A^+_{F_4 - \{A \rightarrow D\}}$ -> No llego por lo que la tengo que dejar

$-$

Cubrimiento mínimo: $F_M = \{BC \rightarrow A, A \rightarrow C, CD \rightarrow B, A \rightarrow D\}$

## Ejercicio 4

Esquema relacional: $R(A, B, C, D, E, F, G, H)$

$F = \{A \rightarrow CD, ACF \rightarrow G, AD \rightarrow BEF, BCG \rightarrow D, CF \rightarrow AH, CH \rightarrow G, D \rightarrow B, H \rightarrow DEG\}$

Buscar las claves candidatas de $R$.

### Paso 1 - Encontrar conjunto minimal de dependencias funcionales

$F_m = \{A \rightarrow C, A \rightarrow F, CF \rightarrow A, CF \rightarrow H, H \rightarrow D, H \rightarrow E, H \rightarrow G, BCG \rightarrow D, D \rightarrow B \}$

$C$ = {A, B, C, D, E, F, G, H}

### Paso 2 - Detectar atributos independientes

$I = \emptyset$

### Paso 3 - Eliminar atributos independientes

$Ae = \emptyset$

### Paso 4 - Hallar K inicial
