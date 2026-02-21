# The Modified Weibull distribution

Density, distribution function, quantile function, random generation and
hazard function for the modified weibull distribution with parameters
`mu`, `sigma` and `nu`.

## Usage

``` r
dMW(x, mu, sigma, nu, log = FALSE)

pMW(q, mu, sigma, nu, lower.tail = TRUE, log.p = FALSE)

qMW(p, mu, sigma, nu, lower.tail = TRUE, log.p = FALSE)

rMW(n, mu, sigma, nu)

hMW(x, mu, sigma, nu)
```

## Arguments

- x, q:

  vector of quantiles.

- mu:

  shape parameter one.

- sigma:

  parameter two.

- nu:

  scale parameter three.

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

`dMW` gives the density, `pMW` gives the distribution function, `qMW`
gives the quantile function, `rMW` generates random deviates and `hMW`
gives the hazard function.

## Details

The modified weibull distribution with parameters `mu`, `sigma` and `nu`
has density given by

\\f(x) = \mu (\sigma + \nu x) x^{\sigma - 1} \exp(\nu x) \exp(-\mu
x^{\sigma} \exp(\nu x))\\

for \\x \> 0\\, \\\mu \> 0\\, \\\sigma \geq 0\\ and \\\nu \geq 0\\.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Lai, C. D., Xie, M., & Murthy, D. N. P. (2003). A modified Weibull
distribution. IEEE Transactions on reliability, 52(1), 33-37.

## See also

[MW](http://fhernanb.github.io/RelDists/reference/MW.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
old_par <- par(mfrow = c(1, 1)) # save previous graphical parameters

## The probability density function 
curve(dMW(x, mu=2, sigma=1.5, nu=0.2), from=0, to=2,
  ylim=c(0, 1.5), col="red", las=1, ylab="f(x)")


## The cumulative distribution and the Reliability function
par(mfrow = c(1, 2))
curve(pMW(x, mu=2, sigma=1.5, nu=0.2), from=0, to=2,
 col = "red", las=1, ylab="F(x)")
curve(pMW(x, mu=2, sigma=1.5, nu=0.2, lower.tail = FALSE), 
from=0, to=2, col="red", las=1, ylab ="R(x)")


## The quantile function
p <- seq(from=0, to=0.9999, length.out=100)
plot(x=qMW(p, mu=2, sigma=1.5, nu=0.2), y=p, xlab="Quantile",
 las=1, ylab="Probability")
curve(pMW(x, mu=2, sigma=1.5, nu=0.2), from=0, add=TRUE, col="red")

## The random function
hist(rMW(n=1000, mu=2, sigma=1.5, nu=0.2), freq=FALSE,
 xlab="x", las=1, main="")
curve(dMW(x, mu=2, sigma=1.5, nu=0.2), from=0, add=TRUE, col="red")


## The Hazard function
par(mfrow=c(1,1))
curve(hMW(x, mu=2, sigma=1.5, nu=0.2), from=0, to=1.5, ylim=c(0, 5),
 col="red", las=1, ylab="H(x)", las=1)


par(old_par) # restore previous graphical parameters
```
