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
# known mu and sigma

hist(rnorm(1000))


```
