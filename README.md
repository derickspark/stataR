# stataR

[![R build status](https://github.com/yourusername/stataR/workflows/R-CMD-check/badge.svg)](https://github.com/yourusername/stataR/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Overview

**stataR** is a lightweight R package that provides **Stata-style tabulation tools** using tidyverse syntax.  
It includes two main functions:

- `st_tab()`: Summarize one or more variables (frequencies for categorical, statistics for numeric).
- `st_crosstab()`: Grouped summary by a categorical variable, supporting both continuous and categorical targets.

This is useful for quick descriptive statistics and reporting, especially for users familiar with Stata's `tab` and `table` commands.

---

## Installation

You can install the development version from GitHub:

```r
# install.packages("remotes")
remotes::install_github("yourusername/stataR")
```

## Usage

```r
library(stataR)

# One-way tabulation: frequencies and numeric summaries
st_tab(mtcars, mpg, cyl, gear)

# Grouped cross-tabulation: summary by grouping variable
st_crosstab(mtcars, cyl, mpg, gear, hp)
```

### Function Details

st_tab(data, ...)

Summarizes a list of variables:
	•	Numeric: mean, sd, min, median, max
	•	Categorical: frequency and percent

```r
st_tab(mtcars, mpg, gear)
```

st_crosstab(data, group_var, ...)

Grouped summary by the first (categorical) variable:
	•	Numeric variables: group-wise mean, sd, min, median, max
	•	Categorical variables: group-wise frequency and percentage

```r
st_crosstab(mtcars, cyl, mpg, gear)
```


## Example Output

```r
st_tab(mtcars, mpg, gear)

# A tibble:
#   Variable Category Frequency Percent
#   <chr>    <dbl>        <int>   <dbl>
# 1 gear     3               15    46.9
# 2 gear     4               12    37.5
# 3 gear     5                5    15.6
```

```r
st_crosstab(mtcars, cyl, mpg)

# A tibble:
#   Variable cyl  Mean   SD   Min Median  Max
#   <chr>    <dbl> <dbl> <dbl> <dbl>  <dbl> <dbl>
# 1 mpg         4  26.7   4.51  21.5   26    33.9
# 2 mpg         6  19.7   1.45  17.8   19.7  21.4
# 3 mpg         8  15.1   2.56  10.4   15.2  19.2
```

License

MIT License 

⸻

Author

Developed by [Derick S. Park]
GitHub: https://github.com/derickspark

