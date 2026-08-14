# Example 1
# Plotting the mass function for different parameter values
x_vals <- seq(0, 6, length.out = 500)
# Calculate densities
d1 <- dGLIN(x_vals, mu = 0.7, sigma = 1.4) 
d2 <- dGLIN(x_vals, mu = 0.3, sigma = 1.2)  
d3 <- dGLIN(x_vals, mu = 3.0, sigma = 1.0)  
d4 <- dGLIN(x_vals, mu = 6.0, sigma = 1.0) 
# Plot
plot(x_vals, d1, type = "l", col = "red", lwd = 2, lty = 1,
     ylim = c(0, 5), xlim = c(0, 6),
     xlab = "x", ylab = "f(x)",
     main = "Probability Density Function of the GLIN Distribution",
     las = 1)
lines(x_vals, d2, col = "black", lwd = 2, lty = 2)
lines(x_vals, d3, col = "yellow", lwd = 2, lty = 1)
lines(x_vals, d4, col = "green4", lwd = 2, lty = 1)
# Legend
legend("topright", 
       col = c("red", "black", "yellow", "green4"),
       lwd = 2,
       lty = c(1, 2, 1, 1),
       legend = c(expression(paste(sigma, " = 1.4, ", mu, " = 0.7")),
                  expression(paste(sigma, " = 1.2, ", mu, " = 0.3")),
                  expression(paste(sigma, " = 1.0, ", mu, " = 3.0")),
                  expression(paste(sigma, " = 1.0, ", mu, " = 6.0"))),
       bty = "n")

# Example 2
# Checking if the cumulative curves converge to 1
curve(pGLIN(x, mu=0.7, sigma=1.4), 
      from=0.00001, to=40,
      ylim=c(0, 1), 
      col="royalblue1", lwd=2, 
      main="Cumulative Distribution Function",
      xlab="x", ylab="F(x)")
curve(pGLIN(x, mu=0.3, sigma=1.2),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("bottomright", legend=c("mu=0.7, sigma=1.4", 
                               "mu=0.3, sigma=1.2"),
       col=c("royalblue1", "tomato", "seagreen"), lwd=2, cex=0.5)

# Example 3
# The quantile function
p <- seq(from=0, to=0.999, length.out=100)
plot(x=qGLIN(p, mu=3, sigma=1), y=p, xlab="Quantile",
     las=1, ylab="Probability", main="Quantile function ")
curve(pGLIN(x, mu=3, sigma=1), 
      from=0, add=TRUE, col="tomato", lwd=2.5)

# Example 4
# The random function
set.seed(123)
x <- rGLIN(5000, mu=0.7, sigma=1.4)
hist(x, breaks=50, freq=FALSE,
     main="rGLIN vs theory density",
     xlab="x", col="lightblue", border="white")
curve(dGLIN(x, mu=0.7, sigma=1.4),
      add=TRUE, col="red", lwd=2)

# Example 5
# The Hazard function
curve(hGLIN(x, mu=0.7, sigma=1.4), from=0.001, to=40,
      col="tomato", ylab="Hazard function", las=1)

