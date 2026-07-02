# The Inverse Power XLindley distribution - Hassan et al. (2025)

Density, distribution function, quantile function, random generation and
hazard function for the Inverse Power XLindley distribution with
parameters `mu` and `sigma`.

## Usage

``` r
dIPXLIN(x, mu = 1, sigma = 1, log = FALSE)

pIPXLIN(q, mu = 1, sigma = 1, lower.tail = TRUE, log.p = FALSE)

qIPXLIN(p, mu = 1, sigma = 1, lower.tail = TRUE, log.p = FALSE)

rIPXLIN(n, mu = 1, sigma = 1)

hIPXLIN(x, mu = 1, sigma = 1)
```

## Arguments

- x, q:

  vector of quantiles.

- mu:

  parameter representing \\\eta\\ (`mu > 0`).

- sigma:

  parameter representing \\\sigma\\ (`sigma > 0`).

- log, log.p:

  logical; if TRUE, probabilities p are given as log(p).

- lower.tail:

  logical; if TRUE (default), probabilities are P\[X \<= x\], otherwise,
  P\[X \> x\].

- p:

  vector of probabilities.

- n:

  number of observations.

## Value

`dIPXLIN` gives the density, `pIPXLIN` gives the distribution function,
`qIPXLIN` gives the quantile function, `rIPXLIN` generates random
deviates and `hIPXLIN` gives the hazard function.

## Details

The Inverse Power XLindley with parameters `mu` and `sigma` has density
given by

\\f(x\|\mu,\sigma) = \frac{\sigma \mu^2}{(1+\mu)^2} x^{-2\sigma-1}
\left(1 + (2+\mu) x^\sigma\right) e^{-\mu x^{-\sigma}}\\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization,
\\\mu\\ is the scale parameter and \\\sigma\\ is the shape parameter.

## References

Hassan, A. S., Alsadat, N., Chesneau, C., Elgarhy, M., Kayid, M.,
Nasiru, S., & Gemeay, A. M. (2025). Inverse power XLindley distribution
with statistical inference and applications to engineering data.
Scientific Reports, 15, 4385.

## See also

[IPXLIN](http://fhernanb.github.io/RelDists/reference/IPXLIN.md).

## Author

Sebastián Ándres Rios Romero, <srios.romero@udea.edu.co>

## Examples

``` r
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
```
