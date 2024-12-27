# List of packages to install
packages <- c("class", "e1071", "caret", "rpart", "nnet", "stats", 
              "cluster", "ggplot2", "MASS", "dplyr", "tidyr", 
              "readr", "plotly", "psych, ISLR2")

# Install packages if not already installed
installed_packages <- installed.packages()[, "Package"]
packages_to_install <- setdiff(packages, installed_packages)

if (length(packages_to_install) > 0) {
  install.packages(packages_to_install, dependencies = TRUE)
}
# 
