# --- STEP 1: INITIAL SETUP & DATA IMPORT ---
library(dplyr)
library(rpart)
library(rpart.plot)

set.seed(678) # For reproducibility 
path <- "https://raw.githubusercontent.com/guru99-edu/R-Programming/master/titanic_data.csv"
titanic <- read.csv(path) 

# --- STEP 2: SHUFFLE & CLEAN DATA ---
# Shuffle to randomize observations 
shuffle_index <- sample(1:nrow(titanic))
titanic <- titanic[shuffle_index, ]

clean_titanic <- titanic %>%
  # Drop unnecessary variables
  select(-c(home.dest, cabin, name, x, ticket)) %>%
  # Convert "?" to NA and force numeric types 
  mutate(age = as.numeric(ifelse(age == "?", NA, age)),
         fare = as.numeric(ifelse(fare == "?", NA, fare))) %>%
  # Convert to factors [cite: 1499-1505]
  mutate(pclass = factor(pclass, levels = c(1,2,3), labels = c("Upper", "Middle", "Lower")),
         survived = factor(survived, levels = c(0,1), labels = c("No", "Yes")),
         sex = factor(sex),
         embarked = factor(embarked)) %>%
  # Remove missing observations 
  na.omit()

# --- STEP 3: CREATE TRAIN/TEST SETS ---
set.seed(123) # New seed for the split
# Use 80% for training [cite: 1511]
train_index <- sample(1:nrow(clean_titanic), 0.8 * nrow(clean_titanic))
train <- clean_titanic[train_index, ] 
test <- clean_titanic[-train_index, ] 

# --- STEP 4: BUILD & VISUALIZE MODEL ---
# Train decision tree 
tree_model_simple <- rpart(survived ~ ., data = train, method = "class", 
                           control = rpart.control(maxdepth = 3)) # [cite: 1520]

# Draw the tree 
rpart.plot(tree_model_simple, type = 2, extra = 104, fallen.leaves = TRUE)

# --- STEP 5: PREDICT & EVALUATE ---
# Make predictions on test set 
pred_class <- predict(tree_model_simple, newdata = test, type = "class")

# Confusion Matrix 
conf_mat <- table(Actual = test$survived, Predicted = pred_class)
print(conf_mat) # [cite: 1544]

# Calculate Overall Accuracy 
accuracy <- sum(diag(conf_mat)) / sum(conf_mat)
print(paste("Final Accuracy:", accuracy))