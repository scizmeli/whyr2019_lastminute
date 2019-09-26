


library(dplyr)
# load("places.Rda")
# load("pop.Rda")

# unique(places$price_level[!is.na(places$price_level)])
# unique(places$rating[!is.na(places$rating)])
# 
# unique(places$user_ratings_total[!is.na(places$user_ratings_total)])
# min(places$user_ratings_total[!is.na(places$user_ratings_total)])
# max(places$user_ratings_total[!is.na(places$user_ratings_total)])
# mean(places$user_ratings_total[!is.na(places$user_ratings_total)])
# 
# hist(places$rating)
# hist(places$price_level)
# hist(places$rating)
# hist(places$user_ratings_total)
# length(unique(places$user_ratings_total))
# ggplot(places) + geom_histogram(aes(user_ratings_total), binwidth = 500, bins = 1200)

# places <- places %>% mutate(best = ifelse(rating > 2.5 & price_level < 2.0, 1, 0))
# places <- places %>% mutate(best = ifelse(rating > 2.5 & price_level < 2.0, 1, 0))
# 
# unique(places$type)
# 
# try <- places %>% filter(rating > 2.5)
# 
# ggplot(try, aes(type)) + geom_bar(aes(fill = rating)) +
#   theme(axis.text.x = element_text(angle = 65, vjust = 0.9))
# 
# unique(pop$occupancy_text)
# unique(pop$occupancy_index)

# colnames(places)[!colnames(places) %in% colnames(pop)]

places <- places %>% select(name, type, rating, price_level, place_id, lat, lng)
pop <- pop %>% select(occupancy_index, occupancy_text, place_id)

data <- merge(places, pop, by = "place_id")
data <- data %>% mutate(recommendation = ifelse(rating > 2.5 & price_level < 2.0, 1, 0))

# unique(data$occupancy_index)

# mydata %>% filter(occupancy_index > )











