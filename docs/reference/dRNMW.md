# The Reduced New Modified Weibull distribution

Density, distribution function, quantile function, random generation and
hazard function for the reduced new modified Weibull distribution with
parameters `mu`, `sigma` and `nu`.

## Usage

``` r
dRNMW(x, mu, sigma, nu, log = FALSE)

pRNMW(q, mu, sigma, nu, lower.tail = TRUE, log.p = FALSE)

qRNMW(p, mu, sigma, nu, lower.tail = TRUE, log.p = FALSE)

rRNMW(n, mu, sigma, nu)

hRNMW(x, mu, sigma, nu)
```

## Arguments

- x, q:

  vector of quantiles.

- mu:

  parameter one.

- sigma:

  parameter two.

- nu:

  parameter three.

- log, log.p:

  logical; if TRUE, probabilities p are given as log(p).

- lower.tail:

  logical; if TRUE (default), probabilities are P\[T \<= t\], otherwise,
  P\[T \> t\].

- p:

  vector of probabilities.

- n:

  number of observations.

## Value

`dRNMW` gives the density, `pRNMW` gives the distribution function,
`qRNMW` gives the quantile function, `rRNMW` generates random deviates
and `hRNMW` gives the hazard function.

## Details

The reduced new modified Weibull with parameters `mu`, `sigma` and `nu`
has density given by

\$\$f(x) = \frac{1}{2 \sqrt{x}} \left( \mu + \sigma (1 + 2 \nu x) e^{\nu
x} \right) e^{-\mu \sqrt{x} - \sigma \sqrt{x} e^{\nu x}}\$\$

for \\x \> 0\\, \\\mu\>0\\, \\\sigma\>0\\ and \\\nu\>0\\.

## References

Almalki, S. J. (2018). A reduced new modified Weibull distribution.
Communications in Statistics-Theory and Methods, 47(10), 2297-2313.

## Author

Jaime Mosquera, <jmosquerag@unal.edu.co>

## Examples

``` r
old_par <- par(mfrow = c(1, 1)) # save previous graphical parameters

## The probability density function
curve(
    dRNMW(x, mu = 0.05, sigma = 0.00025, nu = 2.2),
    from = 0, to = 5, col = "red", las = 1, ylab = "f(x)"
)


## The cualphalative distribution and the Reliability function
par(mfrow = c(1, 2))
curve(
    pRNMW(x, mu = 0.05, sigma = 0.00025, nu = 2.2),
    from = 0, to = 5, ylim = c(0, 1),
    col = "red", las = 1, ylab = "F(x)"
)
curve(
    pRNMW(
        x, mu = 0.05, sigma = 0.00025, nu = 2.2, 
        lower.tail = FALSE
    ),
    from = 0, to = 5, ylim = c(0, 1),
    col = "red", las = 1, ylab = "R(x)"
)


## The quantile function
p <- seq(from = 0, to = 0.999, length.out = 100)
plot(
    x = qRNMW(p, mu = 0.05, sigma = 0.00025, nu = 2.2),
    y = p, xlab = "Quantile", las = 1,
    ylab = "Probability"
)
curve(
    pRNMW(x, mu = 0.05, sigma = 0.00025, nu = 2.2),
    from = 0, add = TRUE, col = "red"
)

## The random function
hist(
    rRNMW(n = 10000, mu = 0.05, sigma = 0.00025, nu = 2.2),
    freq = FALSE, xlab = "x", las = 1, main = "", ylim = c(0,0.8)
)
curve(dRNMW(x, mu = 0.05, sigma = 0.00025, nu = 2.2),
    from = 0, add = TRUE, col = "red"
)


## The Hazard function
par(mfrow = c(1, 1))
curve(
    hRNMW(x, mu = 0.003, sigma = 5e-6, nu = 0.025),
    from = 0, to = 250, col = "red", 
    ylab = "Hazard function", las = 1
)


par(old_par) # restore previous graphical parameters
```
