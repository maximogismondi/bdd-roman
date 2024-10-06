# Resolución

Máximo Gismondi - 110119

## Ejercicio 1

R(A, B, C, D, E, G, H)

Fm ={
    AD  -> G,
    B   -> H,
    BD  -> E,
    HG  -> D,
    CDE -> A,
    GDE -> C
}

### Paso 1 - Inicializar C a R

C = {A, B, C, D, E, G, H}

### Paso 2 - Detectar atributos independientes

No hay atributos independientes.

- Ai = {}
- C = {A, B, C, D, E, G, H}

### Paso 3 - Detectar atriburos equivalentes

A simple vista no parece haber atributos equivalentes.

- Ai = {}
- C = {A, B, C, D, E, G, H}

### Paso 4 - Buscar atributos puramente implicantes

Como B solamente se encuntra del lado de los implicantes de las dependencias funcionales, entonces B tiene que si o si pertenecer a las claves candidatas.

Calculo la clausura de K:

- K = {B}
- K+Fm = {B}+ = {B, H}
- C = C - K+Fm = {A, C, D, E, G}

Remuevo las dependencias funcionales que ya no me sirven:

- Fm = {
    AD  -> G,
    B   -> H,
    BD  -> E,
    HG  -> D,
    CDE -> A,
    GDE -> C
}

- Fm2 = {
    AD  -> G,
    D   -> E,
    G   -> D,
    CDE -> A,
    GDE -> C
}

Como tanto B pertenecerá a todas las claves, también lo hará la clausura de B y por lo tanto siempre tendremos B y H como clausara de nuestra potencial clave candidata.

### Paso 5 - Buscar claves candidatas

Ahora si buscamos las claves candidatas iterando sobre los posibles atributos que son tanto implicantes como implicados.

- C = {A, C, D, E, G}

Pruebo con A

- K1 = {A}
- K1+Fm2 = {A}+ = {A} -> K1 NO es clave candidata

Pruebo con C

- K2 = {C}
- K2+Fm2 = {C}+ = {C} -> K2 NO es clave candidata

Pruebo con D

- K3 = {D}
- K3+Fm2 = {D}+ = {D, E} -> K3 NO es clave candidata

Pruebo con E

- K4 = {E}
- K4+Fm2 = {E}+ = {E} -> K4 NO es clave candidata

Pruebo con G

- K5 = {G}
- K5+Fm2 = {G}+ = {G, D, E, C, A} -> K5 es una clave clave candidata de C

Ahora mi set de atributos de prueba se reduce a:

- C2 = {A, C, D, E}

Pruebo con tamaño 2

Pruebo con AC

- K6 = {A, C}
- K6+Fm2 = {A, C}+ = {A, C} -> K6 NO es clave candidata

Pruebo con AD

- K7 = {A, D}
- K7+Fm2 = {A, D}+ = {A, D, G, E, C} -> K7 es una clave candidata de C

Pruebo con AE

- K8 = {A, E}
- K8+Fm2 = {A, E}+ = {A, E} -> K8 NO es clave candidata

Pruebo con CD

- K9 = {C, D}
- K9+Fm2 = {C, D}+ = {C, D, E, G, A} -> K9 es una clave candidata de C

Pruebo con CE

- K10 = {C, E}
- K10+Fm2 = {C, E}+ = {C, E} -> K10 NO es clave candidata

Pruebo con DE

- K11 = {D, E}
- K11+Fm2 = {D, E}+ = {D, E} -> K11 NO es clave candidata

Ahora mi set de atributos de prueba se reduce a:

- C3 = {E}

Como no puedo hacer combinacions de tamaño 3, ya no hay más claves candidatas.

Mi set de claves hayadas son:

- CK_tent = {G, AD, CD}

### Paso 6 - Agregar atributos a las claves candidatas

Como B era un atributo puramente implicante (K) debemos agregarlo a todas las claves candidatas.

- CK = {BG, ABD, BCD}

### Paso 7 - Intercambiar atributos equivalentes

Como no encontramos atributos equivalentes, no hay nada para hacer en este paso.

### Paso 8 - Verificar claves candidatas

Verificamos que las claves candidatas encontradas sean efectivamente claves.

Para ello retomamos el Fm original y calculamos las clausuras de las claves candidatas.

- Fm = {
    AD  -> G,
    B   -> H,
    BD  -> E,
    HG  -> D,
    CDE -> A,
    GDE -> C
}

Clave 1

