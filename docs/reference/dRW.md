# The Reflected Weibull distribution

Density, distribution function, quantile function, random generation and
hazard function for the Reflected Weibull Distribution with parameters
`mu` and `sigma`.

## Usage

``` r
dRW(x, mu, sigma, log = FALSE)

pRW(q, mu, sigma, lower.tail = TRUE, log.p = FALSE)

qRW(p, mu, sigma, lower.tail = TRUE, log.p = FALSE)

rRW(n, mu, sigma)

hRW(x, mu, sigma)
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

`dRW` gives the density, `pRW` gives the distribution function, `qRW`
gives the quantile function, `rRW` generates random deviates and `hRW`
gives the hazard function.

## Details

The Reflected Weibull Distribution with parameters `mu` and `sigma` has
density given by

\\f(x) = \mu \sigma (-x) ^{\sigma - 1} e^{-\mu(-x)^\sigma},\\

for \\x \< 0\\.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Cohen, A. C. (1973). The reflected Weibull distribution. Technometrics,
15(4), 867-873.

## See also

[RW](http://fhernanb.github.io/RelDists/reference/RW.md)

## Author

Amylkar Urrea Montoya, <amylkar.urrea@udea.edu.co>

## Examples

``` r
old_par <- par(mfrow = c(1, 1)) # save previous graphical parameters

## The probability density function
curve(dRW(x, mu=1, sigma=1), from=-5, to=-0.01,
      col="red", las=1, ylab="f(x)")


## The cumulative distribution and the Reliability function
par(mfrow=c(1, 2))
curve(pRW(x, mu=1, sigma=1),
      from=-5, to=-0.01, col="red", las=1, ylab="F(x)")
curve(pRW(x, mu=1, sigma=1, lower.tail=FALSE),
      from=-5, to=-0.01, col="red", las=1, ylab="R(x)")


## The quantile function
p <- seq(from=0, to=0.99999, length.out=100)
plot(x=qRW(p, mu=1, sigma=1), y=p, xlab="Quantile",
     las=1, ylab="Probability")
curve(pRW(x, mu=1, sigma=1), from=-5, add=TRUE, col="red")

## The random function
hist(rRW(n=10000, mu=1, sigma=1), freq=FALSE,
     xlab="x", las=1, main="")
curve(dRW(x, mu=1, sigma=1), from=-5, to=-0.01, add=TRUE, col="red")


## The Hazard function
par(mfrow=c(1,1))
curve(hRW(x, mu=1, sigma=1), from=-0.3, to=-0.01,
      col="red", ylab="Hazard function", las=1)


par(old_par) # restore previous graphical parameters
```
