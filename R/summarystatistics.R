#' @title Summary Statistics
#'
#' @description This function computes five summary statistics (minimum, maximum, mean, and two quantiles) of a numerical variable across the groups of a categorical variable. The function also produces a simple boxplot that allows for visual comparison between the distributions of the numerical variable across the different groups of the categorical variable.
#'
#' @param data A data frame that includes the columns of interest. The input for this argument must be an object of class data.frame. The parameter name is based on the input requirement.
#' @param categoric_var A categorical variable with a factor or character class. The parameter name reflects the input requirement. The summary statistics are calculated across the different groups of this variable.
#' @param numeric_var A variable with a class of numeric. The parameter name is based on the input requirement. The summary statistics are computed for this variable.
#' @param prob1 A numeric value between 0 and 1 that determines the percentile used for the first quantile. The default is set to prob1 = 0.25, representing the first quartile.
#' @param prob2 A numeric value between 0 and 1 that determines the percentile used for the second quantile. The default is set to prob2 = 0.75, representing the third quartile.
#' @param na.rm A logical value that specifies if NA values should be removed before the calculation. The default is set to na.rm = TRUE.
#'
#' @return A list with the following two items:
#' \itemize{
#'    \item A tibble with the following columns: the name of the categorical variable, minimum, maximum, mean, quantile_1, and quantile_2. Each row holds the summary statistics for a specific group of the categorical variable.
#'    \item A simple ggplot boxplot that summarizes the distributions of the numerical variable across the groups of the categorical variable. The boxplot shows the minimum, first quartile, median, third quartile, and maximum values of the numerical variable for each group of the categorical variable.
#' }
#'
#'@examples
#'summarize_stats(data = datateachr::vancouver_trees,
#'                categoric_var = root_barrier,
#'                numeric_var = diameter)
#'
#'summarize_stats(data = datateachr::vancouver_trees,
#'                categoric_var = root_barrier,
#'                numeric_var = diameter,
#'                prob1 = 0.1,
#'                prob2 = 0.9)
#'
#'summarize_stats(data = gapminder::gapminder,
#'                categoric_var = continent,
#'                numeric_var = lifeExp,
#'                prob1 = 0.2,
#'                prob2 = 0.8)
#'
#' @export

summarize_stats <- function(data, categoric_var, numeric_var, prob1 = 0.25, prob2 = 0.75, na.rm = TRUE) {

  x <- eval(substitute(categoric_var), data)
  y <- eval(substitute(numeric_var), data)

  # create custom error messages for incorrect arguments
  if (!is.data.frame(data)) {
    stop('The parameter data requires a data frame input.\n',
         'You have provided an object of class: ', class(data))
  }
  if (!(is.factor(x) || is.character(x))) {
    stop('The parameter categoric_var requires a character or factor variable.\n',
         'You have input a variable of class: ', class(x))
  }
  if (!is.numeric(y)) {
    stop('The parameter numeric_var requires a numerical variable.\n',
         'You have input a variable of class: ', class(y))
  }

  # generate a simple boxplot
  box_plot <- data %>%
    tidyr::drop_na({{ categoric_var }}, {{ numeric_var }}) %>%
    ggplot2::ggplot(ggplot2::aes({{ categoric_var }}, {{ numeric_var }})) +
    ggplot2::geom_boxplot() +
    ggplot2::theme_minimal()

  # create a tibble of summary statistics
  summary_tibble <- data %>%
    dplyr::group_by({{ categoric_var }}) %>%
    dplyr::summarise(minimum = min({{ numeric_var }}, na.rm = na.rm),
              maximum = max({{ numeric_var }}, na.rm = na.rm),
              mean = mean({{ numeric_var }}, na.rm = na.rm),
              quantile_1 = stats::quantile({{ numeric_var }}, probs = prob1 , na.rm = na.rm),
              quantile_2 = stats::quantile({{ numeric_var }}, probs = prob2, na.rm = na.rm))

  output <- list(summary_tibble, box_plot) # create a list object to combine the summary tibble and boxplot
  return(output)
}
