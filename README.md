# taller_R

Este es un taller pre-workshop para desarrollar competencias básicas de manejo de R.

En el curso "Machine Learning Aplicado a Investigación en Psicología" (16-17 Enero) se utilizará este lenguaje de programación.

1. Temario de este taller:
- Conceptos de base (directorios, data frames, variables, indexación, selección, cargar archivos)
- Hacer gráficos

2. Conceptos trasnversales
- Simulación de datos
- Prompt engineering aplicado a R.

3. Instrucciones para la instalación de librerías.
Copia y pega en la consola de R el siguiente código y ejecútalo:

packages <- c("class", "e1071", "caret", "rpart", "rpart.plot", "nnet", 
              "cluster", "ggplot2", "MASS", "dplyr", "tidyr", 
              "readr", "plotly", "psych", "islr2")

installed_packages <- installed.packages()

for(p in packages){
  if(!(p %in% installed_packages[, "Package"])){
    install.packages(p)
  }
}
