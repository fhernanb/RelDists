# The Sarhan and Zaindin's Modified Weibull distribution

Density, distribution function, quantile function, random generation and
hazard function for Sarhan and Zaindins modified weibull distribution
with parameters `mu`, `sigma` and `nu`.

## Usage

``` r
dSZMW(x, mu, sigma, nu, log = FALSE)

pSZMW(q, mu, sigma, nu, lower.tail = TRUE, log.p = FALSE)

qSZMW(p, mu, sigma, nu, lower.tail = TRUE, log.p = FALSE)

rSZMW(n, mu, sigma, nu)

hSZMW(x, mu, sigma, nu)
```

## Arguments

- x, q:

  vector of quantiles.

- mu:

  scale parameter.

- sigma:

  shape parameter.

- nu:

  shape parameter.

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

`dSZMW` gives the density, `pSZMW` gives the distribution function,
`qSZMW` gives the quantile function, `rSZMW` generates random deviates
and `hSZMW` gives the hazard function.

## Details

The Sarhan and Zaindins modified weibull with parameters `mu`, `sigma`
and `nu` has density given by

\\f(x)=(\mu + \sigma \nu x^{\nu - 1}) \exp(- \mu x - \sigma x^\nu)\\

for \\x \> 0\\, \\\mu \> 0\\, \\\sigma \> 0\\ and \\\nu \> 0\\.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Sarhan, A. M., & Zaindin, M. (2009). Modified Weibull distribution.
APPS. Applied Sciences, 11, 123-136.

## See also

[SZMW](http://fhernanb.github.io/RelDists/reference/SZMW.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
old_par <- par(mfrow = c(1, 1)) # save previous graphical parameters

## The probability density function
curve(dSZMW(x, mu = 2, sigma = 1.5, nu = 0.2), from = 0, to = 2, 
      ylim = c(0, 1.7), col = "red", las = 1, ylab = "f(x)")

## The cumulative distribution and the Reliability function
par(mfrow = c(1, 2))
curve(pSZMW(x, mu = 2, sigma = 1.5, nu = 0.2), from = 0, to = 2, ylim = c(0, 1),
      col = "red", las = 1, ylab = "F(x)")
curve(pSZMW(x, mu = 2, sigma = 1.5, nu = 0.2, lower.tail = FALSE), from = 0,
      to = 2, ylim = c(0, 1), col = "red", las = 1, ylab = "R(x)")


## The quantile function
p <- seq(from = 0, to = 0.99999, length.out = 100)
plot(x = qSZMW(p = p, mu = 2, sigma = 1.5, nu = 0.2), y = p, xlab = "Quantile",
     las = 1, ylab = "Probability")
curve(pSZMW(x, mu = 2, sigma = 1.5, nu = 0.2), from = 0, add = TRUE, col = "red")

## The random function
hist(rSZMW(n = 1000, mu = 2, sigma = 1.5, nu = 0.2), freq = FALSE, xlab = "x",
     las = 1, main = "")
curve(dSZMW(x, mu = 2, sigma = 1.5, nu = 0.2),  from = 0, add = TRUE, col = "red")


## The Hazard function
par(mfrow=c(1,1))
curve(hSZMW(x, mu = 2, sigma = 1.5, nu = 0.2), from = 0, to = 3, ylim = c(0, 8),
      col = "red", ylab = "Hazard function", las = 1)


par(old_par) # restore previous graphical parameters
```
