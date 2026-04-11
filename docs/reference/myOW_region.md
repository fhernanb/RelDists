# Custimized region search for odd Weibull distribution

This function can be used to modify `OW` `gamlss.family` object in order
to set a customized region search for
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Usage

``` r
myOW_region(family = OW, valid.values = "auto", initVal)
```

## Arguments

- family:

  The [`OW`](http://fhernanb.github.io/RelDists/reference/OW.md) family.
  This arguments allows the user to modify input arguments of the
  family, like the `link` functions.

- valid.values:

  a list of character elements specifying the region for `sigma` and/or
  `nu`. See **Details** and **Examples** section to learn about its use.

- initVal:

  An `initValOW` object generated with
  [`initValuesOW`](http://fhernanb.github.io/RelDists/reference/initValuesOW.md)
  function.

## Value

Returns a `gamlss.family` object which can be used to fit an OW
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

This function was created to help users to fit `OW` distribution easily
bounding the parametric space for `sigma` and `nu`.

The `valid.values` must be defined as a list of characters containing a
call of the [`all`](https://rdrr.io/r/base/all.html) function.

## Author

Jaime Mosquera Gutiérrez <jmosquerag@unal.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma and nu
y <- rOW(n=200, mu=0.2, sigma=4, nu=0.05)

# Custom search region
myvalues <- list(sigma="all(sigma > 1)",
                 nu="all(nu < 1) & all(nu < 1)")

my_initial_guess <- initValuesOW(formula=y~1)
summary(my_initial_guess)
#> --------------------------------------------------------------------
#> Initial Values
#> sigma = 5
#> nu = 0.1
#> --------------------------------------------------------------------
#> Search Regions
#> For sigma: all(sigma > 1)
#> For nu: all(nu < 1/sigma)
#> --------------------------------------------------------------------
#> Hazard shape: Bathtub

# OW family modified with 'myOW_region'
require(gamlss)
myOW <- myOW_region(valid.values=myvalues, initVal=my_initial_guess)
mod1 <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, 
               sigma.start=param.startOW('sigma', my_initial_guess), 
               nu.start=param.startOW('nu', my_initial_guess),
               control=gamlss.control(n.cyc=300, trace=FALSE),
               family=myOW)

exp(coef(mod1, what='mu'))
#> (Intercept) 
#>   0.1985413 
exp(coef(mod1, what='sigma'))
#> (Intercept) 
#>    4.069383 
exp(coef(mod1, what='nu'))
#> (Intercept) 
#>  0.04848165 

# Example 2
# Same example using another link function and using 'myOW_region'
# in the argument 'family'
mod2 <- gamlss(y~1, sigma.fo=~1, nu.fo=~1, 
               sigma.start=2, nu.start=0.1,
               control=gamlss.control(n.cyc=300, trace=FALSE),
               family=myOW_region(family=OW(sigma.link='identity'),
                                  valid.values=myvalues,
                                  initVal=my_initial_guess))

exp(coef(mod2, what='mu'))
#> (Intercept) 
#>   0.1985762 
coef(mod2, what='sigma')
#> (Intercept) 
#>    4.068493 
exp(coef(mod2, what='nu'))
#> (Intercept) 
#>  0.04849019 
```
