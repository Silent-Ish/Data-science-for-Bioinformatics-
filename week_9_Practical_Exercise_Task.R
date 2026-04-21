# Step 1: Generate example data clustered around three centres 
set.seed(123)
data <- rbind(
  matrix(rnorm(50, mean = 0, sd = 0.3), ncol = 2),
  matrix(rnorm(50, mean = 3, sd = 0.3), ncol = 2),
  matrix(rnorm(50, mean = 6, sd = 0.3), ncol = 2)
)

# Step 2: Define clusters (k) and initialize centroids randomly 
k <- 3
set.seed(123)
centroids <- data[sample(1:nrow(data), k), ]

# Step 3: Function for Euclidean distance 
euclidean_dist <- function(a, b) {
  sqrt(sum((a - b)^2))
}

# Step 4: The K-means Algorithm Loop 
max_iter <- 100
for (i in 1:max_iter) {
  # Assign points to nearest centroid
  clusters <- rep(0, nrow(data))
  for (j in 1:nrow(data)) {
    distances <- apply(centroids, 1, euclidean_dist, a = data[j, ])
    clusters[j] <- which.min(distances)
  }
  
  # Update centroids based on the mean of cluster points 
  new_centroids <- matrix(0, nrow = k, ncol = ncol(data))
  for (c in 1:k) {
    points_in_cluster <- data[clusters == c, , drop = FALSE]
    if (nrow(points_in_cluster) > 0) {
      new_centroids[c, ] <- colMeans(points_in_cluster)
    } else {
      new_centroids[c, ] <- data[sample(1:nrow(data), 1), ] # Handle empty clusters 
    }
  }
  
  # Step 5: Check if centroids have stopped changing (convergence)
  if (all(centroids == new_centroids)) {
    break
  }
  centroids <- new_centroids
}

# Step 6: Plot final clusters with centroid markers 
plot(data, col = clusters, pch = 19, main = "K-means Clustering")
points(centroids, col = 1:k, pch = 4, cex = 2, lwd = 2)