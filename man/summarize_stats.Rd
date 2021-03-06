% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summarystatistics.R
\name{summarize_stats}
\alias{summarize_stats}
\title{Summary Statistics}
\usage{
summarize_stats(
  data,
  categoric_var,
  numeric_var,
  prob1 = 0.25,
  prob2 = 0.75,
  na.rm = TRUE
)
}
\arguments{
\item{data}{A data frame that includes the columns of interest. The input for this argument must be an object of class data.frame. The parameter name is based on the input requirement.}

\item{categoric_var}{A categorical variable with a factor or character class. The parameter name reflects the input requirement. The summary statistics are calculated across the different groups of this variable.}

\item{numeric_var}{A variable with a class of numeric. The parameter name is based on the input requirement. The five summary statistics are computed for this variable.}

\item{prob1}{A numeric value between 0 and 1 that determines the probability used for the first quantile. The default is set to prob1 = 0.25, representing the first quartile.}

\item{prob2}{A numeric value between 0 and 1 that determines the probability used for the second quantile. The default is set to prob2 = 0.75, representing the third quartile.}

\item{na.rm}{A logical value that specifies if NA values should be removed before the calculation. The default is set to na.rm = TRUE.}
}
\value{
A list with the following two items:
\itemize{
\item A tibble with the following columns: the name of the categorical variable, minimum, maximum, mean, quantile_1, and quantile_2. Each row holds the summary statistics for a specific group of the categorical variable.
\item A simple set of boxplots that summarize the distributions of the numerical variable across the groups of the categorical variable.
}
}
\description{
The function computes five summary statistics (minimum, maximum, mean, and two quantiles) of a numerical variable across the groups of a categorical variable. The function also produces a simple set of boxplots that allows for the visual comparison of distributions between the groups of the categorical variable.
}
\examples{
summarize_stats(data = datateachr::vancouver_trees,
               categoric_var = root_barrier,
               numeric_var = diameter)

summarize_stats(data = gapminder::gapminder,
               categoric_var = continent,
               numeric_var = lifeExp,
               prob1 = 0.1,
               prob2 = 0.9)

summarize_stats(data = palmerpenguins::penguins,
               categoric_var = species,
               numeric_var = flipper_length_mm,
               prob1 = 0.2,
               prob2 = 0.8)

}
