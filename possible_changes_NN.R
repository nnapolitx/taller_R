# at line 160 in script_1 the personality data frame is being called, but its 
# object was erased from the working directory previously. If we want to add it,
# we can add with:
personality <- read.csv("personalidad.csv", sep = ";")

# At line 236 it says, "# View the new changes at the end of the data frame", but
# then it calls head() in the next line. If we want it to be the end, this should
# be tail(), or change the word end to beginning.

# At line 259, it calls the object data with head(data), but this object was also
# erased previously. If we want to add it, can add with
data <- read.csv("dataset.csv")

# The openness bar plot at line 404 appears to have more observations than appears
# in the personality data frame, but I might be wrong.