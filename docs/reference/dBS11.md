# The Birnbaum-Saunders distribution - Santos-Neto et al. (2012) (P9 Based on the second Tweedie)

Density, distribution function, quantile function, random generation and
hazard function for the Birnbaum-Saunders distribution with parameters
`mu` and `sigma`.

## Usage

``` r
dBS11(x, mu = 1, sigma = 0.5, log = FALSE)

pBS11(q, mu = 1, sigma = 0.5, lower.tail = TRUE, log.p = FALSE)

qBS11(p, mu = 1, sigma = 0.5, lower.tail = TRUE, log.p = FALSE)

rBS11(n, mu = 1, sigma = 0.5)

hBS11(x, mu, sigma)
```

## Arguments

- x, q:

  vector of quantiles.

- mu:

  parameter representing \\\beta\\ (`mu > 0`).

- sigma:

  parameter representing \\\omega\\ (`sigma > 0`).

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

`dBS11` gives the density, `pBS11` gives the distribution function,
`qBS11` gives the quantile function, `rBS11` generates random deviates
and `hBS11` gives the hazard function.

## Details

The Birnbaum-Saunders with parameters `mu` and `sigma` has density given
by

\\f(x\|\mu,\sigma) = \frac{1}{\sqrt{2\pi}} \exp\left(
-\frac{\sigma}{2\mu} \left\[ \frac{x}{\mu} + \frac{\mu}{x} - 2 \right\]
\right) \frac{\[x + \mu\]\sqrt{\sigma}}{2\mu\sqrt{x^3}}\\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization,
\\E(X) = \mu + \frac{\mu^2}{2\sigma}\\ and \\Var(X) =
\frac{\mu^3}{\sigma} + \frac{5\mu^4}{4\sigma^2}\\.

## References

Santos-Neto, M., Cysneiros, F. J. A., Leiva, V., & Ahmed, S. E. (2012).
On new parameterizations of the Birnbaum-Saunders distribution. Pakistan
Journal of Statistics, 28(1), 1-26.

## See also

[BS11](http://fhernanb.github.io/RelDists/reference/BS11.md).

## Author

David Villegas Ceballos, <david.villegas1@udea.edu.co>

## Examples

``` r
# Example 1
# Plotting the mass function for different parameter values
curve(dBS11(x, mu=1, sigma=12), 
      from=0.001, to=2.5,
      col="royalblue1", lwd=2, 
      main="Density function",
      xlab="x", ylab="f(x)")
curve(dBS11(x, mu=1, sigma=0.5),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("topright", legend=c("mu=1, sigma=12", 
                            "mu=1, sigma=0.5"),
       col=c("royalblue1", "tomato"), lwd=2, cex=0.6)


# Example 2
# Checking if the cumulative curves converge to 1
curve(pBS11(x, mu=1, sigma=12), 
      from=0.00001, to=8,
      ylim=c(0, 1), 
      col="royalblue1", lwd=2, 
      main="Cumulative Distribution Function",
      xlab="x", ylab="F(x)")
curve(pBS11(x, mu=1, sigma=0.5),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("bottomright", legend=c("mu=1, sigma=12", 
                               "mu=1, sigma=0.5"),
       col=c("royalblue1", "tomato"), lwd=2, cex=0.5)


# Example 3
# The quantile function
p <- seq(from=0, to=0.999, length.out=100)
plot(x=qBS11(p, mu=1, sigma=12), y=p, xlab="Quantile",
     las=1, ylab="Probability", main="Quantile function ")
curve(pBS11(x, mu=1, sigma=12), 
      from=0, add=TRUE, col="tomato", lwd=2.5)


# Example 4
# The random function
x <- rBS11(n=10000, mu=1, sigma=12)
hist(x, freq=FALSE)
curve(dBS11(x, mu=1, sigma=12),  
      add=TRUE, col="tomato", lwd=2)


# Example 5
# The Hazard function
curve(hBS11(x, mu=1, sigma=12), from=0.001, to=4,
      col="tomato", ylab="Hazard function", las=1)

```
