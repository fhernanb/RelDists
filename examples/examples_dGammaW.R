# Example 1
# Plotting the mass function for different parameter values

## The probability density function 
curve(dGammaW(x, mu=2, sigma=1.5, nu=0.5), 
      from=0, to=2, 
      col="red", lwd=2, 
      main="Density function",
      xlab="x", ylab="f(x)")
curve(dGammaW(x, mu=2.4, sigma=1.5, nu=1.3), 
      col="blue", 
      lwd=2,
      add=TRUE)
legend("topright", legend=c("mu=2.0, sigma=1.5, nu=0.5",
                            "mu=2.4, sigma=1.5, nu=1.3"),
       col=c("red", "blue"), lwd=2, cex=0.6)

# Example 2
# Checking if the cumulative curves converge to 1

curve(pGammaW(x, mu=0.5, sigma=2, nu=1), 
      from=0, to=3, 
      col="red", lwd=2, ylab="F(x)")
curve(pGammaW(x, mu=2.4, sigma=1.5, nu=1.3), 
      col="blue",
      lwd=2,
      add=TRUE)
legend("bottomright", legend=c("mu=2.0, sigma=1.5, nu=0.5",
                               "mu=2.4, sigma=1.5, nu=1.3"),
       col=c("red", "blue"), lwd=2, cex=0.6)

# Example 3
# The quantile function
p <- seq(from=0, to=0.999, length.out=100)
plot(x=qGammaW(p, mu=2.3, sigma=1.7, nu=1.2), y=p, xlab="Quantile",
     las=1, ylab="Probability", main="Quantile function ")
curve(pGammaW(x, mu=2.3, sigma=1.7, nu=1.2), 
      from=0, add=TRUE, col="tomato", lwd=2.5)

# Example 4
# The random function
x <- rGammaW(n=10000, mu=2.4, sigma=1.5, nu=1.3)
hist(x, freq=FALSE)
curve(dGammaW(x, mu=2.4, sigma=1.5, nu=1.3),
      add=TRUE, col="tomato", lwd=2)

# The Hazard function
curve(hGammaW(x, mu=2.4, sigma=1.5, nu=1.3), from=0, to=5, 
      col="red", ylab="Hazard function", las=1)
