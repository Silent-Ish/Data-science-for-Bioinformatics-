# 1. SETUP: Load libraries and data
library(dplyr)
library(rpart)
library(rpart.plot)

set.seed(678)
path <- 'https://raw.githubusercontent.com/guru99-edu/R-Programming/master/titanic_data.csv'
titanic <- read.csv(path)

# 2. CLEANING: 
# This fixes the "factor age" error by making sure they are numbers
clean_titanic <- titanic %>%
  select(-c(home.dest, cabin, name, x, ticket)) %>%
  mutate(age = as.numeric(as.character(age)),
         fare = as.numeric(as.character(fare))) %>%
  mutate(pclass = factor(pclass, levels = c(1,2,3), 
                         labels = c('Upper', 'Middle', 'Lower')), 
         survived = factor(survived, levels = c(0,1), 
                           labels = c('No', 'Yes'))) %>%
  na.omit()

# 3. ALGORITHM: Split the data 
create_train_test <- function(data, size = 0.8, train = TRUE) {
  n_row = nrow(data)
  total_row = size * n_row
  train_sample <- 1:total_row
  if (train == TRUE) { return (data[train_sample, ]) } 
  else { return (data[-train_sample, ]) }
}

data_train <- create_train_test(clean_titanic, 0.8, train = TRUE)
data_test <- create_train_test(clean_titanic, 0.8, train = FALSE)

# 4. TRAINING: Build the model
fit <- rpart(survived ~ ., data = data_train, method = 'class')
rpart.plot(fit, extra = 106)

# 5. PREDICTION: This will now work without the error!
predict_unseen <- predict(fit, data_test, type = 'class')
table_mat <- table(data_test$survived, predict_unseen)
print(table_mat)

# 6. PERFORMANCE: Calculate accuracy 
accuracy_Test <- sum(diag(table_mat)) / sum(table_mat)
print(paste('Accuracy for test:', accuracy_Test))

# Define the tuning function
accuracy_tune <- function(fit) {
  predict_unseen <- predict(fit, data_test, type = 'class')
  table_mat <- table(data_test$survived, predict_unseen)
  accuracy_Test <- sum(diag(table_mat)) / sum(table_mat)
  return(accuracy_Test)
}

# Set specific control parameters 
control <- rpart.control(minsplit = 4,
                         minbucket = round(5/3),
                         maxdepth = 3,
                         cp = 0)

# Re-train the model with these controls 
tune_fit <- rpart(survived ~ ., data = data_train, method = 'class', control = control)

# Check the new accuracy 
print(paste('New Accuracy:', accuracy_tune(tune_fit)))