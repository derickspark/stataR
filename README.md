# stataR

[![R build status](https://github.com/yourusername/stataR/workflows/R-CMD-check/badge.svg)](https://github.com/yourusername/stataR/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Overview

**stataR**은 STATA스타일의 기초통계 명령을 R에서 유사하게 구현하도록 만들어진 명령어입니다. TIDYVERSE 문법과 호환됩니다.

**stataR** is a lightweight R package that provides **Stata-style tabulation tools** using tidyverse syntax.  

두 개의 명령어를 사용하실 수 있습니다. 
It includes two main functions:

- `st_tab()`: 변수하나 또는 여러 개에 대한 요약 통계량을 보여주는 명령입니다. 연속형 변수는 평균/표준편차/최소/최대/중간값을 출력하고, 범주형 변수는 빈도와 비중을 출력합니다.
- `st_tab()`: Summarize one or more variables (frequencies for categorical, statistics for numeric).
- `st_crosstab()`: 주어진 범주형 변수에 대한 교차표를 출력합니다. 대상 변수가 범주형이면 빈도와 비중을, 연속형 변수면 평균/표준편차/최소/최대/중간값을 출력합니다. 
- `st_crosstab()`: Grouped summary by a categorical variable, supporting both continuous and categorical targets.

This is useful for quick descriptive statistics and reporting, especially for users familiar with Stata's `tabulate` and `table` commands.

---

## 설치 Installation
아래 명령으로 설치하실 수 있습니다 
You can install the development version from GitHub:

```r
# install.packages("remotes")
remotes::install_github("yourusername/stataR")
```

## 사용법 Usage

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


## 결과 예시 Example Output

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

