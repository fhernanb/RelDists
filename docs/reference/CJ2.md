# The two-parameter Chris-Jerry distribution family

The function `CJ2()` defines The two-parameter Chris-Jerry distribution,
a two parameter distribution, for a `gamlss.family` object to be used in
GAMLSS fitting using the function
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html).

## Usage

``` r
CJ2(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma.

## Value

Returns a gamlss.family object which can be used to fit a CJ2
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The two-parameter Chris-Jerry distribution with parameters `mu` and
`sigma` has density given by

\\ f(x; \sigma, \mu) = \frac{\mu^2}{\sigma \mu + 2} (\sigma + \mu x^2)
e^{-\mu x}; \quad x \> 0, \quad \mu \> 0, \quad \sigma \> 0 \\

Note: In this implementation we changed the original parameters
\\\theta\\ for \\\mu\\ and \\\lambda\\ for \\\sigma\\ we did it to
implement this distribution within gamlss framework.

## References

Chinedu, Eberechukwu Q., et al. "New lifetime distribution with
applications to single acceptance sampling plan and scenarios of
increasing hazard rates" Symmetry 15.10 (2023): 188.

## See also

[dCJ2](http://fhernanb.github.io/RelDists/reference/dCJ2.md)

## Author

Manuel Gutierrez Tangarife, <mgutierrezta@unal.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma
y <- rCJ2(n=500, mu=1, sigma=1.5)

# Fitting the model
require(gamlss)

mod1 <- gamlss(y~1, sigma.fo=~1, family=CJ2,
               control=gamlss.control(n.cyc=5000, trace=TRUE))
#> GAMLSS-RS iteration 1: Global Deviance = 1764.796 
#> GAMLSS-RS iteration 2: Global Deviance = 1764.796 

# Extracting the fitted values for mu, sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
#> (Intercept) 
#>     1.03033 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>   0.9964756 

# Example 2
# Generating random values under some model
gendat <- function(n) {
  x1 <- runif(n, min=0, max=5)
  x2 <- runif(n, min=0, max=5)
  mu <- exp(-0.2 + 1.5 * x1)
  sigma <- exp(1 - 0.7 * x2)
  y <- rCJ2(n=n, mu, sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(123)
datos <- gendat(n=500)

mod2 <- gamlss(y~x1, sigma.fo=~x2, family=CJ2, data=datos,
               control=gamlss.control(n.cyc=5000, trace=TRUE))
#> GAMLSS-RS iteration 1: Global Deviance = -2211.964 
#> GAMLSS-RS iteration 2: Global Deviance = -2213.243 
#> GAMLSS-RS iteration 3: Global Deviance = -2213.713 
#> GAMLSS-RS iteration 4: Global Deviance = -2213.887 
#> GAMLSS-RS iteration 5: Global Deviance = -2213.948 
#> GAMLSS-RS iteration 6: Global Deviance = -2213.97 
#> GAMLSS-RS iteration 7: Global Deviance = -2213.978 
#> GAMLSS-RS iteration 8: Global Deviance = -2213.981 
#> GAMLSS-RS iteration 9: Global Deviance = -2213.982 

summary(mod2)
#> Warning: summary: vcov has failed, option qr is used instead
#> ******************************************************************
#> Family:  c("CJ2", "a two-parameter\n Chris-Jerry distribution") 
#> 
#> Call:  
#> gamlss(formula = y ~ x1, sigma.formula = ~x2, family = CJ2, data = datos,  
#>     control = gamlss.control(n.cyc = 5000, trace = TRUE)) 
#> 
#> Fitting method: RS() 
#> 
#> ------------------------------------------------------------------
#> Mu link function:  log
#> Mu Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) -0.22632    0.05892  -3.841 0.000138 ***
#> x1           1.51252    0.02380  63.556  < 2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> Sigma link function:  log
#> Sigma Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)   1.0639     0.5649   1.883 0.060217 .  
#> x2           -0.6515     0.1850  -3.521 0.000469 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> No. of observations in the fit:  500 
#> Degrees of Freedom for the fit:  4
#>       Residual Deg. of Freedom:  496 
#>                       at cycle:  9 
#>  
#> Global Deviance:     -2213.982 
#>             AIC:     -2205.982 
#>             SBC:     -2189.123 
#> ******************************************************************
```
