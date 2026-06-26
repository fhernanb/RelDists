# The Birnbaum-Saunders distribution - Santos-Neto et al. (2012) (P6 Based on the variance 2)

Density, distribution function, quantile function, random generation and
hazard function for the Birnbaum-Saunders distribution with parameters
`mu` and `sigma`.

## Usage

``` r
dBS8(x, mu = 0.5, sigma = 10, log = FALSE)

pBS8(q, mu = 1, sigma = 0.5, lower.tail = TRUE, log.p = FALSE)

qBS8(p, mu = 1, sigma = 0.5, lower.tail = TRUE, log.p = FALSE)

rBS8(n, mu = 1, sigma = 0.5)

hBS8(x, mu, sigma)
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

`dBS8` gives the density, `pBS8` gives the distribution function, `qBS8`
gives the quantile function, `rBS8` generates random deviates and `hBS8`
gives the hazard function.

## Details

The Birnbaum-Saunders with parameters `mu` and `sigma` has density given
by

\\f(x\|\mu,\sigma) = \frac{\sqrt{\mu}} {2\sqrt{2\pi\sigma}} \left\[
\left\\ \frac{1}{2x} \sqrt{\frac{5\sigma}{\mu(\mu-1)}} \right\\^{1/2} +
\left\\ \frac{1}{2x} \sqrt{\frac{5\sigma}{\mu(\mu-1)}} \right\\^{3/2}
\right\] \exp\left( -\frac{5}{8(\mu-1)} \left\[
\frac{2x\sqrt{\mu(\mu-1)}}{\sqrt{5\sigma}} + \frac{\sqrt{5\sigma}}
{2+\sqrt{\mu(\mu-1)}} -2 \right\] \right) \\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization,
\\E(X) = \frac{\[2\mu+3\]\sqrt{\sigma}}{\sqrt{20\mu(\mu-1)}}\\ and
\\Var(X) = \sigma\\.

## References

Santos-Neto, M., Cysneiros, F. J. A., Leiva, V., & Ahmed, S. E. (2012).
On new parameterizations of the Birnbaum-Saunders distribution. Pakistan
Journal of Statistics, 28(1), 1-26.

## See also

[BS8](http://fhernanb.github.io/RelDists/reference/BS8.md).

## Author

David Villegas Ceballos, <david.villegas1@udea.edu.co>

## Examples

``` r
# Example 1
# Plotting the mass function for different parameter values
curve(dBS8(x, mu=1.05, sigma=10), 
      from=0.001, to=25,
      ylim=c(0, 0.25),
      col="royalblue1", lwd=2, 
      main="Density function",
      xlab="x", ylab="f(x)")
curve(dBS8(x, mu=1.5, sigma=10),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("topright", legend=c("mu=1.05, sigma=10", 
                            "mu=1.5, sigma=10"),
       col=c("royalblue1", "tomato"), lwd=2, cex=0.6)


# Example 2
# Checking if the cumulative curves converge to 1
curve(pBS8(x, mu=1.5, sigma=10), 
      from=0.00001, to=30,
      ylim=c(0, 1), 
      col="royalblue1", lwd=2, 
      main="Cumulative Distribution Function",
      xlab="x", ylab="F(x)")
curve(pBS8(x, mu=2.5, sigma=10),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("bottomright", legend=c("mu=1.5, sigma=10", 
                               "mu=2.5, sigma=10"),
       col=c("royalblue1", "tomato"), lwd=2, cex=0.5)


# Example 3
# The quantile function
p <- seq(from=0, to=0.999, length.out=100)
plot(x=qBS8(p, mu=1.5, sigma=10), y=p, xlab="Quantile",
     las=1, ylab="Probability", main="Quantile function ")
curve(pBS8(x, mu=1.5, sigma=10), 
      from=0, add=TRUE, col="tomato", lwd=2.5)


# Example 4
# The random function
x <- rBS8(n=10000, mu=1.5, sigma=10)
hist(x, freq=FALSE)
curve(dBS8(x, mu=1.5, sigma=10),  
      add=TRUE, col="tomato", lwd=2)


# Example 5
# The Hazard function
curve(hBS8(x, mu=1.5, sigma=10), from=0.001, to=60,
      col="tomato", ylab="Hazard function", las=1)

```
