
# JLUF + NN
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

library(ggplot2)
library(dplyr)

# Also you need to set a working directory
# Example: Set working directory and check path

getwd() # check your current directory
setwd("C:/Users/Usuario/Documents/R_preworkshop/taller_R") # change it
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

# Start to write something and tape Tab (R make suggestions)
# Arrows up and arrows down show "your history"
# Esc solves the majority of issues to escape

#---- 2. Basic data structures + personality----

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

# This kind of data set is more commonly imported
# The most common type of data file is a spreadsheet (an excel, xls o xlsx) file,
# This file can be converted to a .csv file
# This is the file that we will usually import
# Try this: 

personality <- read.csv("personalidad.csv")

# If the object that you created looks bizarre, consider the following
# Sometimes, .csv or .txt files can be saved using different regional settings
# By default, the read.csv() command expects a comma ',' to separate data/observations in a file 
# However, given the regional setting, a semicolon, ';' may have been used

# For this reason, we either need to specify the separator, 
# using for instance (sep = ";"),
# or we can use the command read.csv2().

# This, if the object that you created looks bizarre, try these command lines:
personality <- read.csv2("personalidad.csv")
personality <- read.csv("personalidad.csv", sep = ";")
# and just comment the ones that don't work

# Inspect dataset
colnames(personality)  # Column names
summary(personality)  # Summary statistics

str(personality)  # Structure of the dataset
class(personality$Sincerity)  # Check data type

head(personality)
tail(personality)

# Access data
personality[1, ]  # View first row
personality[, 2]  # View first column, which column name was this?
personality$Sincerity  # Access 'Sincerity' column

# Lists
my_list <- list(ID = 1, 
                Name = "John", 
                Scores = c(80, 90, 85))

# Matrices
matrix1 <- matrix(1:9, 
                  nrow = 3)

#---- 3. Exporting and importing data + data----

library(dplyr)

# We are going to create a dataset to export it and import it

# Generate dataset
set.seed(123)  # For reproducibility

