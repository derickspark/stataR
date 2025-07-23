#' Stata-style One-way Summary Table
#'
#' @description Automatically summarizes a list of variables.
#' Categorical variables show frequency and percentage; numeric variables show mean, sd, min, median, max.
#'
#' @param data A data.frame or tibble
#' @param ... Unquoted variable names to summarize
#' @return A tibble with summary per variable
#' @export
stata_tab <- function(data, ...) {
  vars <- rlang::enquos(...)
  num_summary <- list()

  for (var in vars) {
    var_name <- rlang::quo_name(var)
    v <- dplyr::pull(data, !!var)

    if (is.numeric(v) && dplyr::n_distinct(v, na.rm = TRUE) > 10) {
      stats <- c(
        Mean = mean(v, na.rm = TRUE),
        SD = sd(v, na.rm = TRUE),
        Min = min(v, na.rm = TRUE),
        Median = median(v, na.rm = TRUE),
        Max = max(v, na.rm = TRUE)
      )
      num_summary[[var_name]] <- tibble::tibble(
        Variable = var_name,
        t(stats)
      )
    } else {
      tbl <- table(v, useNA = "ifany")
      pct <- prop.table(tbl) * 100
      result <- tibble::tibble(
        Variable = var_name,
        Category = names(tbl),
        Frequency = as.integer(tbl),
        Percent = round(pct, 1)
      )
      num_summary[[var_name]] <- result
    }
  }

  tibble::as_tibble(dplyr::bind_rows(num_summary))
}
