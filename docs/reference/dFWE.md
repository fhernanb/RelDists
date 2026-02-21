# The Flexible Weibull Extension distribution

Density, distribution function, quantile function, random generation and
hazard function for the Flexible Weibull Extension distribution with
parameters `mu` and `sigma`.

## Usage

``` r
dFWE(x, mu, sigma, log = FALSE)

pFWE(q, mu, sigma, lower.tail = TRUE, log.p = FALSE)

qFWE(p, mu, sigma, lower.tail = TRUE, log.p = FALSE)

rFWE(n, mu, sigma)

hFWE(x, mu, sigma)
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

`dFWE` gives the density, `pFWE` gives the distribution function, `qFWE`
gives the quantile function, `rFWE` generates random deviates and `hFWE`
gives the hazard function.

## Details

The Flexible Weibull extension with parameters `mu` and `sigma` has
density given by

\\f(x) = (\mu + \sigma/x^2) \exp(\mu x - \sigma/x) \exp(-\exp(\mu
x-\sigma/x))\\

for \\x\>0\\.

## See also

[FWE](http://fhernanb.github.io/RelDists/reference/FWE.md)

## Examples

``` r
old_par <- par(mfrow = c(1, 1)) # save previous graphical parameters

## The probability density function
curve(dFWE(x, mu=0.75, sigma=0.5), from=0, to=3, 
      ylim=c(0, 1.7), col="red", las=1, ylab="f(x)")


## The cumulative distribution and the Reliability function
par(mfrow=c(1, 2))
curve(pFWE(x, mu=0.75, sigma=0.5), from=0, to=3, 
      col="red", las=1, ylab="F(x)")
curve(pFWE(x, mu=0.75, sigma=0.5, lower.tail=FALSE), 
      from=0, to=3, col="red", las=1, ylab="R(x)")


## The quantile function
p <- seq(from=0, to=0.99999, length.out=100)
plot(x=qFWE(p, mu=0.75, sigma=0.5), y=p, xlab="Quantile",
     las=1, ylab="Probability")
curve(pFWE(x, mu=0.75, sigma=0.5), from=0, add=TRUE, col="red")

## The random function
hist(rFWE(n=1000, mu=2, sigma=0.5), freq=FALSE, xlab="x", 
     ylim=c(0, 2), las=1, main="")
curve(dFWE(x, mu=2, sigma=0.5), from=0, to=3, add=TRUE, col="red")


## The Hazard function
par(mfrow=c(1,1))
curve(hFWE(x, mu=0.75, sigma=0.5), from=0, to=2, ylim=c(0, 2.5), 
      col="red", ylab="Hazard function", las=1)


par(old_par) # restore previous graphical parameters
```
