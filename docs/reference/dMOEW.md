# The Marshall-Olkin Extended Weibull distribution

Density, distribution function, quantile function, random generation and
hazard function for the Marshall-Olkin Extended Weibull distribution
with parameters `mu`, `sigma` and `nu`.

## Usage

``` r
dMOEW(x, mu, sigma, nu, log = FALSE)

pMOEW(q, mu, sigma, nu, lower.tail = TRUE, log.p = FALSE)

qMOEW(p, mu, sigma, nu, lower.tail = TRUE, log.p = FALSE)

rMOEW(n, mu, sigma, nu)

hMOEW(x, mu, sigma, nu)
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

`dMOEW` gives the density, `pMOEW` gives the distribution function,
`qMOEW` gives the quantile function, `rMOEW` generates random deviates
and `hMOEW` gives the hazard function.

## Details

The Marshall-Olkin Extended Weibull distribution `mu`, `sigma` and `nu`
has density given by

\\f(x) = \frac{\mu \sigma \nu (\nu x)^{\sigma - 1} exp\\{-(\nu x
)^{\sigma}}\\}{\\1-(1-\mu) exp\\{-(\nu x )^{\sigma}}\\ \\^{2}},\\

for \\x \> 0\\.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Ghitany, M. E., Al-Hussaini, E. K., & Al-Jarallah, R. A. (2005).
Marshall–Olkin extended Weibull distribution and its application to
censored data. Journal of Applied Statistics, 32(10), 1025-1034.

## See also

[MOEW](http://fhernanb.github.io/RelDists/reference/MOEW.md)

## Author

Amylkar Urrea Montoya, <amylkar.urrea@udea.edu.co>

## Examples

``` r
old_par <- par(mfrow = c(1, 1)) # save previous graphical parameters

## The probability density function
curve(dMOEW(x, mu=0.5, sigma=0.7, nu=1), from=0.001, to=1,
      col="red", ylab="f(x)", las=1)


## The cumulative distribution and the Reliability function
par(mfrow=c(1, 2))
curve(pMOEW(x, mu=0.5, sigma=0.7, nu=1),
      from=0.0001, to=2, col="red", las=1, ylab="F(x)")
curve(pMOEW(x, mu=0.5, sigma=0.7, nu=1, lower.tail=FALSE),
      from=0.0001, to=2, col="red", las=1, ylab="R(x)")


## The quantile function
p <- seq(from=0, to=0.99999, length.out=100)
plot(x=qMOEW(p, mu=0.5, sigma=0.7, nu=1), y=p, xlab="Quantile",
     las=1, ylab="Probability")
curve(pMOEW(x, mu=0.5, sigma=0.7, nu=1),
      from=0, add=TRUE, col="red")

## The random function
hist(rMOEW(n=100, mu=0.5, sigma=0.7, nu=1), freq=FALSE,
     xlab="x", ylim=c(0, 1), las=1, main="")
curve(dMOEW(x, mu=0.5, sigma=0.7, nu=1),
      from=0.001, to=2, add=TRUE, col="red")


## The Hazard function
curve(hMOEW(x, mu=0.5, sigma=0.7, nu=1), from=0.001, to=3,
      col="red", ylab="Hazard function", las=1)

par(old_par) # restore previous graphical parameters
```
