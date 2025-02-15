## función: Generar nube de palabras (PROBLEMA)
## fecha: 21-oct

# Preparar el espacio de trabajo --------------------------------------------------------------

library(qdap)
library(wordcloud)
library(data.table)
.s <- `[`

# Importar los datos --------------------------------------------------------------------------

data <- readRDS(file = "data/lab_instrumentos/clean/data.RDS") |> 
  # Eliminamos el término macrozona-austral por ser muy influyente en el modelado
  .s(j = clean_problema := gsub(pattern = "macrozona-austral", replacement = "", x = clean_problema));

## Importamos también stopwords
stopWords <- readLines(con = "https://raw.githubusercontent.com/Alir3z4/stop-words/master/spanish.txt")

# Producto ------------------------------------------------------------------------------------

message("Iniciando gráfico de nube de palabras - PROBLEMAS")

## Generamos los términos frecuentes
problema <- qdap::freq_terms(data$clean_problema, top = 40, stopwords = stopWords)

## Generamos nube de palabras
pdf(file = "output/lab_instrumentos/productos/nube_palabras_problema.pdf", width = 8, height = 8)
set.seed(12345)
wordcloud(words = problema$WORD, freq = problema$FREQ, 
          rot.per = 0, 
          scale = c(5,1), 
          random.order = F)
dev.off()

message("✅Tarea completada")