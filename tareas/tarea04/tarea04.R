library(tidyverse)
library(nycflights13)
library(slider)

# ==============================================================================
# Ejercicio 1: Las 48 horas continuas con peores retrasos y cruce con clima
# ==============================================================================
worst_48_hours <- flights |> 
  group_by(year, month, day, hour) |> 
  summarize(
    mean_dep_delay = mean(dep_delay, na.rm = TRUE),
    n_flights = n(),
    .groups = "drop"
  ) |> 
  arrange(year, month, day, hour) |> 
  mutate(rolling_delay_48h = slide_dbl(mean_dep_delay, mean, .before = 47, .complete = TRUE)) |> 
  arrange(desc(rolling_delay_48h)) |> 
  slice_head(n = 1)

worst_48_hours

# Cruzamos con weather para analizar las condiciones climáticas del período
worst_weather <- flights |> 
  semi_join(worst_48_hours, by = join_by(year, month, day)) |> 
  inner_join(weather, by = join_by(origin, year, month, day, hour))

worst_weather


# ==============================================================================
# Ejercicio 2: Encontrar todos los vuelos hacia los 10 destinos más populares
# ==============================================================================
top_dest <- flights |> 
  count(dest, sort = TRUE) |> 
  head(10)

flights_to_top_dest <- flights |> 
  semi_join(top_dest, by = join_by(dest))

flights_to_top_dest


# ==============================================================================
# Ejercicio 3: ¿Cada vuelo de salida tiene registro meteorológico coincidente?
# ==============================================================================
flights_without_weather <- flights |> 
  anti_join(weather, by = join_by(origin, year, month, day, hour))

# Observaciones de vuelos sin datos meteorológicos exactos
nrow(flights_without_weather)


# ==============================================================================
# Ejercicio 4: ¿Qué tienen en común los tailnum que no figuran en planes?
# ==============================================================================
flights |> 
  anti_join(planes, by = join_by(tailnum)) |> 
  count(carrier, sort = TRUE) |> 
  mutate(prop = n / sum(n))
# La gran mayoría (~90%) pertenecen a American Airlines (AA) y Envoy Air (MQ)


# ==============================================================================
# Ejercicio 5: ¿Cada avión vuela para una sola aerolínea?
# ==============================================================================
planes_carriers <- flights |> 
  filter(!is.na(tailnum)) |> 
  distinct(tailnum, carrier) |> 
  count(tailnum) |> 
  filter(n > 1)

planes_carriers
# Se rechaza la hipótesis estricta: existen aviones que fueron operados por más de una aerolínea


# ==============================================================================
# Ejercicio 6: Agregar latitud y longitud de origen y destino a flights
# ==============================================================================
airports_coords <- airports |> 
  select(faa, lat, lon)

flights_with_coords <- flights |> 
  left_join(airports_coords, by = join_by(origin == faa)) |> 
  rename(lat_origin = lat, lon_origin = lon) |> 
  left_join(airports_coords, by = join_by(dest == faa)) |> 
  rename(lat_dest = lat, lon_dest = lon)

flights_with_coords |> 
  select(year:day, origin, lat_origin, lon_origin, dest, lat_dest, lon_dest)


# Mapa Ejercicio 7
avg_dest_delays <- flights |> 
  group_by(dest) |> 
  summarize(avg_arr_delay = mean(arr_delay, na.rm = TRUE)) |> 
  inner_join(airports, by = join_by(dest == faa))

ggplot(avg_dest_delays, aes(x = lon, y = lat, color = avg_arr_delay, size = avg_arr_delay)) +
  borders("state") +
  geom_point() +
  scale_color_viridis_c() +
  coord_quickmap() +
  labs(
    title = "Retraso promedio de llegada por destino (2013)",
    x = "Longitud",
    y = "Latitud",
    color = "Retraso (min)",
    size = "Retraso (min)"
  )

# ==============================================================================
# Ejercicio 8: ¿Qué ocurrió el 13 de junio de 2013?
# ==============================================================================
june13_delays <- flights |> 
  filter(year == 2013, month == 6, day == 13) |> 
  group_by(dest) |> 
  summarize(avg_arr_delay = mean(arr_delay, na.rm = TRUE)) |> 
  inner_join(airports, by = join_by(dest == faa))

ggplot(june13_delays, aes(x = lon, y = lat, size = avg_arr_delay, color = avg_arr_delay)) +
  borders("state") +
  geom_point() +
  scale_color_gradient(low = "gold", high = "red") +
  coord_quickmap() +
  labs(
    title = "Retrasos de vuelos el 13 de junio de 2013",
    subtitle = "Fuerte serie de tormentas / complejo convectivo (derecho) en el este de EE.UU.",
    x = "Longitud",
    y = "Latitud",
    color = "Retraso (min)",
    size = "Retraso (min)"
  )