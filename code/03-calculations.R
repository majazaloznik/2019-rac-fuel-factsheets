# =========================================================================== #
# 3. Preform necessary calculations                                           #
# =========================================================================== #

# Average UK pump prices ---------------------------------------------------- #

# 1 date 

date <- pull(pump.prices[1,1])

# 2 petrol price

pump.prices %>% 
  filter(Date == date) %>% 
  pull(Petrol) -> pp.current

# price previous week  
pump.prices %>% 
  filter(Date >= date - 7) %>% 
  filter(row_number() == nrow(.)) %>% 
  pull(Petrol) -> pp.last.week

# difference since last week

pp.lw.dif <- pp.current - pp.last.week

# 3. text change since last week.

pp.lw.text <- ifelse(pp.lw.dif > 0, 
                     paste0("up ", pp.lw.dif, "p since last week"), 
                     ifelse( pp.lw.dif < 0, 
                             paste0("down ", pp.lw.dif, "p since last week"), 
                             "No change since last week"))

# 4 diesel price

pump.prices %>% 
  filter(Date == date) %>% 
  pull(Diesel) -> dp.current

# price previous week  
pump.prices %>% 
  filter(Date >= date - 7) %>% 
  filter(row_number() == nrow(.)) %>% 
  pull(Diesel) -> dp.last.week

# difference since last week

dp.lw.dif <- dp.current - dp.last.week

# 5 text change since last week.

dp.lw.text <- ifelse(dp.lw.dif > 0, 
                     paste0("up ", dp.lw.dif, "p since last week"), 
                     ifelse(dp.lw.dif < 0, 
                            paste0("down ", dp.lw.dif, "p since last week"), 
                            "No change since last week"))



# =========================================================================== #
# test                                                                        #
# =========================================================================== #

test03 <- run_test_file(here::here("code/tests/test-03.R"))