- CK1 = {BG}
- CK1+Fm = {BFG}+ = {B, G, H, D, E, C, A} -> CK1 es clave

Clave 2

- CK2 = {ABD}
- CK2+Fm = {ABDF}+ = {A, B, D, H, E, G, C} -> CK2 es clave

Clave 3

- CK3 = {BCD}
- CK3+Fm = {BCDF}+ = {B, C, D, H, E, A, G} -> CK3 es clave

### Conclusión - Ejercicio 1

Las claves candidatas de R son:

- CK = {BG, ABD, BCD}

Ya que nos permiten determinar todos los atributos de R a partir de ellas siguiendo las dependencias funcionales Fm.

## Ejericio 2

R = (A, B, C, D, E, F, G, H)
Fm = {
    AG  -> B,
    D   -> H,
    EC  -> A,
    HE  -> D
}
CK = {CEGD, CEGH}

Se aplica el primer paso de descomposición FNBC con respecto a la dependencia funcional EC -> A.

- R1 = (A, C, E) con F1 y CK1
- R2 = (B,C,D,E,G,H) con F2 y CK2

Hay que buscar F1, F2, CK1 y CK2.
Indicar cual es la máxima forma normal en la que se encuentra cada relación.

### F1

En este caso las dependencias funcionales son:

- F1 = {
    EC -> A
}

No hay dependencias implicitas ya que A por si sola no puede determinar a ningun otro atributo.

### CK1

Para encontrar las claves candidatas de R1, primero calculamos la clausura de EC.

- K1 = {CE}
- K1+F1 = {CE}+ = {C, E, A} -> K1 es clave candidata

- CK1 = {CE}

### F2

En este caso las dependencias funcionales son:

- F2 = {
    ECG  -> B,
    D   -> H,
    HE  -> D
}

### CK2

Como {E, C, G} son solo implicantes de dependencias funcionales, entonces las 3 deben pertenecer a las claves candidatas.

Luego nos quedan las dependencias funcionales:

- F21 = {
    D -> H,
    H -> D
}

Como son equivalentes, entonces podemos usar cada una de ellas como parte de las claves candidatas.

- CK2 = {CDEG, CEGH}

### Formas normal R1

Probamos con FNBC:

Como en F1 hay tan sola una dependencia funcional y el implicante de la misma (CE) es una superclave, entonces R1 está en FNBC.

### Formas normal R2

Probamos con FNBC:

En F2 hay varias dependencias funcionales:

- ECG -> B: ECG NO es superclave    -> R2 NO está en FNBC
- D -> H: D NO es superclave        -> R2 NO está en FNBC
- HE -> D: HE NO es superclave      -> R2 NO está en FNBC

Como ninguna de las dependencias funcionales cumple con FN3, entonces R2 NO está en FN3.

Probamos con FN3:

- ECG -> B: ECG NO es superclave y B es NO primo    -> R2 NO está en FN3
- D -> H: D NO es superclave y H es primo           -> R2 puede estar en FN3
- HE -> D: HE NO es superclave y D es primo         -> R2 puede estar en FN3

Como una de las dependencias funcionales no cumple con FN3, entonces R2 NO está en FN3.

Probamos con FN2:

- ECG -> B: B NO es primo                   -> R2 puede estar en FN2
- D -> H: H es primo y D NO es superclave   -> R2 NO está en FN2
- HE -> D: D es primo y HE NO es superclave -> R2 NO está en FN2

Como una de las dependencias funcionales no cumple con FN2, entonces R2 NO está en FN2.

Probamos con FN1:

No posee atributos multivaluados ni compuestos, por lo que R2 está en FN1.

### Conclusión - Ejercicio 2

- F1 = {
    EC -> A
}
- F2 = {
    ECG  -> B,
    D   -> H,
    HE  -> D
}
- CK1 = {CE}
- CK2 = {CDEG, CEGH}
- R1 está en FNBC y R2 está en FN1.

## Ejercicio 3

- JuanciTron(
    version,
    precio,
    material_chasis,
    numero_serie,
    alias,
    autonomia,
    puede_resolver_parcialito,
    fecha_venta,
    DNI_comprador,
    nombre_comprador
)

Identificar al menos 4 dependencias funcionales no triviales.

F = {
    precio, material_chasis -> version
    alias, autonomía, puede_resolver_parcialito -> numero_serie
    DNI_comprador -> nombre_comprador,
    fecha_venta, DNI_comprador -> numero_serie
}
