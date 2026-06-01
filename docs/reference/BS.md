# The Birnbaum-Saunders family

The function `BS()` defines The Birnbaum-Saunders, a two parameter
distribution, for a `gamlss.family` object to be used in GAMLSS fitting
using the function
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html).

## Usage

``` r
BS(mu.link = "log", sigma.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma.

## Value

Returns a gamlss.family object which can be used to fit a BS
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Birnbaum-Saunders with parameters `mu` and `sigma` has density given
by

\\f(x\|\mu,\sigma) = \frac{x^{-3/2}(x+\mu)}{2\sigma\sqrt{2\pi\mu}}
\exp\left(\frac{-1}{2\sigma^2}(\frac{x}{\mu}+\frac{\mu}{x}-2)\right)\\

for \\x\>0\\, \\\mu\>0\\ and \\\sigma\>0\\. In this parameterization
\\\mu\\ is the median of \\X\\, \\E(X)=\mu(1+\sigma^2/2)\\ and
\\Var(X)=(\mu\sigma)^2(1+5\sigma^2/4)\\. The functions proposed here
corresponds to the functions created by Roquim et al. (2021) with minor
modifications to obtain correct log-likelihoods and random samples.

## References

Birnbaum, Z.W. and Saunders, S.C. (1969a). A new family of life
distributions. J. Appl. Prob., 6, 319–327.

Roquim, F. V., Ramires, T. G., Nakamura, L. R., Righetto, A. J., Lima,
R. R., & Gomes, R. A. (2021). Building flexible regression models:
including the Birnbaum-Saunders distribution in the gamlss package.
Semina: Ciencias Exatas e Tecnologicas, 42(2), 163-168.

## See also

[dBS](http://fhernanb.github.io/RelDists/reference/dBS.md)

## Examples

``` r
# Example 1
# Generating some random values with
# known mu and sigma
y <- rBS(n=100, mu=0.75, sigma=1.3)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, family=BS)
#> GAMLSS-RS iteration 1: Global Deviance = 237.3994 
#> GAMLSS-RS iteration 2: Global Deviance = 237.3972 
#> GAMLSS-RS iteration 3: Global Deviance = 237.3972 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod1, what="mu"))
#> (Intercept) 
#>   0.7713414 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>    1.243161 

# Example 2
# Generating random values for a regression model

# A function to simulate a data set with Y as BS
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  mu <- exp(1.45 - 3 * x1)
  sigma <- exp(2 - 1.5 * x2)
  y <- rBS(n=n, mu=mu, sigma=sigma)
  data.frame(y=y, x1=x1, x2=x2)
}

set.seed(123)
dat <- gendat(n=300)

mod2 <- gamlss(y~x1, sigma.fo=~x2, 
               family=BS, data=dat)
#> GAMLSS-RS iteration 1: Global Deviance = 6624.679 
#> GAMLSS-RS iteration 2: Global Deviance = 6593.565 
#> GAMLSS-RS iteration 3: Global Deviance = 6556.349 
#> GAMLSS-RS iteration 4: Global Deviance = 6506.77 
#> GAMLSS-RS iteration 5: Global Deviance = 6432.284 
#> GAMLSS-RS iteration 6: Global Deviance = 6279.265 
#> GAMLSS-RS iteration 7: Global Deviance = 1685.61 
#> GAMLSS-RS iteration 8: Global Deviance = 1208.005 
#> GAMLSS-RS iteration 9: Global Deviance = 1202.153 
#> GAMLSS-RS iteration 10: Global Deviance = 1202.152 

summary(mod2)
#> Warning: summary: vcov has failed, option qr is used instead
#> ******************************************************************
#> Family:  c("BS", "Birnbaum-Saunders") 
#> 
#> Call:  gamlss(formula = y ~ x1, sigma.formula = ~x2, family = BS, data = dat) 
#> 
#> 
#> Fitting method: RS() 
#> 
#> ------------------------------------------------------------------
#> Mu link function:  log
#> Mu Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)    1.476      0.236   6.256 1.37e-09 ***
#> x1            -3.274      0.376  -8.707  < 2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> Sigma link function:  log
#> Sigma Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  2.01922    0.08094   24.95   <2e-16 ***
#> x2          -1.52035    0.14010  -10.85   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> No. of observations in the fit:  300 
#> Degrees of Freedom for the fit:  4
#>       Residual Deg. of Freedom:  296 
#>                       at cycle:  10 
#>  
#> Global Deviance:     1202.153 
#>             AIC:     1210.153 
#>             SBC:     1224.968 
#> ******************************************************************

# Example 3
# Fatigue life (T) measures in cycles (×10-3) of n 101
# aluminum coupons (specimens) of type 6061-T6.
# Taken from Leiva et al. (2006) page 37.
# https://journal.r-project.org/articles/RN-2006-033/RN-2006-033.pdf

y <- c(70, 90, 96, 97, 99, 100, 103, 104,
       104, 105, 107, 108, 108, 108, 109, 109,
       112, 112, 113, 114, 114, 114, 116, 119,
       120, 120, 120, 121, 121, 123, 124, 124,
       124, 124, 124, 128, 128, 129, 129, 130,
       130, 130, 131, 131, 131, 131, 131, 132,
       132, 132, 133, 134, 134, 134, 134, 134,
       136, 136, 137, 138, 138, 138, 139, 139,
       141, 141, 142, 142, 142, 142, 142, 142,
       144, 144, 145, 146, 148, 148, 149, 151,
       151, 152, 155, 156, 157, 157, 157, 157,
       158, 159, 162, 163, 163, 164, 166, 166,
       168, 170, 174, 196, 212)

mod3 <- gamlss(y~1, sigma.fo=~1, family=BS)
#> GAMLSS-RS iteration 1: Global Deviance = 914.5494 
#> GAMLSS-RS iteration 2: Global Deviance = 914.5411 
#> GAMLSS-RS iteration 3: Global Deviance = 914.5411 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod3, what="mu"))
#> (Intercept) 
#>    131.8188 
exp(coef(mod3, what="sigma"))
#> (Intercept) 
#>   0.1703847 

# Example 4
# Aggregate payments by the insurer
# in thousand Skr (Swedish currency).
# Taken from Balakrishnan and Kundu (2019) page 65.
# https://onlinelibrary.wiley.com/doi/abs/10.1002/asmb.2348

y <- c(5014, 5855, 6486, 6540, 6656, 6656, 7212, 7541, 7558, 
       7797, 8546, 9345, 11762, 12478, 13624, 14451,
       14940, 14963, 15092, 16203, 16229, 16730, 18027, 
       18343, 19365, 21782, 24248, 29069, 34267, 38993)

y <- y/10000

mod4 <- gamlss(y~1, sigma.fo=~1, family=BS)
#> GAMLSS-RS iteration 1: Global Deviance = 61.4839 
#> GAMLSS-RS iteration 2: Global Deviance = 61.4837 

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod4, what="mu"))
#> (Intercept) 
#>    1.256498 
exp(coef(mod4, what="sigma"))
#> (Intercept) 
#>   0.5595511 


```
