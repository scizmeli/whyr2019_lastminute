# code for WhyR? 2019  hackathon
# 
# Benno Pütz
# 
require (lubridate)

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
                     shour = hour(now()),
                     sday = weekdays(now()),
                     type = NULL, 
                     table = pop,
                     p.tbl = places,
                     ...){
  if(place_id %in% pop$place_id){
    days.vector <- c("Monday","Tuesday","Wednesday",
                     "Thursday", "Friday", "Saturday" ,
                     "Sunday")
    if(is.character(sday)){
      sday <- which(tolower(days.vector) == tolower(sday))
    }
    if(is.null(type)){
      place.data <- table[table$place_id == place_id,]
    } else {
      place.data <- table[table$place_id == place_id &
                            table$type == type, ]
    }
    num.day <- as.numeric(ordered(place.data$day,
                                  levels = days.vector))
    new.day <- c(0,
                 which(diff(num.day) != 0) - .5,
                 nrow(place.data))
    x <- 1:nrow(place.data)
    place.name <- paste(p.tbl[p.tbl$place_id == place_id,
                              'name'][1],
                        '   ',
                        p.tbl[p.tbl$place_id == place_id,
                              'vicinity'][1],
                        ifelse(is.null(type), '', paste0('[', type, ']')))
    plot(place.data$occupancy_index,
         axes = FALSE,
         xlab = '', 
         ylab = 'occupancy',
         type = 'n',
         xaxs = 'i',
         yaxs = 'i',
         main = place.name
    )
    pu <- par('usr')
    rect(new.day[-length(new.day)], pu[3], new.day[-1], pu[4], col = c('#0000ff20','#0000ff10'), border = '#0000ff60')
    lines(place.data$occupancy_index,
         xlab = '', 
         ylab = 'occupancy',
    )
    axis(2,
         las = 2)
    axis(1, 
         at = x,
         labels = place.data$hour)
    box()
    if(!(is.null(day) | is.null(hour))){
      use.idx <- which(num.day == sday & place.data$hour == shour)
      abline(v=use.idx,, col = 'red')
    }
    mean.x.day <- tapply(x, place.data$day, mean)
    # omgp <- par('mgp')
    # omgp[3] <- 1
    # opar <- par(mgp = omgp)
    # axis(1, at = mean.x.day,
    #      labels = unique(place.data$day))
    # par(opar)
    ud <- unique(place.data$day)
    text(mean.x.day[ud], -16, substr(ud, 1,3), xpd = NA)
  } else{
    warning("no popularity data")
  }
}
