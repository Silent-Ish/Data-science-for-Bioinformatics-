# Set the number of tosses.
n <- 100
# Set the number of heads obtained.
h <- 73
# Define our likelihood function.
# Since our model is a binomial model, we can use:
likelihood <- function(h,n,p){
  lh <- dbinom(h,n,p)
  lh
}
# Set the starting value of p
p <- runif(1,0,1)
# Create an empty data.frame to store the accepted p values for each iteration.
# Remember: "the posterior probability is just an updated version of the prior"
posterior <- data.frame()
# Set the lenght of the loop (Marcov Chain, number of iterations).
nrep <- 5000
# Start the loop (MCMC)
for (i in 1:nrep) {
  # Obtain a new proposal value for p
  p_prime <- p + runif(1, -0.05,0.05)
  # Avoid values out of the range 0 - 1
  if (p_prime < 0) {p_prime <- abs(p_prime)}
  if (p_prime > 1) {p_prime <- 2 - p_prime}
  # Compute the acceptance proability using our likelihood function and the
  # beta(1,1) distribution as our prior probability.
  R <- likelihood(h,n,p_prime)/likelihood(h,n,p) * (dbeta(p_prime,1,1)/dbeta(p,1,1))
  # Accept or reject the new value of p
  if (R > 1) {R <- 1}
  random <- runif (1,0,1)
  if (random < R) {
    p <- p_prime
  }
  # Store the likelihood of the accepted p and its value
  posterior[i,1] <- log(likelihood(h, n, p))
  posterior[i,2] <- p
  print(i)
}
par(mfrow= c(1,2))
prior <- rbeta(5000, 1,1)
plot(1:5000 ,posterior$V2, cex=0, xlab = "generations", ylab = "p", main = "trace of MCMC\n accepted values of parameter p\n prior = beta(1,1)
generations = 5000")
lines(1:5000, posterior$V2, cex=0)
abline(h=mean(posterior$V2), col="red")
plot(density(posterior$V2), xlim = c(min(min(prior),min((posterior$V2))), max(max(prior),max((posterior$V2)))), ylim = c(0, max(max(density
                                                                                                                                    (prior)$y),max((density(posterior$V2)$y)))), main= "prior VS posterior\n prior= beta(1,1)", lwd=3, col="red")
lines(density(prior), lwd=3, lty=2, col="blue")
legend("topleft", legend=c("prior density","posterior density"),
       col=c("blue","red"), lty=c(3,1), lwd=c(3,3), cex = 1)