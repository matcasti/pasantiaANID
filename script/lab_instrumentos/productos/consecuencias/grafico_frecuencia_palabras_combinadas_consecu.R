## función: Generar grafico de frecuencia de palabras (consecuencias)
## fecha: 26-oct

# Preparar el espacio de trabajo --------------------------------------------------------------

library(data.table)
library(tm)
library(RWeka)

# Importar los datos --------------------------------------------------------------------------

data <- readRDS(file = "data/lab_instrumentos/clean/data.RDS")

# Funciones auxiliares ------------------------------------------------------------------------

## Funciones para tokenizar grupos de dos palabras
twogramTokenizer <- function(x) {
  NGramTokenizer(
    x = x, 
    control = Weka_control(
      min = 2, 
      max = 2
    )
  )
}

## Funciones para tokenizar grupos de tres palabras
threegramTokenizer <- function(x) {
  NGramTokenizer(
    x = x, 
    control = Weka_control(
      min = 3, 
      max = 3
    )
  )
}

# Producto ------------------------------------------------------------------------------------

message("Iniciando gráfico de frecuencia de palabras combinadas - CONSECUENCIAS")

# Creamos un corpus
m <- tm::VCorpus(
  x = tm::VectorSource(
    x = unique(data$clean_consecuencia)
  )
)

## Matriz de documentos con dos términos
dtm_twogram <- DocumentTermMatrix(
  x = m, 
  ### Aplicamos función tokenizadora
  control = list(tokenize = twogramTokenizer)
)

## Creamos el conteo de palabras por dos términos
twogram_freq_consecuencias <- dtm_twogram |> 
  as.matrix() |> 
  colSums() |> 
  sort(decreasing = TRUE)

## Gráfico con top 30 combinaciones de dos palabras
pdf(file = "output/lab_instrumentos/productos/freq_palabras_combinadas_2_consecuencias.pdf", width = 10, height = 6)

## Generamos el gráfico
par(mai = c(1,2.7,1,1))
barplot(twogram_freq_consecuencias[1:30],
        xlab = 'Frencuencia',
        main = 'Top 30 combinaciones de 2 palabras',
        names.arg = names(twogram_freq_consecuencias)[1:30],
        col = 'red3', las = 2, cex.names = .7,
        horiz = TRUE, las = 1)

dev.off()

## Matriz de documentos con dos términos
dtm_twogram <- DocumentTermMatrix(
  x = m, 
  ### Aplicamos función tokenizadora
  control = list(tokenize = threegramTokenizer)
)

## Creamos el conteo de palabras por dos términos
threegram_freq_consecuencias <- dtm_twogram |> 
  as.matrix() |> 
  colSums() |> 
  sort(decreasing = TRUE)

## Gráfico con top 30 combinaciones de tres palabras
pdf(file = "output/lab_instrumentos/productos/freq_palabras_combinadas_3_consecuencias.pdf", width = 10, height = 6)

## Generamos el gráfico
par(mai = c(1,4,1,1))
barplot(threegram_freq_consecuencias[1:30],
        xlab = 'Frencuencia',
        main = 'Top 30 combinaciones de 3 palabras',
        names.arg = names(threegram_freq_consecuencias)[1:30],
        col = 'lightblue', las = 2, cex.names = .7,
        horiz = TRUE, las = 1)

dev.off()

message("✅Tarea completada")

