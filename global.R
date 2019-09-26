if (!exists("places")){
  message("Reading places.Rda")
  load("places.Rda")
}

if (!exists("pop")){
  message("Reading pop.Rda")
  load("pop.Rda")
}
source("codeBP.R")

if (0) { #(!any(grepl("data", ls()))){
  message("Running recommendation engine")
  source("recommendation.R")
}
