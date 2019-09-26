# code for WhyR? 2019  hackathon
# 
# Benno Pütz
# 


#' list of availabble type in \code{table}
#'
#' default relies on `places` present on search path
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

rating <- function(place_id,
                   type,
                   table = places,
                   ...){
  ratings <- table[table$place_id == place_id & table$type == type, "rating"]
  if(length(ratings) > 1 && sd(ratings) != 0){
    warning('ratings from ',min(ratings), ' to ', 'max(ratings)')
  }
  return(mean(ratings))
}

#' plot average occupancy by day/hour
#'
#' default relies on `pop` present on search path
#' 
#' @param place_id 
#' @param ... 
#'
#' @return
#' @export
#'
#' @examples
occ.plot <- function(place_id, 
                     table = pop,
                     ...){
  if(place_id %in% pop$place_id){
    place.data <- subset(pop, 
                         subset = place_id == place_id)
    x <- 1:nrow(place.data)
    plot(place.data$occupancy_index,
         axes = FALSE
    )
    axis(2)
    axis(1, 
         at = x,
         labels = place.data$hhour)
    mean.x.day <- tapply(x, place.data$day, mean)
    axis(1, at = mean.x.day,
         labels = unique(place.data$day))
  }
}
