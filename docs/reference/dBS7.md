# The Birnbaum-Saunders distribution - Santos-Neto et al. (2012) (P5 Based on the variance)

Density, distribution function, quantile function, random generation and
hazard function for the Birnbaum-Saunders distribution with parameters
`mu` and `sigma`.

## Usage

``` r
dBS7(x, mu = 0.5, sigma = 10, log = FALSE)

pBS7(q, mu = 1, sigma = 0.5, lower.tail = TRUE, log.p = FALSE)

qBS7(p, mu = 1, sigma = 0.5, lower.tail = TRUE, log.p = FALSE)

rBS7(n, mu = 1, sigma = 0.5)

hBS7(x, mu, sigma)
```

## Arguments

- x, q:

  vector of quantiles.

- mu:

  parameter representing the shape (`mu > 0`).

- sigma:

  parameter representing the variance (`sigma > 0`).

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

`dBS7` gives the density, `pBS7` gives the distribution function, `qBS7`
gives the quantile function, `rBS7` generates random deviates and `hBS7`
gives the hazard function.

## Details

The Birnbaum-Saunders with parameters `mu` and `sigma` has density given
by

\\f(x\|\mu,\sigma) = \frac{1}{\sqrt{2\pi}} \exp\left( -\frac{1}{2\mu^2}
\left\[ \frac{\mu\sqrt{4+5\mu^2}}{2\sqrt{\sigma}x^{-1}} +
\frac{2\sqrt{\sigma}\\x\mu\\^{-1}}{\sqrt{4+5\mu^2}} - 2 \right\] \right)
\times \left\[
\frac{\\x\mu\\^{-1/2}\\4+5\mu^2\\^{1/4}}{2^{3/2}\sigma^{1/4}} +
\frac{\sigma^{1/4}}{\\x\mu\\^{3/2}\sqrt{2}\\4+5\mu^2\\^{1/4}} \right\]\\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization,
\\E(X) = \frac{\[2+\mu^2\]\sqrt{\sigma}}{\mu\sqrt{4+5\mu^2}}\\ and
\\Var(X) = \sigma\\.

## References

Santos-Neto, M., Cysneiros, F. J. A., Leiva, V., & Ahmed, S. E. (2012).
On new parameterizations of the Birnbaum-Saunders distribution. Pakistan
Journal of Statistics, 28(1), 1-26.

## See also

[BS7](http://fhernanb.github.io/RelDists/reference/BS7.md).

## Examples

``` r
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

```
