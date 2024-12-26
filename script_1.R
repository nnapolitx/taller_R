
# JLUF
# 26/12/2024
# pre-workshop R tutorial

#---- 1. Getting started with R ----

# To work with R we need to do 2 things:
# Install libraries
# Load libraries

# You have already installed many libraries
# But in case you need to know the key function is "install.packages("foreign")"

# To load libraries use the function "library"
# and put between parenthesis the library you need
# Examples:

library(ggplot2)     # for creating visualizations
library(reshape)     # for reshaping data frames
library(Rmisc)       # for summary statistics

# Also you need to set a working directory
# Example: Set working directory and check path

getwd() # check your current directory
setwd("C:/Users/Usuario/Documents/WorkshopPre_ML_Enero_2025") # change it
getwd() # check again

# Some useful shortcuts
# Ctrl+Enter to run
# Ctrl+L to clean the console
# Ctrl+C to copy
# Ctrl+P to paste

# Ctrl+shift+C to comment/uncomment massively
# Ctrl+Z to go back
# Ctrl+A to select all
# Ctrl+S to save

# Alt+O to fold all
# Alt+shift+O to unfold all

#---- 2. Basic data structures ----

# Everything in R are objects (i.e. variables)
# Objects are things you can manipulate
# There are different types of objects

# Vectors
# To create a vector use the "<-" and concatenate a series of numbers
numbers <- c(1, 2, 3, 4, 5)

# There are also vectors of characters
names <- c("John", "Jane", "Alex")

# More usually, we combine distinct kind of objects in more complex objects
# such as data frames

# Data Frames
df <- data.frame(ID = 1:3, 
                 Name = c("John", "Jane", "Alex"),
                 Age = c(25, 30, 22))

# Select df and ejecute it. You should see this:
# ID Name Age
# 1  1 John  25
# 2  2 Jane  30
# 3  3 Alex  22

# This kind is more commonly imported
# personality <- read.csv("personalidad.csv")
personality <- read.csv("personalidad.csv", sep = ";")
# personality <- read.csv2("personalidad.csv")

# Inspect dataset
colnames(personality)  # Column names
summary(personality)  # Summary statistics

str(personality)  # Structure of the dataset
class(personality$Sincerity)  # Check data type

# Access data
personality[1, ]  # View first row
personality[, 1]  # View first column
personality$Sincerity  # Access 'Sincerity' column

# Lists
my_list <- list(ID = 1, 
                Name = "John", 
                Scores = c(80, 90, 85))

# Matrices
matrix1 <- matrix(1:9, 
                  nrow = 3)

#---- 3. Exporting and importing data ----

library(dplyr)

# We are going to create a dataset to export it and import it

# Generate dataset
set.seed(123)  # For reproducibility

data <- data.frame(
  ID = rep(paste0("ID", 1:10), each = 2),                # IDs repeated for each try
  try = rep(c("first try", "second try"), 10),           # Labels for each attempt
  age = rep(sample(18:60, 10, replace = TRUE), each = 2), # Same age for each participant
  RT = round(runif(20, 100, 800), 0)                     # Random RT between 100 and 800 ms
)

# View first few rows
head(data)

# Add variable
data$epoch <- ifelse(data$RT <= 300, "bad", "good")

# Save dataset as CSV
write.csv(data, "dataset.csv", row.names = FALSE)

# Clear your WORK SPACE

# Import CSV
data_csv <- read.csv("dataset.csv")

#---- 4. Data manipulation ----

df <- data.frame(ID = 1:3, 
                 Name = c("John", "Jane", "Alex"),
                 Age = c(25, 30, 22))

# Create new columns
df$AgeSquared <- df$Age^2
personality$Anxiety_Squared <- personality$Anxiety^2

# Logical operations
personality$Anxiety > 3  # Check rows where Anxiety > 3

# Conditional columns
df$IsAdult <- ifelse(df$Age >= 25, TRUE, FALSE)
personality$IsSincere <- ifelse(
  personality$Sincerity >= 3, 
  TRUE, 
  FALSE)

# Filter data
df_olders <- df[df$Age >= 25,]
trusty <- personality[personality$Sincerity >= 3,]

df_olders2 <- df[df$IsAdult,]

# Subsetting rows
subset(personality, Anxiety > 3 & Extraversion > 3)  # Filter with multiple conditions

# Sorting data
sort(df$Age)
sorted_by_age <- df[order(df$Age),]
sorted_by_age2 <- df[order(df$Age, decreasing = TRUE),]

#---- 5. Handling missing values ----

personality2 <- personality[1:10, c("Sincerity", "Fairness")]
personality2$Sincerity[c(1,3,5)] <- NA

mean(personality2$Sincerity)
mean(personality2$Fairness)

# Detect missing values
is.na(personality2$Sincerity)

# Replace missing values
mean(personality2$Sincerity, na.rm = TRUE)

#---- 6. Advanced transformations ----

# Log Transform
personality$LogAnxiety <- log(personality$Anxiety + 1)

# Scaling
personality$ScaledAnxiety <- scale(personality$Anxiety)

# Binning
personality$AnxietyGroup <- cut(personality$Anxiety, 
                                breaks = 3, 
                                labels = c("Low", "Medium", "High"))

#---- 7. Descriptive Statistics ----

