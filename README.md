# Data Science for Bioinformatics: Practical Exercises 

This repository contains a curated collection of machine learning and statistical modeling tasks completed during the **Data Science for Bioinformatics** module. The projects demonstrate proficiency in supervised learning, unsupervised learning, and Bayesian inference using **R** and **C++**.

---

##  Repository Overview

The repository is organized by weekly modules, each focusing on a core algorithm or statistical method applicable to biological data analysis.

###Week 9: K-means Clustering
* **Goal:** Implement a manual K-means algorithm from scratch (no standard libraries) to master partitional clustering logic.
* **Techniques:** Euclidean distance calculation, centroid initialization, and iterative convergence.
* **Key Result:** Successfully partitioned data into three distinct clusters with stable centroids.

### Week 10: K-Nearest Neighbors (KNN)
* **Goal:** Classify flower species using the classic Iris dataset.
* **Techniques:** Feature scaling, 70/30 data splitting, and hyperparameter tuning for $k$.
* **Key Result:** Achieved a peak prediction accuracy of **98.3%** at $k=15$.

### Week 11: Bayesian Inference & MCMC
* **Goal:** Estimate the probability $p$ of a binomial event using the Metropolis-Hastings algorithm.
* **Techniques:** Markov Chain Monte Carlo (MCMC), Likelihood functions, and Beta distribution priors.
* **Key Result:** Updated a flat Beta(1,1) prior to a posterior density peaking at **0.73**, matching observed data.

###Week 12: Random Forest Classification
* **Goal:** Predict passenger survival on the Titanic dataset using ensemble learning.
* **Techniques:** Data cleaning, missing value imputation, and building an ensemble of 500 decision trees.
* **Key Result:** Identified **Sex** and **Passenger Class** as the primary predictors via Variable Importance analysis.

---

##  Technical Stack

| Category | Tools & Languages |
| :--- | :--- |
| **Languages** | R, C++ |
| **Data Handling** | `dplyr`, `caTools` |
| **Machine Learning** | `class`, `randomForest` |
| **Statistics** | `e1071` |

---

##  How to Run

### R Scripts
1. Ensure the `.csv` datasets are in the working directory.
2. Open the scripts in **RStudio** and run to reproduce plots and metrics.

### C++ Implementations
1. Compile using `g++`:
   ```bash
   g++ -O3 script_name.cpp -o bio_tool
   ./bio_tool
