# The Marshall-Olkin Kappa family

The Marshall-Olkin Kappa family

## Usage

``` r
MOK(mu.link = "log", sigma.link = "log", nu.link = "log", tau.link = "log")
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

- tau.link:

  defines the tau.link, with "log" link as the default for the tau
  parameter.

## Value

Returns a gamlss.family object which can be used to fit a MOK
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Marshall-Olkin Kappa distribution with parameters `mu`, `sigma`,
`nu` and `tau` has density given by

\\f(x)=\frac{\tau\frac{\mu\nu}{\sigma}\left(\frac{x}{\sigma}\right)^{\nu-1}
\left(\mu+\left(\frac{x}{\sigma}\right)^{\mu\nu}\right)^{-\frac{\mu+1}{\mu}}}{\left(\tau+(1-\tau)\left(\frac{\left(\frac{x}{\sigma}\right)^{\mu\nu}}{\mu+\left(\frac{x}{\sigma}\right)^{\mu\nu}}\right)^{\frac{1}{\mu}}\right)^2}\\

for x \> 0.

## References

Javed, M., Nawaz, T., & Irfan, M. (2019). The Marshall-Olkin kappa
distribution: properties and applications. Journal of King Saud
University-Science, 31(4), 684-691.

## See also

[dMOK](http://fhernanb.github.io/RelDists/reference/dMOK.md)

## Author

Johan David Marin Benjumea, <johand.marin@udea.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma, nu and tau
y <- rMOK(n=100, mu = 1, sigma = 3.5, nu = 3, tau = 2)

# Fitting the model
require(gamlss)

mod <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, tau.fo=~1, family=MOK,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma, nu and tau
# using the inverse link function
exp(coef(mod, what='mu'))
#> (Intercept) 
#>   0.5221842 
exp(coef(mod, what='sigma'))
#> (Intercept) 
#>    4.096174 
exp(coef(mod, what='nu'))
#> (Intercept) 
#>    4.319638 
exp(coef(mod, what='tau'))
#> (Intercept) 
#>   0.8688688 

# Example 2
# Generating random values under some model
n <- 200
x1 <- runif(n, min=0.4, max=0.6)
x2 <- runif(n, min=0.4, max=0.6)
mu <- exp(0.5 + x1)
sigma <- exp(0.8 + x2)
nu <- 1
tau <- 0.5
x <- rMOK(n=n, mu, sigma, nu, tau)

mod <- gamlss(x~x1, sigma.fo=~x2, nu.fo=~1, tau.fo=~1, family=MOK,
              control=gamlss.control(n.cyc=5000, trace=FALSE))

coef(mod, what="mu")
#> (Intercept)          x1 
#>   0.4642051   2.2925826 
coef(mod, what="sigma")
#> (Intercept)          x2 
#>    1.021868    1.107709 
exp(coef(mod, what="nu"))
#> (Intercept) 
#>   0.9657106 
exp(coef(mod, what="tau"))
#> (Intercept) 
#>   0.4504914 
```
