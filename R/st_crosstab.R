#' Stata-style Grouped Cross-tabulation Summary (st_crosstab)
#'
#' @description Group a categorical variable and summarize following variables:
#' numeric → mean, sd, min, median, max; 
#' categorical → frequency, percent by group.
#'
#' @param data A data.frame or tibble
#' @param ... First argument is grouping variable, followed by variables to summarize
#' @return A tibble with group-wise summaries
#' @export
st_crosstab <- function(data, ...) {
  vars <- rlang::enquos(...)
  if (length(vars) < 2) stop("At least one grouping variable and one analysis variable are required.")

  group_var <- vars[[1]]
  group_name <- rlang::quo_name(group_var)
  analysis_vars <- vars[-1]

  results <- list()

  for (var in analysis_vars) {
    var_name <- rlang::quo_name(var)
    v <- dplyr::pull(data, !!var)

    if (is.numeric(v) && dplyr::n_distinct(v, na.rm = TRUE) > 10) {
      summary_df <- data %>%
        dplyr::group_by(!!group_var) %>%
        dplyr::summarise(
          Variable = var_name,
          Mean = mean(!!var, na.rm = TRUE),
          SD = sd(!!var, na.rm = TRUE),
          Min = min(!!var, na.rm = TRUE),
          Median = median(!!var, na.rm = TRUE),
          Max = max(!!var, na.rm = TRUE),
          .groups = "drop"
        ) %>%
        dplyr::relocate(Variable, .before = dplyr::everything()) %>%
        tibble::as_tibble()

      results[[var_name]] <- summary_df

    } else {
      cat_df <- data %>%
        dplyr::group_by(!!group_var, !!var) %>%
        dplyr::summarise(Frequency = dplyr::n(), .groups = "drop") %>%
        dplyr::group_by(!!group_var) %>%
        dplyr::mutate(Percent = round(100 * Frequency / sum(Frequency), 1)) %>%
        dplyr::ungroup() %>%
        dplyr::mutate(Variable = var_name) %>%
        dplyr::rename(Category = !!var) %>%
        dplyr::relocate(Variable, .before = dplyr::everything()) %>%
        tibble::as_tibble()

      results[[var_name]] <- cat_df
    }
  }

  tibble::as_tibble(dplyr::bind_rows(results))
}
