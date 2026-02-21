# Mice mortality data

The ages at death in weeks for male mice exposed to 240r of gamma
radiation.

## Usage

``` r
data(mice)
```

## Format

A vector with 208 data points.

## Examples

``` r
data(mice)
hist(mice, main="", xlab="Time (weeks)", freq=FALSE)
lines(density(mice), col="blue", lwd=2)
```
