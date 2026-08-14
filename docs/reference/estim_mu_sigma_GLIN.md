# estim_mu_sigma_GLIN

This function generates initial values for the GLIN distribution

## Usage

``` r
estim_mu_sigma_GLIN(y)
```

## Arguments

- y:

  vector with the random sample

## Examples

``` r
y <- rGLIN(n = 100, mu = 3, sigma = 1.2)
estim_mu_sigma_GLIN(y = y)
#>    mu_hat sigma_hat 
#> 2.1930086 0.5952888 
```
