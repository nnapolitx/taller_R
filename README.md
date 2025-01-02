# taller_R

Este es un taller pre-workshop para desarrollar competencias básicas de manejo de R.

1. Temario:
- Conceptos de base (directorios, data frames, variables, indexación, selección, cargar archivos)
- Hacer gráficos
- Prompt engineering aplicado a R (si hay tiempo).

2. Deben tener instalado R y RStudio.

3. Deben tener instaladas ciertas librerías.

A. Para las personas que solo tomarán el taller de R y que no se inscribieron en el taller de Machine Learning copien y peguen en la consola de R el siguiente código y lo ejecutan (le dan Enter):

```R
packages <- c("ggplot2", "reshape", "dplyr", "tidyr")

installed_packages <- installed.packages()

for(p in packages){
  if(!(p %in% installed_packages[, "Package"])){
    install.packages(p)
  }
}
```

B. Para las personas que tomarán el taller de R y que además se inscribieron en el taller de Machine Learning copien y peguen en la consola de R el siguiente código y lo ejecutan (le dan Enter):

```R
packages <- c("class", "e1071", "caret", "rpart", "rpart.plot", "nnet", 
              "stats", "cluster", "ggplot2", "MASS", "dplyr", "tidyr", 
              "readr", "plotly", "psych", "reshape")

installed_packages <- installed.packages()

for(p in packages){
  if(!(p %in% installed_packages[, "Package"])){
    install.packages(p)
  }
}
```