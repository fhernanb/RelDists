# The Birnbaum-Saunders distribution - Santos-Neto et al. (2012) (P8 Based on the first Tweedie)

Density, distribution function, quantile function, random generation and
hazard function for the Birnbaum-Saunders distribution with parameters
`mu` and `sigma`.

## Usage

``` r
dBS10(x, mu = 1, sigma = 0.5, log = FALSE)

pBS10(q, mu = 1, sigma = 0.5, lower.tail = TRUE, log.p = FALSE)

qBS10(p, mu = 1, sigma = 0.5, lower.tail = TRUE, log.p = FALSE)

rBS10(n, mu = 1, sigma = 0.5)

hBS10(x, mu, sigma)
```

## Arguments

- x, q:

  vector of quantiles.

- mu:

  parameter representing \\\tau\\ (`mu > 0`).

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

`dBS10` gives the density, `pBS10` gives the distribution function,
`qBS10` gives the quantile function, `rBS10` generates random deviates
and `hBS10` gives the hazard function.

## Details

The Birnbaum-Saunders with parameters `mu` and `sigma` has density given
by

\\f(x\|\mu,\sigma) = \frac{1}{\sqrt{2\pi}} \exp\left(
-\frac{\sigma}{\mu^2} \left\[ \frac{2x}{\mu^2} + \frac{\mu^2}{2x} - 2
\right\] \right) \frac{\[2x + \mu^2\]\sqrt{\sigma}}{2\mu^2 \sqrt{x^3}}\\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization,
\\E(X) = \frac{\mu^2}{2} + \frac{\mu^4}{8\sigma}\\ and \\Var(X) =
\frac{\mu^6}{8\sigma} + \frac{5\mu^8}{64\sigma^2}\\.

## References

Santos-Neto, M., Cysneiros, F. J. A., Leiva, V., & Ahmed, S. E. (2012).
On new parameterizations of the Birnbaum-Saunders distribution. Pakistan
Journal of Statistics, 28(1), 1-26.

## See also

[BS10](http://fhernanb.github.io/RelDists/reference/BS10.md).

## Author

David Villegas Ceballos, <david.villegas1@udea.edu.co>

## Examples

``` r
# Example 1
# Plotting the mass function for different parameter values
curve(dBS10(x, mu=0.75, sigma=5), 
      from=0.001, to=1.5,
      ylim=c(0, 6.2),
      col="royalblue1", lwd=2, 
      main="Density function",
      xlab="x", ylab="f(x)")
curve(dBS10(x, mu=1.15, sigma=5),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("topright", legend=c("mu=0.75, sigma=5", 
                            "mu=1.15, sigma=5"),
       col=c("royalblue1", "tomato"), lwd=2, cex=0.6)


# Example 2
# Checking if the cumulative curves converge to 1
curve(pBS10(x, mu=0.75, sigma=5), 
      from=0.00001, to=1.5,
      ylim=c(0, 1), 
      col="royalblue1", lwd=2, 
      main="Cumulative Distribution Function",
      xlab="x", ylab="F(x)")
curve(pBS10(x, mu=1.15, sigma=5),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("bottomright", legend=c("mu=0.75, sigma=5", 
                               "mu=1.15, sigma=5"),
       col=c("royalblue1", "tomato"), lwd=2, cex=0.5)


# Example 3
# The quantile function
p <- seq(from=0, to=0.999, length.out=100)
plot(x=qBS10(p, mu=0.75, sigma=5), y=p, xlab="Quantile",
     las=1, ylab="Probability", main="Quantile function ")
curve(pBS10(x, mu=0.75, sigma=5), 
      from=0, add=TRUE, col="tomato", lwd=2.5)


# Example 4
# The random function
x <- rBS10(n=10000, mu=0.75, sigma=5)
hist(x, freq=FALSE)
curve(dBS10(x, mu=0.75, sigma=5),  
      add=TRUE, col="tomato", lwd=2)


# Example 5
# The Hazard function
curve(hBS10(x, mu=0.75, sigma=5), from=0.001, to=2,
      col="tomato", ylab="Hazard function", las=1)

```
