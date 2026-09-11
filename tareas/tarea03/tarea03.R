# ==============================================================================
# ECON-520: Ciencia de Datos para Economía y Negocios
# Tarea 03: Visualización de datos con ggplot2 (R4DS)
# ==============================================================================

library(tidyverse)
library(palmerpenguins)

# ------------------------------------------------------------------------------
# 1. Exploración inicial del dataset penguins
# ------------------------------------------------------------------------------

# ¿Cuántas filas y columnas tiene penguins?
nrow(penguins)
ncol(penguins)
glimpse(penguins)

# ------------------------------------------------------------------------------
# 2. Gráfico de dispersión básico y estética
# ------------------------------------------------------------------------------

# Relación entre bill_depth_mm (profundidad) y bill_length_mm (longitud)
ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point(na.rm = TRUE) +
  labs(
    title = "Longitud vs. Profundidad del pico",
    x = "Longitud del pico (mm)",
    y = "Profundidad del pico (mm)"
  )

# ¿Qué sucede si hacemos un scatterplot de species vs bill_depth_mm?
# No es el gráfico ideal porque 'species' es categórica; un boxplot o jitter es más informativo:
ggplot(data = penguins, aes(x = species, y = bill_depth_mm)) +
  geom_boxplot() +
  labs(title = "Distribución de profundidad del pico por especie")

# ------------------------------------------------------------------------------
# 3. Incorporación de variables categóricas (color, forma, facetas)
# ------------------------------------------------------------------------------

# Mapear especie al color y a la forma de los puntos
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species, shape = species)
) +
  geom_point(na.rm = TRUE) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Masa corporal vs. Longitud de aleta por especie",
    x = "Longitud de aleta (mm)",
    y = "Masa corporal (g)",
    color = "Especie",
    shape = "Especie"
  )

# Gráfico con facetas por isla
ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point(na.rm = TRUE) +
  facet_wrap(~island) +
  labs(
    title = "Distribución por Isla",
    x = "Longitud de aleta (mm)",
    y = "Masa corporal (g)"
  )

# ------------------------------------------------------------------------------
# 4. Distribuciones de variables (geom_bar, geom_histogram, geom_density)
# ------------------------------------------------------------------------------

# Distribución de especies (gráfico de barras)
ggplot(data = penguins, aes(x = species)) +
  geom_bar() +
  labs(title = "Cantidad de observaciones por especie", x = "Especie", y = "Conteo")

# Histograma de masa corporal
ggplot(data = penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200, fill = "steelblue", color = "white", na.rm = TRUE) +
  labs(
    title = "Distribución de masa corporal",
    x = "Masa corporal (g)",
    y = "Frecuencia"
  )

# Densidad de masa corporal por especie
ggplot(data = penguins, aes(x = body_mass_g, fill = species)) +
  geom_density(alpha = 0.5, na.rm = TRUE) +
  labs(
    title = "Densidad de masa corporal por especie",
    x = "Masa corporal (g)",
    y = "Densidad",
    fill = "Especie"
  )