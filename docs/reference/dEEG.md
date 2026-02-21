# The Extended Exponential Geometric distribution

Density, distribution function, quantile function, random generation and
hazard function for the Extended Exponential Geometric distribution with
parameters `mu` and `sigma`.

## Usage

``` r
dEEG(x, mu, sigma, log = FALSE)

pEEG(q, mu, sigma, lower.tail = TRUE, log.p = FALSE)

qEEG(p, mu, sigma, lower.tail = TRUE, log.p = FALSE)

rEEG(n, mu, sigma)

hEEG(x, mu, sigma)
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

`dEEG` gives the density, `pEEG` gives the distribution function, `qEEG`
gives the quantile function, `rEEG` generates random deviates and `hEEG`
gives the hazard function.

## Details

The Extended Exponential Geometric distribution with parameters `mu`,
and `sigma`has density given by

\\f(x)= \mu \sigma \exp(-\mu x)(1 - (1 - \sigma)\exp(-\mu x))^{-2},\\

for \\x \> 0\\, \\\mu \> 0\\ and \\\sigma \> 0\\.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Adamidis, K., Dimitrakopoulou, T., & Loukas, S. (2005). On an extension
of the exponential-geometric distribution. Statistics & probability
letters, 73(3), 259-269.

## See also

[EEG](http://fhernanb.github.io/RelDists/reference/EEG.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
old_par <- par(mfrow = c(1, 1)) # save previous graphical parameters

## The probability density function 
par(mfrow=c(1,1))
curve(dEEG(x, mu = 1, sigma =3), from = 0, to = 10, 
      col = "red", las = 1, ylab = "f(x)")


## The cumulative distribution and the Reliability function
par(mfrow = c(1, 2))
curve(pEEG(x, mu = 1, sigma =3), from = 0, to = 10, 
      ylim = c(0, 1), col = "red", las = 1, ylab = "F(x)")
curve(pEEG(x, mu = 1, sigma =3, lower.tail = FALSE), 
      from = 0, to = 6, ylim = c(0, 1), col = "red", las = 1, ylab = "R(x)")


## The quantile function
p <- seq(from = 0, to = 0.99999, length.out = 100)
plot(x = qEEG(p = p, mu = 1, sigma =0.5), y = p, 
     xlab = "Quantile", las = 1, ylab = "Probability")
curve(pEEG(x, mu = 1, sigma =0.5), from = 0, add = TRUE, 
      col = "red")

## The random function
hist(rEEG(1000, mu = 1, sigma =1), freq = FALSE, xlab = "x", 
     ylim = c(0, 0.9), las = 1, main = "")
curve(dEEG(x, mu = 1, sigma =1),  from = 0, add = TRUE, 
      col = "red", ylim = c(0, 0.8))


## The Hazard function
par(mfrow=c(1,1))
curve(hEEG(x, mu = 1, sigma =0.5), from = 0, to = 2, 
      col = "red", ylab = "Hazard function", las = 1)


par(old_par) # restore previous graphical parameters
```
