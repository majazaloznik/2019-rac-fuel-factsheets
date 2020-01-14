# =========================================================================== #
# 3. Preform necessary calculations                                           #
# =========================================================================== #

# --------------------------------------------------------------------------- #
# Average UK pump prices ---------------------------------------------------- #
# --------------------------------------------------------------------------- #

# 1 date 
date <- pump.prices[1,1]

# 2 petrol price
pump.prices %>% 
  filter(Date == date) %>% 
  pull(Petrol) -> current.pr.p

# price previous week  
pump.prices %>% 
  filter(Date >= date - 7) %>% 
  filter(row_number() == nrow(.)) %>% 
  pull(Petrol) -> last.week.pr.p

# difference since last week
lw.dif.pr.p <- current.pr.p - last.week.pr.p

# 3 text change since last week.
lw.text.pr.p <- ifelse(lw.dif.pr.p > 0, 
                     paste0("up ", FunDec(lw.dif.pr.p, 2),
                            "p since last week"), 
                     ifelse( lw.dif.pr.p < 0, 
                             paste0("down ", 
                                    FunDec(lw.dif.pr.p, 2),
                                    "p since last week"), 
                             "No change since last week"))

# 4 diesel price
pump.prices %>% 
  filter(Date == date) %>% 
  pull(Diesel) -> current.pr.d

# price previous week  
pump.prices %>% 
  filter(Date >= date - 7) %>% 
  filter(row_number() == nrow(.)) %>% 
  pull(Diesel) -> last.week.pr.d

# difference since last week
lw.dif.pr.d <- current.pr.d - last.week.pr.d

# 5 text change since last week.
lw.text.pr.d <- ifelse(lw.dif.pr.d > 0, 
                     paste0("up ", FunDec(lw.dif.pr.d, 2), 
                            "p since last week"), 
                     ifelse(lw.dif.pr.d < 0, 
                            paste0("down ", 
                                   FunDec(lw.dif.pr.d, 2),
                                   "p since last week"), 
                            "No change since last week"))


# --------------------------------------------------------------------------- #
# Breakdown of average UK pump prices --------------------------------------- #
# --------------------------------------------------------------------------- #

# 6 petrol price = same as 2

# 7 vat paid
vat.rate.p <- last(taxes$Petrol.VAT)

vat.paid.p <- current.pr.p * vat.rate.p / (100 + vat.rate.p)

# 8 vat as prop of price
vat.prop.p <- 100 * vat.rate.p / (100 + vat.rate.p)

# 9 fuel duty paid
duty.paid.p <- last(taxes$Petrol.Duty)

# 10 fueld duty as prop of price
duty.prop.p <- 100 * duty.paid.p / (current.pr.p)

# 11 remaining cost (non-tax)
non.tax.cost.p <- current.pr.p - duty.paid.p - vat.paid.p

# 12. remaining cost as prop of price
non.tax.prop.p <- 100 * non.tax.cost.p / current.pr.p

# 13 tax as prop of price
tax.prop.p <- 100 - non.tax.prop.p

# 14 diesel price = same as 4

# 15 vat paid
vat.rate.d <- last(taxes$Diesel.VAT)
vat.paid.d <- current.pr.d * vat.rate.d / (100 + vat.rate.d)

# 16 vat as prop of price
vat.prop.d <- 100 * vat.rate.d / (100 + vat.rate.d)

# 17 fuel duty paid
duty.paid.d <- last(taxes$Diesel.Duty)

# 18 fueld duty as prop of price
duty.prop.d <- 100 * duty.paid.d / (current.pr.d)

# 19 remaining cost (non-tax)
non.tax.cost.d <- current.pr.d - duty.paid.d - vat.paid.d

# 20. remaining cost as prop of price
non.tax.prop.d <- 100 * non.tax.cost.d / current.pr.d

# 21 tax as prop of price
tax.prop.d <- 100 - non.tax.prop.d


# --------------------------------------------------------------------------- #
# Cost to fill up an average car at the pumps in the UK --------------------- #
# --------------------------------------------------------------------------- #

