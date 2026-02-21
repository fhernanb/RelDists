# The Quasi XGamma Poisson distribution

Density, distribution function,quantile function, random generation and
hazard function for the Quasi XGamma Poisson distribution with
parameters `mu`, `sigma` and `nu`.

## Usage

``` r
dQXGP(x, mu, sigma, nu, log = FALSE)

pQXGP(q, mu, sigma, nu, lower.tail = TRUE, log.p = FALSE)

qQXGP(p, mu, sigma, nu, lower.tail = TRUE, log.p = FALSE)

rQXGP(n, mu, sigma, nu)

hQXGP(x, mu, sigma, nu)
```

## Arguments

- x, q:

  vector of quantiles.

- mu:

  parameter.

- sigma:

  parameter.

- nu:

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

`dQXGP` gives the density, `pQXGP` gives the distribution function,
`qQXGP` gives the quantile function, `rQXGP` generates random deviates
and `hQXGP` gives the hazard function.

## Details

The Quasi XGamma Poisson distribution with parameters `mu`, `sigma` and
`nu` has density given by:

\\f(x)= K(\mu, \sigma, \nu)(\frac {\sigma^{2} x^{2}}{2} + \mu)
exp(\frac{\nu exp(-\sigma x)(1 + \mu + \sigma x + \frac
{\sigma^{2}x^{2}}{2})}{1+\mu} - \sigma x),\\

for \\x \> 0\\, \\\mu\> 0\\, \\\sigma\> 0\\, \\\nu\> 1\\.

where

\\K(\mu, \sigma, \nu) = \frac{\nu \sigma}{(exp(\nu)-1)(1+\mu)}\\

## References

Sen, S., Korkmaz, M. Ç., & Yousof, H. M. (2018). The quasi
XGamma-Poisson distribution: properties and application. Istatistik
Journal of The Turkish Statistical Association, 11(3), 65-76.

## See also

[QXGP](http://fhernanb.github.io/RelDists/reference/QXGP.md)

## Author

Simon Zapata

## Examples

``` r
old_par <- par(mfrow = c(1, 1)) # save previous graphical parameters

## The probability density function
curve(dQXGP(x, mu=0.5, sigma=1, nu=1), from=0.1, to=8,
      ylim=c(0, 0.6), col="red", las=1, ylab="f(x)")


## The cumulative distribution and the Reliability function
par(mfrow=c(1, 2))
curve(pQXGP(x, mu=0.5, sigma=1, nu=1),
      from=0.1, to=8,  col="red", las=1, ylab="F(x)")
curve(pQXGP(x,  mu=0.5, sigma=1, nu=1, lower.tail=FALSE),
      from=0.1, to=8, col="red", las=1, ylab="R(x)")


## The quantile function
p <- seq(from=0, to=0.99999, length.out=100)
plot(x=qQXGP(p, mu=0.5, sigma=1, nu=1), y=p, xlab="Quantile",
     las=1, ylab="Probability")
curve(pQXGP(x, mu=0.5, sigma=1, nu=1),
      from=0.1, add=TRUE, col="red")
      
## The random function
hist(rQXGP(n=1000, mu=0.5, sigma=1, nu=1), freq=FALSE,
     xlab="x", ylim=c(0, 0.4), las=1, main="", xlim=c(0, 15))
curve(dQXGP(x, mu=0.5, sigma=1, nu=1),
      from=0.001, to=500, add=TRUE, col="red")


## The Hazard function
curve(hQXGP(x, mu=0.5, sigma=1, nu=1), from=0.01, to=3,
      col="red", ylab="Hazard function", las=1)

par(old_par) # restore previous graphical parameters
```
