# The Power Lindley family

Power Lindley distribution

## Usage

``` r
PL(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma.

## Value

Returns a gamlss.family object which can be used to fit a PL
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Power Lindley Distribution with parameters `mu` and `sigma` has
density given by

\\f(x) = \frac{\mu \sigma^2}{\sigma + 1} (1 + x^\mu) x ^ {\mu - 1}
\exp({-\sigma x ^\mu}),\\

for x \> 0.

## References

Almalki, S. J., & Nadarajah, S. (2014). Modifications of the Weibull
distribution: A review. Reliability Engineering & System Safety, 124,
32-55.

Ghitany, M. E., Al-Mutairi, D. K., Balakrishnan, N., & Al-Enezi, L. J.
(2013). Power Lindley distribution and associated inference.
Computational Statistics & Data Analysis, 64, 20-33.

## See also

[dPL](http://fhernanb.github.io/RelDists/reference/dPL.md)

## Author

Amylkar Urrea Montoya, <amylkar.urrea@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma 
y <- rPL(n=100, mu=1.5, sigma=0.2)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, family= 'PL',
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod, 'mu'))
#> (Intercept) 
#>    1.393482 
exp(coef(mod, 'sigma'))
#> (Intercept) 
#>   0.2348385 

# Example 2
# Generating random values under some model
n <- 200
x1 <- runif(n, min=0.4, max=0.6)
x2 <- runif(n, min=0.4, max=0.6)
mu <- exp(1.2 - 2 * x1)
sigma <- exp(0.8 - 3 * x2)
x <- rPL(n=n, mu, sigma)

mod <- gamlss(x~x1, sigma.fo=~x2, family=PL,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>    1.135644   -2.042144 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    1.298703   -3.800249 
```
