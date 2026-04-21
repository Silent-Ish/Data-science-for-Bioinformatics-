# Step 1: Load the libraries you just installed 
library(caTools) 
library(e1071)
library(class)

# Step 2: Now run the rest of your code 
data(iris)
split <- sample.split(iris, SplitRatio = 0.7)
train_cl <- subset(iris, split == "TRUE")
test_cl <- subset(iris, split == "FALSE")

# Load data and split
data(iris)
split <- sample.split(iris, SplitRatio = 0.7)
train_cl <- subset(iris, split == "TRUE")
test_cl <- subset(iris, split == "FALSE")

# Normalize measurements 
train_scale <- scale(train_cl[, 1:4])
test_scale <- scale(test_cl[, 1:4])

# Step 1: Fit the KNN model with k = 1 
classifier_knn <- knn(train = train_scale,
                      test = test_scale,
                      cl = train_cl$Species,
                      k = 1)

# Step 2: Create the Confusion Matrix to see errors
cm <- table(test_cl$Species, classifier_knn)
print(cm)

# Step 3: Check Accuracy 
misClassError <- mean(classifier_knn != test_cl$Species)
print(paste('Accuracy for k=1:', 1 - misClassError)) 

# --- Step 4: Testing different K values ---

# Testing K = 3 
classifier_knn_3 <- knn(train = train_scale, test = test_scale, cl = train_cl$Species, k = 3)
acc_3 <- 1 - mean(classifier_knn_3 != test_cl$Species)
print(paste('Accuracy for k=3:', acc_3))

# Testing K = 15 
classifier_knn_15 <- knn(train = train_scale, test = test_scale, cl = train_cl$Species, k = 15)
acc_15 <- 1 - mean(classifier_knn_15 != test_cl$Species)
print(paste('Accuracy for k=15:', acc_15))

k_values <- c(1, 3, 5, 7, 15, 19)
accuracy <- c(0.9167, 0.8833, 0.8833, 0.90, 0.9333, 0.9167)
#Accuracy vs k as a bar plot
barplot(accuracy,
        names.arg = k_values,
        xlab = "k value",
        ylab = "Accuracy",
        main = "KNN Accuracy Across k",
        col = "lightblue")
## Line plot with labels on each point
plot(k_values, accuracy,
     type = "b",
     xlab = "k value",
     ylab = "Accuracy",
     main = "Accuracy vs k in KNN",
     pch = 19)
text(k_values, accuracy,
     labels = round(accuracy, 3),
     pos = 3)