# estim_mu_sigma_GL2

This function generates initial values for the GL2 distribution

## Usage

``` r
estim_mu_sigma_GL2(y)
```

## Arguments

- y:

  vector with the random sample

## Examples

``` r
y <- rGL2(n = 100, mu = 3, sigma = 1.2)
estim_mu_sigma_GL2(y = y)
#>    mu_hat sigma_hat 
#>  4.611474  2.080406 
```
