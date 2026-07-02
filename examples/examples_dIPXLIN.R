# Example 1
# Plotting the mass function for different parameter values
curve(dIPXLIN(x, mu=0.5, sigma=1.5), 
      from=0.001, to=2.5,
      col="royalblue1", lwd=2, 
      main="Density function",
      xlab="x", ylab="f(x)")
curve(dIPXLIN(x, mu=1.5, sigma=3.5),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("topright", legend=c("mu=0.5, sigma=1.5", 
                            "mu=1.5, sigma=3.5"),
       col=c("royalblue1", "tomato"), lwd=2, cex=0.6)


# Example 2
# Checking if the cumulative curves converge to 1
curve(pIPXLIN(x, mu=0.5, sigma=1.5), 
      from=0.00001, to=4,
      ylim=c(0, 1), 
      col="royalblue1", lwd=2, 
      main="Cumulative Distribution Function",
      xlab="x", ylab="F(x)")
curve(pIPXLIN(x, mu=1.5, sigma=4.0),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("bottomright", legend=c("mu=0.5, sigma=1.5", 
                               "mu=1.5, sigma=4.0"),
       col=c("royalblue1", "tomato"), lwd=2, cex=0.5)


# Example 3 
p <- seq(from=0, to=0.99, length.out=100)
plot(x=qIPXLIN(p, mu=0.5, sigma=1.5), y=p, xlab="Quantile",
     las=1, ylab="Probability", main="Quantile function ")
curve(pIPXLIN(x, mu=0.5, sigma=1.5), 
      from=0, add=TRUE, col="tomato", lwd=2.5)


# Example 4
# The random function
x <- rIPXLIN(n=1000, mu=0.5, sigma=3.5)
hist(x, freq=FALSE, breaks=50, xlim=c(0,4))
curve(dIPXLIN(x, mu=0.5, sigma=3.5),  
      add=TRUE, col="tomato", lwd=2)


# Example 5
# The Hazard function
curve(hIPXLIN(x, mu=0.5, sigma=1.5), from=0.001, to=4,
      col="tomato", ylab="Hazard function", las=1)
