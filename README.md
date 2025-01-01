# taller_R

Este es un taller pre-workshop para desarrollar competencias básicas de manejo de R.

En el curso "Machine Learning Aplicado a Investigación en Psicología" (16-17 Enero) se utilizará este lenguaje de programación.

1. Temario de este taller:
- Conceptos de base (directorios, data frames, variables, indexación, selección, cargar archivos)
- Hacer gráficos

2. Conceptos transversales
- Simulación de datos
- Prompt engineering aplicado a R.

3. Instrucciones para la instalación de librerías.

A. Para las personas que solo tomarán el taller de R y que no se inscribieron en el taller de machine learning copien y peguen en la consola de R el siguiente código (son 7 líneas de código) y lo ejecutan (le dan Enter):

```R
packages <- c("ggplot2", "reshape", "dplyr", "tidyr")
installed_packages <- installed.packages()
for(p in packages){
  if(!(p %in% installed_packages[, "Package"])){
    install.packages(p)
  }
}
```R

B. Para las personas que tomarán el taller de R y que además se inscribieron en el taller de machine learning copien y peguen en la consola de R el siguiente código (son 9 líneas de código) y lo ejecutan (le dan Enter):

```R
packages <- c("class", "e1071", "caret", "rpart", "rpart.plot", "nnet", 
              "cluster", "ggplot2", "MASS", "dplyr", "tidyr", 
              "readr", "plotly", "psych", "ISLR2", "reshape")
installed_packages <- installed.packages()
for(p in packages){
  if(!(p %in% installed_packages[, "Package"])){
    install.packages(p)
  }
}
```R
