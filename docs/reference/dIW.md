# The Inverse Weibull distribution

Density, distribution function, quantile function, random generation and
hazard function for the inverse weibull distribution with parameters
`mu` and `sigma`.

## Usage

``` r
dIW(x, mu, sigma, log = FALSE)

pIW(q, mu, sigma, lower.tail = TRUE, log.p = FALSE)

qIW(p, mu, sigma, lower.tail = TRUE, log.p = FALSE)

rIW(n, mu, sigma)

hIW(x, mu, sigma)
```

## Arguments

- x, q:

  vector of quantiles.

- mu:

  scale parameter.

- sigma:

  shape parameters.

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

`dIW` gives the density, `pIW` gives the distribution function, `qIW`
gives the quantile function, `rIW` generates random deviates and `hIW`
gives the hazard function.

## Details

The inverse weibull distribution with parameters `mu` and `sigma` has
density given by

\\f(x) = \mu \sigma x^{-\sigma-1} \exp(\mu x^{-\sigma})\\

for \\x \> 0\\, \\\mu \> 0\\ and \\\sigma \> 0\\

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Drapella, A. (1993). The complementary Weibull distribution: unknown or
just forgotten?. Quality and reliability engineering international,
9(4), 383-385.

## See also

[IW](http://fhernanb.github.io/RelDists/reference/IW.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
old_par <- par(mfrow = c(1, 1)) # save previous graphical parameters

## The probability density function
curve(dIW(x, mu=5, sigma=2.5), from=0, to=10,
      ylim=c(0, 0.55), col="red", las=1, ylab="f(x)")

#'
## The cumulative distribution and the Reliability function
par(mfrow=c(1, 2))
curve(pIW(x, mu=5, sigma=2.5),
      from=0, to=10,  col="red", las=1, ylab="F(x)")
curve(pIW(x, mu=5, sigma=2.5, lower.tail=FALSE),
      from=0, to=10, col="red", las=1, ylab="R(x)")

            
## The quantile function
p <- seq(from=0, to=0.99999, length.out=100)
plot(x=qIW(p, mu=5, sigma=2.5), y=p, xlab="Quantile",
  las=1, ylab="Probability")
curve(pIW(x, mu=5, sigma=2.5), from=0, add=TRUE, col="red")
  
## The random function
hist(rIW(n=10000, mu=5, sigma=2.5), freq=FALSE, xlim=c(0,60),
  xlab="x", las=1, main="")
curve(dIW(x, mu=5, sigma=2.5), from=0, add=TRUE, col="red")


## The Hazard function
par(mfrow=c(1,1))
curve(hIW(x, mu=5, sigma=2.5), from=0, to=15, ylim=c(0, 0.9),
   col="red", ylab="Hazard function", las=1)


par(old_par) # restore previous graphical parameters
```
