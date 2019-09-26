# code for WhyR? 2019  hackathon
# 
# Benno Pütz
# 


#' list of availabble type in \code{table}
#'
#' @param table data.frame with location  data
#' @param ... 
#'
#' @return list of available types (actually a vector of chr)
#' @export
#' @author Benno Pütz \email{puetz@@psych.mpg.de}
#'
type.list <- function(table = places, ...){
  return(unique(table$type))
}