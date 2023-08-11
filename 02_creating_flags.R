# Creating Flags

# Load libraries ----

library(dplyr) # for manipulating data
library(readxl) # for importing the xlsx file

# Load data ----
getwd() # check you are using the correct directory. Adjust the data path if necessary

lso <- read_xlsx("Lesotho.xlsx", sheet = 1)


# Some data manipulation:
lso_changed <- lso %>% 
    
    # Exclude the first row 
    slice(-1) %>% 
    
    # Exclude columns where all are NA:
    janitor::remove_empty(which = "cols") %>% 
    
    
    # Create column for country 
    mutate(Country = "Lesotho",
           Country_Code = "LSO") 

# Creating the flags ----

lso_with_flags <- lso_changed %>% 

    mutate( AP = as.numeric(AP)) %>% # in this case, this was necessary, as they were initially as character type
    mutate( Rural = case_when(
        AP < 7 ~ "Rural",
        TRUE ~ "Urban"
    )) # %>% 
    
    # For character type, it is similar:
    # mutate( Level_Name = case_when(
    #     Level =="Level1" ~ "Primary",
    #     Level =="Level2" ~ "Secondary",
    #     Level =="Level3" ~ "Terciary",
    #     TRUE ~ "ERROR"
    # ))

lso_with_flags %>% View() # Check to see if it worked as expected 

?remove_empty # You can always check the documentation 