# Calculate statistics
mean_anxiety <- mean(personality$Anxiety)
sd_anxiety <- sd(personality$Anxiety)

# Summary statistics
summary(personality)

# Variance
var(personality$Anxiety)

# Standard deviation
sd(personality$Anxiety)

# Median
median(personality$Anxiety)

# Correlation
cor(personality$Anxiety, personality$Extraversion)
cor.test(personality$Anxiety, personality$Extraversion)

#---- 8. Data reshaping ----

# data <- data.frame(
#   ID = rep(paste0("ID", 1:10), each = 2),                # IDs repeated for each try
#   try = rep(c("first try", "second try"), 10),           # Labels for each attempt
#   age = rep(sample(18:60, 10, replace = TRUE), each = 2), # Same age for each participant
#   RT = round(runif(20, 100, 800), 0)                     # Random RT between 100 and 800 ms
# )
# 
# # View first few rows
# head(data)
# 
# # Add variable
# data$epoch <- ifelse(data$RT <= 300, "bad", "good")

head(data)

# Long to Wide

library(tidyr)

# Pivot the data to wide format
data_cast <- pivot_wider(data, 
                         names_from = try, 
                         values_from = c(RT, epoch))

# Melt the data back to long format
data_melt <- pivot_longer(
  data_cast,
  cols = starts_with(c("RT", "epoch")),      # Columns to melt (those starting with RT or epoch)
  names_to = c(".value", "try"),             # Separate into 'RT'/'epoch' and 'try'
  names_sep = "_"                            # Split at underscore (_)
)

#---- 9. Loops and functions ----

# For loop
for (i in 1:5) {
  print(i)
}

# For loop
for (i in 1:5) {
  print(i+i)
}

length(personality$Anxiety)
1:length(personality$Anxiety)

# For loop
for (i in 1:length(personality$Anxiety)) {
  print(personality$Anxiety[i])
}

# For loop
for (i in 1:5) {
  print(mean(personality$Anxiety[1:i]))
}

# For loop
for (i in 1:length(personality$Anxiety)) {
  print(mean(personality$Anxiety[1:i]))
}

# Custom Function
mean_sd <- function(x) {
  list(mean = mean(x), sd = sd(x))
}

mean_sd(personality$Extraversion)

#---- 10. Data visualization ----

# Histogram
ggplot(personality, aes(x = Anxiety)) +
  geom_histogram(binwidth = 0.5, 
                 fill = "blue", 
                 color = "black") +
  labs(title = "Histogram of Anxiety", 
       x = "Anxiety", 
       y = "Frequency")

# Scatterplot
ggplot(personality, aes(x = Extraversion, y = Agreeableness)) +
  geom_point() +
  labs(title = "Scatterplot: Extraversion vs Agreeableness", 
       x = "Extraversion", 
       y = "Agreeableness")

# Bar Plot
ggplot(personality, aes(x = factor(ID %% 5), y = Extraversion)) +
  geom_bar(stat = "identity") +
  labs(title = "Bar Plot of Extraversion by Group", 
       x = "Group", 
       y = "Extraversion")

#---- 11. Regression analysis ----

# Simple Linear Regression
lm1 <- lm(Extraversion ~ Anxiety, data = personality)
summary(lm1)

# Multiple Linear Regression
lm2 <- lm(Extraversion ~ Anxiety + Agreeableness + Conscientiousness, data = personality)
summary(lm2)

# Visualize regression
ggplot(personality, aes(x = Anxiety, y = Extraversion)) +
  geom_point() +
  geom_smooth(method = "lm", col = "red") +
  labs(title = "Regression: Extraversion vs Anxiety", x = "Anxiety", y = "Extraversion")

#---- 12. Logistic regression ----

# Create binary outcome (High vs Low Extraversion)
personality$HighExtraversion <- ifelse(
  personality$Extraversion > median(personality$Extraversion), 1, 0)

# Logistic Regression
logit_model <- glm(HighExtraversion ~ 
                     Anxiety + Agreeableness + Conscientiousness, 
                   data = personality, 
                   family = binomial)
summary(logit_model)

# Add predicted probabilities to the dataset
personality$predicted <- predict(logit_model, type = "response")

# Plot predicted probabilities vs Anxiety
ggplot(personality, aes(x = Anxiety, y = predicted)) +
  geom_point(alpha = 0.5) +                  # Observed data
  geom_smooth(method = "loess") +            # Smoothed curve
  labs(x = "Anxiety", y = "Predicted Probability", 
       title = "Predicted Probability of High Extraversion") +
  theme_minimal()

#---- 13. Advanced data visualization ----

library(ggrepel)     # Improved text label positioning

# Grouped Analysis and Visualization
personality_grouped <- personality %>%
  group_by(AnxietyGroup, Agreeableness) %>%
  summarize(Count = n(), .groups = 'drop') %>%
  mutate(Percent = (Count / sum(Count)) * 100)

# Bar Plot with Grouped Data
ggplot(personality_grouped, aes(x = AnxietyGroup, y = Percent, fill = Agreeableness)) +
  geom_col(position = "dodge") +
  labs(title = "Anxiety Groups vs Agreeableness Levels", x = "Anxiety Group", y = "Percentage") +
  theme(legend.position = "top")
