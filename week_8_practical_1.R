# Week 8 Practical: Titanic Dataset Cleaning
# Step 1: Import the data 
set.seed(678)
path <- 'https://raw.githubusercontent.com/guru99-edu/R-Programming/master/titanic_data.csv'
titanic <- read.csv(path)

# Step 2: Shuffle the dataset
shuffle_index <- sample(1:nrow(titanic))
titanic <- titanic[shuffle_index, ]

# Step 3: Clean the dataset 
library(dplyr)

clean_titanic <- titanic %>%
  # Drop unnecessary variables 
  select(-c(home.dest, cabin, name, x, ticket)) %>% 
  # Convert to factor levels 
  mutate(pclass = factor(pclass, levels = c(1,2,3), 
                         labels = c('Upper', 'Middle', 'Lower')), 
         survived = factor(survived, levels = c(0,1), 
                           labels = c('No', 'Yes'))) %>%
  # Remove missing observations
  na.omit()

# View the cleaned data 
glimpse(clean_titanic)
glimpse(clean_titanic) 