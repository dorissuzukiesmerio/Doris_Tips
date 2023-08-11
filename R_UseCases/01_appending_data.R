# Colab on Data Science : Appending data on RStudio
# Date : June 15, 2023 

# Remember some keyboard shortcuts ----

# Run the code : cntrl + enter
# Save file : cntrl + s
# Pipe : cntrl + shift + m 
# Comment / uncomment line : cntrl + shift + c

# (obs: most of these only work on RStudio, not on PowerBI)


# Load libraries ----

library(dplyr)
library(tidyverse)
library(readxl)

# Load data

lso <- read_xlsx("Lesotho_Survey.xlsx", sheet = 1)

bfs <- read_xlsx("BurkinaFaso_Survey.xlsx", sheet = 1)


# Notice what happens if you just use the bind_rows
# bind_rows(lso, bfs) # uncomment this line to run
# We need to fix the column type

# Temporary quick fix ----
# (Ideally, we can assign the datatype of each column, so that we have numeric for the numbers)
# For now, I will just change all of them to character. 

lso_changed <- lso %>% 
    
    # Exclude the first row 
    slice(-1) %>% 
    
    # Changing everything to character
    # mutate(across(everything(), as.character)) %>% # This is not necessary for LSO since all are already character
    
    
    # Create column for country 
    mutate(Country = "Lesotho",
           Country_Code = "LSO") 


bfs_changed <- bfs %>% 
    
    # Changing everything to character
    mutate(across(everything(), as.character)) %>% 
    
    # Create column for country 
    mutate(Country = "Burkina Faso",
           Country_Code = "BFS")

# Hint : use %>% glimpse() to check things are working as expected


appended <- bind_rows(lso_changed, bfs_changed)

# For more details, look at the documentation:
?bind_rows

# Saving the data ----

# obs: This step is not necessary if you are doing it directly on Power Query 
# To save it as a xlsx
appended %>% 
    writexl::write_xlsx("appended_lso_bfs.xlsx")

# To save it as a csv file

appended %>% 
    write_csv("appended_lso_bfs.csv")

# To load this data again:

appended_df <- read_xlsx("appended_lso_bfs.xlsx", sheet = 1)


# If you are using Power Query : 
# Transform Data -> Transform -> R Script

# Your dataset is called "dataset"
