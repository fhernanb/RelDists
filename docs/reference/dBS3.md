# The Birnbaum-Saunders distribution - Bourguignon & Gallardo (2022)

Density, distribution function, quantile function, random generation and
hazard function for the Birnbaum-Saunders distribution with parameters
`mu` and `sigma`.

## Usage

``` r
dBS3(x, mu = 1, sigma = 0.5, log = FALSE)

pBS3(q, mu = 1, sigma = 0.5, lower.tail = TRUE, log.p = FALSE)

qBS3(p, mu = 1, sigma = 0.5, lower.tail = TRUE, log.p = FALSE)

rBS3(n, mu = 1, sigma = 0.5)

hBS3(x, mu, sigma)
```

## Arguments

- x, q:

  vector of quantiles.

- mu:

  parameter.

- sigma:

  parameter.

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

`dBS3` gives the density, `pBS3` gives the distribution function, `qBS3`
gives the quantile function, `rBS3` generates random deviates and `hBS3`
gives the hazard function.

## Details

The Birnbaum-Saunders with parameters `mu` and `sigma` has density given
by

\\f(x) = \frac{\exp(\sigma/2)\sqrt{\sigma+1}}{4\sqrt{\pi\mu}x^{3/2}}
\left\[ x + \frac{\mu\sigma}{\sigma+1} \right\] \exp\left(
\frac{-\sigma}{4}
\left(\frac{x(\sigma+1)}{\mu\sigma}+\frac{\mu\sigma}{x(\sigma+1)}
\right) \right) \\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization
\\E(X)=\mu\\ and \\Var(X)=(\mu\sigma)^2(1+5\sigma^2/4)\\. The functions
proposed here corresponds to the parameterization proposed by
Santos-Neto et al. (2014).

## References

Bourguignon, M., & Gallardo, D. I. (2022). A new look at the
Birnbaum–Saunders regression model. Applied Stochastic Models in
Business and Industry, 38(6), 935-951.

## See also

[BS3](http://fhernanb.github.io/RelDists/reference/BS3.md).

## Examples

``` r
# Example 1
# Plotting the mass function for different parameter values
curve(dBS3(x, mu=2, sigma=0.2), 
      from=0.001, to=10,
      ylim=c(0, 0.4), 
      col="royalblue1", lwd=2, 
      main="Density function",
      xlab="x", ylab="f(x)")
curve(dBS3(x, mu=2, sigma=0.4),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("topright", legend=c("mu=2, sigma=0.2", 
                            "mu=2, sigma=0.4"),
       col=c("royalblue1", "tomato"), lwd=2, cex=0.6)


# Example 2
# Checking if the cumulative curves converge to 1
curve(pBS3(x, mu=2, sigma=0.2), 
      from=0.00001, to=10,
      ylim=c(0, 1), 
      col="royalblue1", lwd=2, 
      main="Cumulative Distribution Function",
      xlab="x", ylab="F(x)")
curve(pBS3(x, mu=2, sigma=0.4),
      col="tomato", 
      lwd=2,
      add=TRUE)
legend("bottomright", legend=c("mu=2, sigma=0.2", 
                               "mu=2, sigma=0.4"),
       col=c("royalblue1", "tomato", "seagreen"), lwd=2, cex=0.5)


# Example 3
# The quantile function
p <- seq(from=0, to=0.999, length.out=100)
plot(x=qBS3(p, mu=2, sigma=0.2), y=p, xlab="Quantile",
     las=1, ylab="Probability", main="Quantile function ")
curve(pBS3(x, mu=2, sigma=0.2), 
      from=0, add=TRUE, col="tomato", lwd=2.5)


# Example 4
# The random function
x <- rBS3(n=10000, mu=2, sigma=0.2)
hist(x, freq=FALSE)
curve(dBS3(x, mu=2, sigma=0.2), from=0, to=10, 
      add=TRUE, col="tomato", lwd=2)


# Example 5
# The Hazard function
curve(hBS3(x, mu=2, sigma=0.2), from=0.001, to=4,
      col="tomato", ylab="Hazard function", las=1)

```
