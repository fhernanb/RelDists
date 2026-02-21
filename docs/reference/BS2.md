# The Birnbaum-Saunders family - Santos-Neto et al. (2014)

The function `BS2()` defines The Birnbaum-Saunders, a two parameter
distribution, for a `gamlss.family` object to be used in GAMLSS fitting
using the function
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html).

## Usage

``` r
BS2(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma.

## Value

Returns a gamlss.family object which can be used to fit a BS2
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Birnbaum-Saunders with parameters `mu` and `sigma` has density given
by

\\f(x\|\mu,\sigma) =
\frac{\exp(\sigma/2)\sqrt{\sigma+1}}{4\sqrt{\pi\mu}x^{3/2}} \left\[ x +
\frac{\mu\sigma}{\sigma+1} \right\] \exp\left( \frac{-\sigma}{4}
\left(\frac{x(\sigma+1)}{\mu\sigma}+\frac{\mu\sigma}{x(\sigma+1)}
\right) \right) \\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization
\\E(X)=\mu\\ and \\Var(X)=\frac{\mu^2(2\sigma+5)}{(\sigma+1)^2}\\.

## References

Santos-Neto, M., Cysneiros, F. J. A., Leiva, V., & Barros, M. (2014). A
reparameterized Birnbaum–Saunders distribution and its moments,
estimation and applications. REVSTAT-Statistical Journal, 12(3),
247-272.

## See also

[dBS2](http://fhernanb.github.io/RelDists/reference/dBS2.md).

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma
y <- rBS2(n=50, mu=5, sigma=3)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS2)
#> GAMLSS-RS iteration 1: Global Deviance = 256.5522 
#> GAMLSS-RS iteration 2: Global Deviance = 249.3285 
#> GAMLSS-RS iteration 3: Global Deviance = 248.5876 
#> GAMLSS-RS iteration 4: Global Deviance = 248.5523 
#> GAMLSS-RS iteration 5: Global Deviance = 248.5511 
#> GAMLSS-RS iteration 6: Global Deviance = 248.551 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
#> (Intercept) 
#>    4.970791 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>    2.986832 

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y ~ BS2
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.45 - 3 * x1)
  sigma <- exp(2 - 1.5 * x2)
  y <- rBS2(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(123)
dat <- gendat(n=100)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS2, data=dat)
#> GAMLSS-RS iteration 1: Global Deviance = 159.4399 
#> GAMLSS-RS iteration 2: Global Deviance = 143.4244 
#> GAMLSS-RS iteration 3: Global Deviance = 141.9155 
#> GAMLSS-RS iteration 4: Global Deviance = 141.8536 
#> GAMLSS-RS iteration 5: Global Deviance = 141.8508 
#> GAMLSS-RS iteration 6: Global Deviance = 141.8508 

summary(mod2)
#> Warning: summary: vcov has failed, option qr is used instead
#> ******************************************************************
#> Family:  c("BS2", "Birnbaum-Saunders - second parameterization") 
#> 
#> Call:  gamlss(formula = y ~ x1, sigma.formula = ~x2, family = BS2, data = dat) 
#> 
#> 
#> Fitting method: RS() 
#> 
#> ------------------------------------------------------------------
#> Mu link function:  log
#> Mu Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)   1.5150     0.1639   9.241 5.37e-15 ***
#> x1           -3.1673     0.2761 -11.472  < 2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> ------------------------------------------------------------------
#> Sigma link function:  log
#> Sigma Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)   1.9226     0.3121   6.160 1.61e-08 ***
#> x2           -1.3323     0.5464  -2.439   0.0165 *  
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> ------------------------------------------------------------------
#> No. of observations in the fit:  100 
#> Degrees of Freedom for the fit:  4
#>       Residual Deg. of Freedom:  96 
#>                       at cycle:  6 
#>  
#> Global Deviance:     141.8508 
#>             AIC:     149.8508 
#>             SBC:     160.2715 
#> ******************************************************************

# Example 3
# Household expenditures for food in the United States (US) expressed
# in thousands of US dollars (M$)
# Santos-Neto et al. (2014) page 266.

y <- c(15.998, 16.652, 21.741, 7.431, 10.481, 13.548, 23.256, 17.976, 
       14.161, 8.825, 14.184, 19.604, 13.728, 21.141, 17.446, 9.629, 
       14.005, 9.160, 18.831, 7.641, 13.882, 9.670, 21.604, 10.866, 
       28.980, 10.882, 18.561, 11.629, 18.067, 14.539, 19.192, 25.918, 
       28.833, 15.869, 14.910, 9.550, 23.066, 14.751)

mod3 <- gamlss(y~1, sigma.fo=~1, family=BS2)
#> GAMLSS-RS iteration 1: Global Deviance = 273.8873 
#> GAMLSS-RS iteration 2: Global Deviance = 241.5346 
#> GAMLSS-RS iteration 3: Global Deviance = 234.6666 
#> GAMLSS-RS iteration 4: Global Deviance = 234.5041 
#> GAMLSS-RS iteration 5: Global Deviance = 234.5031 
#> GAMLSS-RS iteration 6: Global Deviance = 234.5031 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod3, what="mu"))
#> (Intercept) 
#>    15.95236 
exp(coef(mod3, what="sigma"))
#> (Intercept) 
#>    15.57376 

# Example 4
# lifetimes of 6061-T6 aluminum coupons expressed in cycles (×10-3)
# at a maximum stress level of 3.1 psi (×104), until the failure to occur.
# Santos-Neto et al. (2014) page 267.

y <- c(70, 90, 96, 97, 99, 100, 103, 104, 104, 105, 107, 108, 108, 108, 109,
       109, 112, 112, 113, 114, 114, 114, 116, 119, 120, 120, 120, 121, 121, 
       123, 124, 124, 124, 124, 124, 128, 128, 129, 129, 130, 130, 130, 131, 
       131, 131, 131, 131, 132, 132, 132, 133, 134, 134, 134, 134, 134, 136, 
       136, 137, 138, 138, 138, 139, 139, 141, 141, 142, 142, 142, 142, 142, 
       142, 144, 144, 145, 146, 148, 148, 149, 151, 151, 152, 155, 156, 157, 
       157, 157, 157, 158, 159, 162, 163, 163, 164, 166, 166, 168, 170, 174, 
       196, 212)

mod4 <- gamlss(y~1, sigma.fo=~1, family=BS2)
#> GAMLSS-RS iteration 1: Global Deviance = 1119.695 
#> GAMLSS-RS iteration 2: Global Deviance = 959.2597 
#> GAMLSS-RS iteration 3: Global Deviance = 915.0024 
#> GAMLSS-RS iteration 4: Global Deviance = 914.5413 
#> GAMLSS-RS iteration 5: Global Deviance = 914.5411 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod4, what="mu"))
#> (Intercept) 
#>    133.7347 
exp(coef(mod4, what="sigma"))
#> (Intercept) 
#>    68.85699 
```
