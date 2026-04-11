# Example 1
# Plotting the mass function for different parameter values
curve(dBS7(x, mu=0.1, sigma=10), 
      from=0.001, to=40,
      ylim=c(0, 0.20),
      col="royalblue1", lwd=2, 
      main="Density function",
      xlab="x", ylab="f(x)")
curve(dBS7(x, mu=0.5, sigma=10),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("topright", legend=c("mu=0.1, sigma=10", 
                            "mu=0.5, sigma=10"),
       col=c("royalblue1", "tomato"), lwd=2, cex=0.6)

# Example 2
# Checking if the cumulative curves converge to 1
curve(pBS7(x, mu=0.1, sigma=10), 
      from=0.00001, to=50,
      ylim=c(0, 1), 
      col="royalblue1", lwd=2, 
      main="Cumulative Distribution Function",
      xlab="x", ylab="F(x)")
curve(pBS7(x, mu=0.5, sigma=10),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("bottomright", legend=c("mu=0.1, sigma=10", 
                               "mu=0.5, sigma=10"),
       col=c("royalblue1", "tomato"), lwd=2, cex=0.5)

# Example 3
# The quantile function
p <- seq(from=0, to=0.999, length.out=100)
plot(x=qBS7(p, mu=0.1, sigma=10), y=p, xlab="Quantile",
     las=1, ylab="Probability", main="Quantile function ")
curve(pBS7(x, mu=0.1, sigma=10), 
      from=0, add=TRUE, col="tomato", lwd=2.5)

# Example 4
# The random function
x <- rBS7(n=10000, mu=0.1, sigma=10)
hist(x, freq=FALSE)
curve(dBS7(x, mu=0.1, sigma=10),  
      add=TRUE, col="tomato", lwd=2)

# Example 5
# The Hazard function
curve(hBS7(x, mu=0.1, sigma=10), from=0.001, to=60,
      col="tomato", ylab="Hazard function", las=1)

