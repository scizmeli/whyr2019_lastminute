# code for WhyR? 2019  hackathon
# 
# Benno Pütz
# 

lu <- function(x){
  length(unique(x))
}
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

#' Rating for place_id given type
#'
#' @param place_id 
#' @param type 
#' @param table 
#' @param ... unused
#'
#' @return
#' @export
#'
#' @examples
rating <- function(place_id,
                   type,
                   table = places,
                   ...){
  ratings <- table[table$place_id == place_id & 
                     table$type == type,
                   "rating"]
  if(length(ratings) > 1 & !is.na(sd(ratings, na.rm=TRUE)) & sd(ratings, na.rm=TRUE) != 0){
    warning('ratings from ', min(ratings), ' to ', max(ratings))
  }
  return(mean(ratings))
}

places4type <- function(type,
                        table = places, 
                        ...){
  return(unique(unlist(table[table$type == type, 'place_id'])))
}

#' extract all ratings for given  type
#'
#' default relies on `places` present on search path
#' 
#' @param type type to rate
#' @param table 
#' @param ... unused
#'
#' @return
#' @export

#'
#' @examples
ratings.for.type <- function(mytype,
                             table = places,
                             ...){
  type.places <- places4type(mytype,
                             table,
                             ...)
  sapply(places, rating, type = mytype)
}

#' plot average occupancy by day/hour
#'
#' default relies on `pop` present on search path
#' 
#' @param place_id 
#' @param type type [optional]
#' @param table 
#' @param ... 
#'
#' @return
#' @export
#'
#' @examples
occ.plot <- function(place_id, 
                     type = NULL, 
                     table = pop,
                     ...){
  if(place_id %in% pop$place_id){
    if(is.null(type)){
      place.data <- table[table$place_id == place_id,]
    } else {
      place.data <- table[table$place_id == place_id &
                            table$type == type, ]
    }
    new.day <- c(0,
                 which(diff(as.numeric(factor(place.data$day))) != 0) - .5,
                 nrow(place.data))
    x <- 1:nrow(place.data)
    plot(place.data$occupancy_index,
         axes = FALSE,
         xlab = '', 
         ylab = 'occupancy',
         type = 'n',
         xaxs = 'i',
         yaxs = 'i'
    )
    pu <- par('usr')
    rect(new.day[-length(new.day)], pu[3], new.day[-1], pu[4], col = c('#0000ff20','#0000ff10'), border = '#0000ff60')
    points(place.data$occupancy_index,
         xlab = '', 
         ylab = 'occupancy',
    )
    axis(2,
         las = 2)
    axis(1, 
         at = x,
         labels = place.data$hour)
    box()
    mean.x.day <- tapply(x, place.data$day, mean)
    # omgp <- par('mgp')
    # omgp[3] <- 1
    # opar <- par(mgp = omgp)
    # axis(1, at = mean.x.day,
    #      labels = unique(place.data$day))
    # par(opar)
    ud <- unique(place.data$day)
    text(mean.x.day[ud], -14, ud, xpd = NA)
  } else{
    warning("no popularity data")
  }
}
