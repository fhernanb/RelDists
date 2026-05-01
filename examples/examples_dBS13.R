# Example 1
# Plotting the mass function for different parameter values
curve(dBS13(x, mu=5, sigma=30), 
      from=0.001, to=0.8,
      col="royalblue1", lwd=2, 
      main="Density function",
      xlab="x", ylab="f(x)")
curve(dBS13(x, mu=5, sigma=10),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("topright", legend=c("mu=5, sigma=30", 
                            "mu=5, sigma=10"),
       col=c("royalblue1", "tomato"), lwd=2, cex=0.6)

# Example 2
# Checking if the cumulative curves converge to 1
curve(pBS13(x, mu=5, sigma=30), 
      from=0.00001, to=2,
      ylim=c(0, 1), 
      col="royalblue1", lwd=2, 
      main="Cumulative Distribution Function",
      xlab="x", ylab="F(x)")
curve(pBS13(x, mu=5, sigma=10),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("bottomright", legend=c("mu=5, sigma=30", 
                               "mu=5, sigma=10"),
       col=c("royalblue1", "tomato"), lwd=2, cex=0.5)

# Example 3
# The quantile function
p <- seq(from=0, to=0.999, length.out=100)
plot(x=qBS13(p, mu=5, sigma=30), y=p, xlab="Quantile",
     las=1, ylab="Probability", main="Quantile function ")
curve(pBS13(x, mu=5, sigma=30), 
      from=0, add=TRUE, col="tomato", lwd=2.5)

# Example 4
# The random function
x <- rBS13(n=10000, mu=5, sigma=30)
hist(x, freq=FALSE)
curve(dBS13(x, mu=5, sigma=30),  
      add=TRUE, col="tomato", lwd=2)

# Example 5
# The Hazard function
curve(hBS13(x, mu=5, sigma=30), from=0.001, to=1,
      col="tomato", ylab="Hazard function", las=1)