data <- data.frame(
  ID = rep(sprintf("ID%02d", 1:10), each = 2),           # IDs repeated for each try
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
# Select the tab "Environment" if isn't already visible
# Then, click on the broom that appears in the "Workspace Pane" (to your right) 

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

colnames(personality)

# Filter data
df_olders <- df[df$Age >= 25,]
df_olders_2 <- subset(df, Age >= 25)

trusty <- personality[personality$Sincerity >= 3,]

df_olders2 <- df[df$IsAdult,]

# Filter with multiple conditions
cool_ones1 <- personality[personality$Anxiety > 3 & personality$Extraversion > 3,]
cool_ones2 <- subset(personality, Anxiety > 3 & Extraversion > 3)  

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

# Remove rows with missing values
personality2_clean <- na.omit(personality2)

# Replace missing values
personality3 <- personality2

personality3$Sincerity[
  is.na(personality3$Sincerity)] <- 
  mean(personality3$Sincerity , na.rm = TRUE)

#---- 6. Advanced transformations ----

# Log Transform
personality$LogOpeness <- log(personality$Openness + 1)

# Scaling
personality$ScaledOpeness <- as.numeric(scale(personality$Openness))

# Rank and group data into 3 equal-sized clusters
personality <- personality %>%
  arrange(Openness) %>%
  mutate(OpenessGroup = ntile(Openness, 3)) %>%
  mutate(OpenessGroup = factor(OpenessGroup, 
                               labels = c("Low", "Medium", "High")))

dim(personality[personality$OpenessGroup == "Low",])
dim(personality[personality$OpenessGroup == "Medium",])
dim(personality[personality$OpenessGroup == "High",])

# View the new changes at the end of the data frame
head(personality)

#---- 7. Basic statistics ----

# Calculate statistics
mean(personality$Anxiety)
median(personality$Anxiety)
sd(personality$Anxiety)
var(personality$Anxiety)

# Summary statistics
summary(personality)

# Row-wise operations
personality$SincFair <- rowSums(personality[, c("Sincerity", "Fairness")])

# Correlation
cor(personality$Anxiety, personality$Extraversion)
cor.test(personality$Anxiety, personality$Extraversion)

#---- 8. Data reshaping (reshape) ----

# From 3
head(data)

# ID        try age  RT epoch
# 1 ID01  first try  48 730  good
# 2 ID01 second try  48 272   bad
# 3 ID02  first try  32 129   bad
# 4 ID02 second try  32 330  good
# 5 ID03  first try  31 768  good
# 6 ID03 second try  31 723  good

# select data
dat2 <- data[, c(1, 2, 4)]

library(reshape)

# Long to Wide
dat2_cast <- cast(dat2, 
                  ID ~ try,
                  value = c("RT"))

# Wide to Long
dat3 <- melt(dat2_cast,
             id = c("ID"),
             measured = c("first try",
                          "second try"))

#---- 8b. Data reshaping (tidyr) ----

# From 3
head(data)

# ID        try age  RT epoch
# 1 ID01  first try  48 730  good
# 2 ID01 second try  48 272   bad
# 3 ID02  first try  32 129   bad
# 4 ID02 second try  32 330  good
# 5 ID03  first try  31 768  good
# 6 ID03 second try  31 723  good

library(tidyr)

# Pivot the data to wide format
data_cast <- pivot_wider(data, 
                         names_from = try, 
                         values_from = c(RT, epoch))

# # A tibble: 6 × 6
#    ID      age `RT_first try` `RT_second try` `epoch_first try` `epoch_second try`
# 1 ID1      48            730             272 good              bad               
# 2 ID2      32            129             330 bad               good              
# 3 ID3      31            768             723 good              good              
# 4 ID4      20            585             548 good              good              
# 5 ID5      59            796             559 good              good              
# 6 ID6      60            596             481 good              good 

# Wide to Long
data_melt <- pivot_longer(
  data_cast,
  cols = starts_with(c("RT", "epoch")),      # Columns to melt (those starting with RT or epoch)
  names_to = c(".value", "try"),             # Separate into 'RT'/'epoch' and 'try'
  names_sep = "_"                            # Split at underscore (_)
)

#   ID  try         age  RT epoch
# 1 ID1  first try  48 730  good
# 2 ID1 second try  48 272   bad
# 3 ID2  first try  32 129   bad
# 4 ID2 second try  32 330  good
# 5 ID3  first try  31 768  good
# 6 ID3 second try  31 723  good

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

# For + If
for (i in 1:length(df$Age)) {
  if (df$Age[i] > 26) {
    print("Older than 26")
  } else {
    print("26 or younger")
  }
}

# Custom Function
mean_sd <- function(x) {
  list(mean = mean(x), sd = sd(x))
}

mean_sd(personality$Extraversion)

# Custom Function
square <- function(x) {
  return(x^2)
}
print(square(4))

# Apply Family
result <- sapply(df$Age, square)

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
ggplot(personality, aes(x = OpenessGroup, y = Openness)) +
  geom_bar(stat = "identity") +
  labs(title = "Bar Plot of Openness by Group", 
       x = "Group", 
       y = "Openness")

# Bar Plot + individual points
ggplot(personality, aes(x = OpenessGroup, y = Openness)) +
  stat_summary(fun = mean, geom = "bar") +
  geom_jitter(width = 0.2, size = 2, color = "darkblue") +
  labs(title = "Bar Plot of Openness by Group", 
       x = "Group", 
       y = "Openness")

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

# Replace 0 and 1 with meaningful labels
personality <- personality %>%
  mutate(HighExtraversion = ifelse(HighExtraversion == 1, "High", "Low"))

# Ensure HighExtraversion is a factor
personality <- personality %>%
  mutate(HighExtraversion = as.factor(HighExtraversion))

# Grouped Analysis
interaction_data <- personality %>%
  group_by(OpenessGroup, HighExtraversion) %>%
  summarize(MeanAnxiety = mean(Anxiety), .groups = 'drop')

# Interaction Plot with Colors
ggplot(interaction_data, aes(x = OpenessGroup, y = MeanAnxiety, group = HighExtraversion, color = HighExtraversion)) +
  geom_line(size = 1) +
  geom_point(size = 4) +
  labs(title = "Anxiety vs Openness by Extraversion",
       x = "Openness Group", y = "Mean Anxiety",
       color = "Extraversion Level") +  # Update legend title
  theme_minimal()

