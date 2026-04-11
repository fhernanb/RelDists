# The Birnbaum-Saunders distribution - Santos-Neto et al. (2012) (Based on GLM)

Density, distribution function, quantile function, random generation and
hazard function for the Birnbaum-Saunders distribution with parameters
`mu` and `sigma`.

## Usage

``` r
dBS5(x, mu = 1, sigma = 0.5, log = FALSE)

pBS5(q, mu = 1, sigma = 0.5, lower.tail = TRUE, log.p = FALSE)

qBS5(p, mu = 1, sigma = 0.5, lower.tail = TRUE, log.p = FALSE)

rBS5(n, mu = 1, sigma = 0.5)

hBS5(x, mu, sigma)
```

## Arguments

- x, q:

  vector of quantiles.

- mu:

  parameter (`mu > 0`).

- sigma:

  precision parameter \\\delta\\ (`sigma > 0`).

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

`dBS5` gives the density, `pBS5` gives the distribution function, `qBS5`
gives the quantile function, `rBS5` generates random deviates and `hBS5`
gives the hazard function.

## Details

The Birnbaum-Saunders with parameters `mu` and `sigma` has density given
by

\\f(x\|\mu,\sigma) =
\frac{\exp(\sigma/2)\sqrt{\sigma+1}}{4\sqrt{\pi\mu}x^{3/2}} \left\[ x +
\frac{\sigma\mu}{\sigma+1} \right\] \exp\left( -\frac{\sigma}{4} \left\[
\frac{x(\sigma+1)}{\sigma\mu} + \frac{\sigma\mu}{x(\sigma+1)} \right\]
\right)\\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization
\\E(X) = \mu\\ and \\Var(X) = \mu^2 \left\[
\frac{2\sigma+5}{(\sigma+1)^2} \right\]\\.

## References

Santos-Neto, M., Cysneiros, F. J. A., Leiva, V., & Ahmed, S. E. (2012).
On new parameterizations of the Birnbaum-Saunders distribution. Pakistan
Journal of Statistics, 28(1), 1-26.

## See also

[BS5](http://fhernanb.github.io/RelDists/reference/BS5.md).

## Examples

``` r
# Example 1
# Plotting the mass function for different parameter values
curve(dBS5(x, mu=1, sigma=2), 
      from=0.001, to=2,
      ylim=c(0, 1.5), 
      col="royalblue1", lwd=2, 
      main="Density function",
      xlab="x", ylab="f(x)")
curve(dBS5(x, mu=1, sigma=25),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("topright", legend=c("mu=1, sigma=2", 
                            "mu=1, sigma=25"),
       col=c("royalblue1", "tomato"), lwd=2, cex=0.6)


# Example 2
# Checking if the cumulative curves converge to 1
curve(pBS5(x, mu=1, sigma=2), 
      from=0.00001, to=6,
      ylim=c(0, 1), 
      col="royalblue1", lwd=2, 
      main="Cumulative Distribution Function",
      xlab="x", ylab="F(x)")
curve(pBS5(x, mu=1, sigma=25),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("bottomright", legend=c("mu=1, sigma=2", 
                               "mu=1, sigma=25"),
       col=c("royalblue1", "tomato", "seagreen"), lwd=2, cex=0.5)


# Example 3
# The quantile function
p <- seq(from=0, to=0.999, length.out=100)
plot(x=qBS5(p, mu=1, sigma=2), y=p, xlab="Quantile",
     las=1, ylab="Probability", main="Quantile function ")
curve(pBS5(x, mu=1, sigma=2), 
      from=0, add=TRUE, col="tomato", lwd=2.5)


# Example 4
# The random function
x <- rBS5(n=10000, mu=1, sigma=25)
hist(x, freq=FALSE)
curve(dBS5(x, mu=1, sigma=25),  
      add=TRUE, col="tomato", lwd=2)


# Example 5
# The Hazard function
curve(hBS5(x, mu=1, sigma=25), from=0.001, to=6,
      col="tomato", ylab="Hazard function", las=1)

```
