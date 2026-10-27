# The Beta Transformed Lomax distribution

The Beta Transformed Lomax family

## Usage

``` r
BTL(mu.link = "log", sigma.link = "log", nu.link = "log")
```

## Arguments

- mu.link:

  defines the mu.link, with "log" link as the default for the mu
  parameter.

- sigma.link:

  defines the sigma.link, with "log" link as the default for the sigma
  parameter.

- nu.link:

  defines the nu.link, with "log" link as the default for the nu
  parameter.

## Value

Returns a gamlss.family object which can be used to fit a BTL
distribution in the
[`gamlss()`](https://rdrr.io/pkg/gamlss/man/gamlss.html) function.

## Details

The Beta Transformed Lomax distribution with parameters `mu`, `sigma`
and `nu` has density given by

\\f(x) = \frac{\log \nu}{\nu-1} \frac{\sigma}{\mu}
\left(1+\frac{x}{\mu}\right)^{-(\sigma+1)}
\nu^{\left(1+\frac{x}{\mu}\right)^{-\sigma}},\\

for \\\nu \neq 1\\, and for \\\nu = 1\\:

\\f(x) = \frac{\sigma}{\mu}
\left(1+\frac{x}{\mu}\right)^{-(\sigma+1)},\\

for \\x \geq 0\\, \\\mu \> 0\\, \\\sigma \> 0\\ and \\\nu \> 0\\.

## References

Kottakkunnan, F. A New Generalization of Lomax Distribution: Estimation
and Modelling for Medical Data. J Stat Theory Appl 25, 19 (2026).
https://doi.org/10.1007/s44199-026-00171-0

## See also

[dBTL](http://fhernanb.github.io/RelDists/reference/dBTL.md)

## Author

Marieth Guillen, <mguillen@unal.edu.co>

## Examples

``` r
# Example 1
# Generating some random values with
# known mu, sigma and nu
y <- rBTL(n=300, mu=0.75, sigma=1.3, nu=0.5)

# Fitting the model
require(gamlss)
mod1 <- gamlss(y~1, sigma.fo=~1, nu.fo =~1, family=BTL,
               control=gamlss.control(n.cyc=5000, trace=FALSE))

# Extracting the fitted values for mu, sigma and nu
# using the inverse link function
exp(coef(mod1, what="mu"))
#> (Intercept) 
#>   0.8575942 
exp(coef(mod1, what="sigma"))
#> (Intercept) 
#>    1.673486 
exp(coef(mod1, what="nu"))
#> (Intercept) 
#>   0.2327326 

# Example 2
# Generating random values under some model
gendat <- function(n) {
  x1 <- runif(n)
  x2 <- runif(n)
  x3 <- runif(n)
  mu <- exp(1.5 - 2.0 * x1)   
  sigma <- exp(2.5 - 0.5 * x2) 
  nu <- exp(-2.0 + 4.5 * x3)
  y <- rBTL(n, mu, sigma, nu)
  data.frame(y=y, x1=x1, x2=x2, x3=x3)
}

dat <- gendat(n=2000)

mod2 <- gamlss(y~x1, sigma.fo=~x2, nu.fo=~x3, family=BTL, data=dat,
               control=gamlss.control(n.cyc=3000, trace=FALSE))

summary(mod2)
#> Warning: summary: vcov has failed, option qr is used instead
#> ******************************************************************
#> Family:  c("BTL", "Beta Transformed Lomax") 
#> 
#> Call:  gamlss(formula = y ~ x1, sigma.formula = ~x2, nu.formula = ~x3,  
#>     family = BTL, data = dat, control = gamlss.control(n.cyc = 3000,  
#>         trace = FALSE)) 
#> 
#> Fitting method: RS() 
#> 
#> ------------------------------------------------------------------
#> Mu link function:  log
#> Mu Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  0.55376    0.04941   11.21   <2e-16 ***
#> x1          -2.12513    0.08496  -25.01   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> Sigma link function:  log
#> Sigma Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  1.79849    0.04041  44.509  < 2e-16 ***
#> x2          -0.44456    0.06977  -6.372 2.31e-10 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> Nu link function:  log 
#> Nu Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  -2.9019     0.1719  -16.89   <2e-16 ***
#> x3            4.4904     0.2997   14.98   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> ------------------------------------------------------------------
#> No. of observations in the fit:  2000 
#> Degrees of Freedom for the fit:  6
#>       Residual Deg. of Freedom:  1994 
#>                       at cycle:  324 
#>  
#> Global Deviance:     -2972.274 
#>             AIC:     -2960.274 
#>             SBC:     -2926.668 
#> ******************************************************************
coef(mod2, what="mu")
#> (Intercept)          x1 
#>   0.5537586  -2.1251331 
coef(mod2, what="sigma")
#> (Intercept)          x2 
#>   1.7984874  -0.4445639 
coef(mod2, what="nu")
#> (Intercept)          x3 
#>   -2.901930    4.490384 

# Example 3
# Fatigue life (T) measures in cycles (×10-3) of n 101
# aluminum coupons (specimens) of type 6061-T6.
# Taken from Leiva et al. (2006) page 37.
# https://journal.r-project.org/articles/RN-2006-033/RN-2006-033.pdf

y <- c(0.0251, 0.0886, 0.0891, 0.2501, 0.3113, 0.3451, 
       0.4763, 0.5650, 0.5671, 0.6566, 0.6748, 0.6751, 
       0.6753, 0.7696, 0.8375, 0.8391, 0.8425, 0.8645, 
       0.8851, 0.9113, 0.9120, 0.9836, 1.0483, 1.0596, 
       1.0773, 1.1733, 1.2570, 1.2766, 1.2985, 1.3211, 
       1.3503, 1.3551, 1.4595, 1.4880, 1.5728, 1.5733, 
       1.7083, 1.7263, 1.7460, 1.7630, 1.7746, 1.8275, 
       1.8375, 1.8503, 1.8808, 1.8878, 1.8881, 1.9316, 
       1.9558, 2.0048, 2.0408, 2.0903, 2.1093, 2.1330, 
       2.2100, 2.2460, 2.2878, 2.3203, 2.3470, 2.3513, 
       2.4951, 2.5260, 2.9911, 3.0256, 3.2678, 3.4045, 
       3.4846, 3.7433, 3.7455, 3.9143, 4.8073, 5.4005, 
       5.4435, 5.5295, 6.5541, 9.0960)

mod3 <- gamlss(y~1, family=BTL, 
               control=gamlss.control(n.cyc=500, trace=FALSE))

# Extracting the fitted values for mu and sigma
# using the inverse link function
exp(coef(mod3, what="mu"))
#> (Intercept) 
#>    5.001817 
exp(coef(mod3, what="sigma"))
#> (Intercept) 
#>    6.360587 
exp(coef(mod3, what="nu"))
#> (Intercept) 
#>  0.02118954 
```
