# estim_mu_sigma_nu_MCWEI

This function generates initial values for MCWEI distribution.

## Usage

``` r
estim_mu_sigma_nu_MCWEI(y)
```

## Arguments

- y:

  vector with the random sample

## Examples

``` r
y <- rMCWEI(n=100, mu=1, sigma=1, nu=1)
estim_mu_sigma_nu_MCWEI(y=y)
#>    mu_hat sigma_hat    nu_hat 
#> 1.0726033 0.7538558 2.7489732 
```
