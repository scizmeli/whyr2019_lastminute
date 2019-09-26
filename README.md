# whyr2019_lastminute

## Data prep
1. `read.csv` {places,popular_times_1,popular_times_2}.csv with `as.is=TRUE`
2. concatenate the two popular_times* files with `rbind` to variabble `pop`
3. saved `places` and `pop` as Rdata with `save()`

## Project outline
1. offer choice of `type` from available list, show corresponding locations on Warsaw map
2. for selected type extract popularity info where available
3. add popularity info to map as
   - graphical attribute
   - pop-up panel with specifics (e.g. plot of popularity over time)
4. add-ons
   - ratings to better decide
   - time slider to allow fur future planing
   
