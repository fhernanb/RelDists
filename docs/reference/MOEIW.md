# The Marshall-Olkin Extended Inverse Weibull family

The Marshall-Olkin Extended Inverse Weibull family

## Usage

``` r
MOEIW(mu.link = "log", sigma.link = "log", nu.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma.

- nu.link:

  defines the nu.link, with "log" link as the default for the nu
  parameter.

## Value

Returns a gamlss.family object which can be used to fit a MOEIW
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Marshall-Olkin Extended Inverse Weibull distribution with parameters
`mu`, `sigma` and `nu` has density given by

\\f(x) = \frac{\mu \sigma \nu x^{-(\sigma + 1)} exp\\{-\mu
x^{-\sigma}}\\}{\\\nu -(\nu-1) exp\\{-\mu x ^{-\sigma}}\\ \\^{2}},\\

for x \> 0.

## References

Okasha, H. M., El-Baz, A. H., Tarabia, A. M. K., & Basheer, A. M.
(2017). Extended inverse Weibull distribution with reliability
application. Journal of the Egyptian Mathematical Society, 25(3),
343-349.

## See also

[dMOEIW](http://fhernanb.github.io/RelDists/reference/dMOEIW.md)

## Author

Amylkar Urrea Montoya, <amylkar.urrea@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma and nu
set.seed(123456)
y <- rMOEIW(n=100, mu=0.6, sigma=1.7, nu=0.3)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, family="MOEIW",
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod, what="mu"))
#> (Intercept) 
#>   0.4336193 
exp(coef(mod, what="sigma"))
#> (Intercept) 
#>    1.807662 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>   0.4693823 

# Example 2
# Generating random values under some model

# A function to simulate a data set with Y ~ MOEIW
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu    <- exp(-2.02 + 3 * x1) # 0.60 approximately
  sigma <- exp(2.23 - 2 * x2)  # 3.42 approximately
  nu    <- 2
  y <- rMOEIW(n=n, mu=mu, sigma=sigma, nu=nu)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(123)
dat <- gendat(n=100)

mod <- gamlss(y~x1, sigma.fo=~x2, nu.fo=~1, 
              family=MOEIW, data=dat,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>   -1.852971    2.792687 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    2.136396   -1.811521 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>    1.683432 
```
