# ==============================================================================
# ECON 520 - Ciencia de Datos para Economía y Negocios
# Tarea 02: Introducción a la Programación en R (R Base)
# ==============================================================================

# --- 1. Variables y Tipos de Datos Básicos ------------------------------------
ingreso <- 450000.50          # numeric
miembros_hogar <- 3L          # integer
estado_laboral <- "Ocupado"   # character
busca_empleo <- FALSE         # logical

class(ingreso)
class(miembros_hogar)
class(estado_laboral)
class(busca_empleo)

# --- 2. Cadenas de Texto (Strings) --------------------------------------------
sector <- "Comercio"
categoria <- "Asalariado"

nchar(sector)
texto_completo <- paste("Sector:", sector, "| Categoría:", categoria)
print(texto_completo)
grepl("Comer", sector)

# --- 3. Operadores Aritméticos, Comparación y Lógicos -------------------------
salario_base <- 350000
aguinaldo <- salario_base * 0.5
salario_total <- salario_base + aguinaldo

edad <- 22L
es_mayor <- edad >= 18
pertenece_pea <- (estado_laboral == "Ocupado" | busca_empleo == TRUE) & (edad >= 16)
print(pertenece_pea)

# --- 4. Estructuras Condicionales (If...Else) ---------------------------------
if (salario_total > 500000) {
  categoria_ingreso <- "Alto"
} else if (salario_total >= 250000) {
  categoria_ingreso <- "Medio"
} else {
  categoria_ingreso <- "Bajo"
}
print(paste("Categoría de ingreso:", categoria_ingreso))

# --- 5. Bucles (While y For) --------------------------------------------------
contador <- 1
while (contador <= 5) {
  if (contador == 3) {
    print("Condición alcanzada en 3")
    break
  }
  contador <- contador + 1
}

salarios_hora <- c(1500, 2200, 1800, 3100)
for (s in salarios_hora) {
  print(s * 8)
}

# --- 6. Estructuras de Datos: Vectores y Listas -------------------------------
edades <- c(45, 42, 16, 12)
promedio_edad <- mean(edades)

individuo <- list(
  id = 101,
  nombre = "Carlos",
  edades_familia = edades,
  activo = TRUE
)
print(individuo$nombre)

# --- 7. Estructuras de Datos: Matrices y Arrays -------------------------------
matriz_transicion <- matrix(c(80, 20, 15, 85), nrow = 2, byrow = TRUE)
colnames(matriz_transicion) <- c("Ocupado_T2", "Desocupado_T2")
rownames(matriz_transicion) <- c("Ocupado_T1", "Desocupado_T1")
print(matriz_transicion)

panel_datos <- array(1:12, dim = c(2, 2, 3))

# --- 8. Data Frames -----------------------------------------------------------
microdatos <- data.frame(
  id_persona = c(1, 2, 3),
  edad = c(34, 19, 52),
  ingreso = c(450000, 0, 780000),
  trabaja = c(TRUE, FALSE, TRUE)
)

str(microdatos)
summary(microdatos)
microdatos$ingreso

# --- 9. Factores (Factors) ----------------------------------------------------
nivel_educativo <- factor(
  c("Secundario", "Universitario", "Primario", "Secundario"),
  levels = c("Primario", "Secundario", "Universitario"),
  ordered = TRUE
)
levels(nivel_educativo)