# 22 average petrol tank
tank.p <- current.pr.p * 55 / 100

# 23 average diesel tank
tank.d <- current.pr.d * 55 / 100

# price previous month  
pump.prices %>% 
  filter(Date <= date %m-% months(1)) %>% 
  filter(row_number() == 1) %>% 
  pull(Petrol) -> last.month.pr.p

# 24 average petrol tank a month ago
tank.last.month.p <- last.month.pr.p * 55 / 100

# price previous month  
pump.prices %>% 
  filter(Date <= date %m-% months(1)) %>% 
  filter(row_number() == 1) %>% 
  pull(Diesel) -> last.month.pr.d

# 25 average diesel tank a month ago
tank.last.month.d <- last.month.pr.d * 55 / 100

# price six months ago  
pump.prices %>% 
  filter(Date <= (date) %m-% months(6)) %>% 
  filter(row_number() == 1) %>% 
  pull(Petrol) -> six.month.pr.p

# 26 average petrol tank a month ago
tank.six.month.p <- six.month.pr.p * 55 / 100

# price six months ago  
pump.prices %>% 
  filter(Date <= (date) %m-% months(6)) %>% 
  filter(row_number() == 1) %>% 
  pull(Diesel) -> six.month.pr.d

# 27 average petrol tank a month ago
tank.six.month.d <- six.month.pr.d * 55 / 100

# 12 month low
pump.prices %>% 
  filter(Petrol == min(Petrol)) %>% 
  mutate(tank = Petrol * 55 /100) -> year.min.p

# 28 12-month low as text

paste0("£", FunDec(year.min.p$tank, 2), " (",
       day(year.min.p$Date), " ", 
       month(year.min.p$Date, label=TRUE, abbr=FALSE), " ",
       year(year.min.p$Date), ")") -> year.min.tank.p

# 12 month low
pump.prices %>% 
  filter(Diesel == min(Diesel)) %>% 
  mutate(tank = Diesel * 55 /100)-> year.min.d

# 29 12-month low as text
paste0("£",FunDec(year.min.d$tank, 2), " (", 
       day(year.min.d$Date), " ", 
       month(year.min.d$Date, label=TRUE, abbr=FALSE), " ",
       year(year.min.d$Date), ")") -> year.min.tank.d

# --------------------------------------------------------------------------- #
# Fuel price over the last 12 months ---------------------------------------- #
# --------------------------------------------------------------------------- #

# 12 month high diesel
pump.prices %>% 
  filter(Diesel == max(Diesel)) -> year.max.d

# 30 12-month diesel high as text
paste0("12 month high ", FunDec(year.max.d$Diesel, 2), "p (", 
       day(year.max.d$Date), " ", 
       month(year.max.d$Date, label=TRUE, abbr=FALSE), " ",
       year(year.max.d$Date), ")") -> year.max.text.d

# 31 12-month diesel low as text for chart
paste0("12 month low ", FunDec(year.min.d$Diesel, 2), "p (", 
       day(year.min.d$Date), " ", 
       month(year.min.d$Date, label=TRUE, abbr=FALSE), " ",
       year(year.min.d$Date), ")") -> year.min.text.d

# 12 month high petrol
pump.prices %>% 
  filter(Petrol == max(Petrol)) -> year.max.p

# 32 12-month petrol high as text
paste0("12 month high ", FunDec(year.max.p$Petrol, 2), "p (", 
       day(year.max.p$Date), " ", 
       month(year.max.p$Date, label=TRUE, abbr=FALSE), " ",
       year(year.max.p$Date), ")") -> year.max.text.p

# 33 12-month petrol low as text for chart
paste0("12 month low ", FunDec(year.min.d$Petrol, 2), "p (", 
       day(year.min.p$Date), " ", 
       month(year.min.p$Date, label=TRUE, abbr=FALSE), " ",
       year(year.min.p$Date), ")") -> year.min.text.p

# 34 rest of chart - 12 month prices

pump.prices
 
















# =========================================================================== #
# test                                                                        #
# =========================================================================== #

test03 <- run_test_file(here::here("code/tests/test-03.R"))

