# =========================================================================== #
# 4. Prepare all required data for export                                     #
# =========================================================================== #


# --------------------------------------------------------------------------- #
# Average UK pump prices ---------------------------------------------------- #
# --------------------------------------------------------------------------- #

# initialise empty dataframe
tab01 <- data.frame(id = numeric(),
                     description = character(),
                     value = character())
# 1 date 
tab01 %>% 
  bind_rows(list(id = 1, 
                 description = "date", 
                 value = as.character(date))) -> tab01

# 2 petrol price
tab01 %>% 
  bind_rows(list(id = 2, 
                 description = "current petrol price", 
                 value = as.character(current.pr.p))) -> tab01

# 3 text change since last week.
tab01 %>% 
  bind_rows(list(id = 3, 
                 description = "change in petrol price since last week (txt)", 
                 value = lw.text.pr.p)) -> tab01

# 4 diesel price
tab01 %>% 
  bind_rows(list(id = 4, 
                 description = "current diesel price", 
                 value = as.character(current.pr.d))) -> tab01

# 5 text change since last week.
tab01 %>% 
  bind_rows(list(id = 5, 
                 description = "change in dieselprice since last week (txt)", 
                 value = lw.text.pr.d)) -> tab01

# --------------------------------------------------------------------------- #
# Breakdown of average UK pump prices --------------------------------------- #
# --------------------------------------------------------------------------- #

# initialise empty dataframe
tab02 <- data.frame(id = numeric(),
                    description = character(),
                    value = character())

# 6 petrol price = same as 2
tab02 %>% 
  bind_rows(list(id = 6, 
                 description = "current petrol price", 
                 value = as.character(current.pr.p))) -> tab02

# 7 vat paid
tab02 %>% 
  bind_rows(list(id = 7, 
                 description = "VAT paid on petrol (p)", 
                 value = as.character(FunDec(vat.paid.p,2)))) -> tab02

# 8 vat as prop of price
tab02 %>% 
  bind_rows(list(id = 8, 
                 description = "VAT paid on petrol (as % of total price)", 
                 value = as.character(FunDec(vat.prop.p,2)))) -> tab02

# 9 fuel duty paid
tab02 %>% 
  bind_rows(list(id = 9, 
                 description = "Fuel Duty on petrol (p)", 
                 value = as.character(FunDec(duty.paid.p,2)))) -> tab02

# 10 fueld duty as prop of price
tab02 %>% 
  bind_rows(list(id = 10, 
                 description = "Fuel Duty on petrol (as % of total price)", 
                 value = as.character(FunDec(duty.prop.p,2)))) -> tab02

# 11 remaining cost (non-tax)
tab02 %>% 
  bind_rows(list(id = 11, 
                 description = paste("Cost of oil, fuel production",
                 "and supply, and profit margin on petrol (p)"), 
                 value = as.character(FunDec(non.tax.cost.p,2)))) -> tab02

# 12. remaining cost as prop of price
tab02 %>% 
  bind_rows(list(id = 12, 
                 description = "Cost of oil etc. on petrol (as % of total price)", 
                 value = as.character(FunDec(non.tax.prop.p,2)))) -> tab02


# 13 tax as prop of price
tab02 %>% 
  bind_rows(list(id = 13, 
                 description = "% of petrol price which is tax", 
                 value = as.character(FunDec(tax.prop.p,2)))) -> tab02

# 14 diesel price = same as 4
tab02 %>% 
  bind_rows(list(id = 14, 
                 description = "current diesel price", 
                 value = as.character(current.pr.d))) -> tab02

# 15 vat paid
tab02 %>% 
  bind_rows(list(id = 15, 
                 description = "VAT paid on diesel (p)", 
                 value = as.character(FunDec(vat.paid.d,2)))) -> tab02


# 16 vat as prop of price
tab02 %>% 
  bind_rows(list(id = 16, 
                 description = "VAT paid on diesel (as % of total price)", 
                 value = as.character(FunDec(vat.prop.d,2)))) -> tab02

# 17 fuel duty paid
tab02 %>% 
  bind_rows(list(id = 17, 
                 description = "Fuel Duty on diesel (p)", 
                 value = as.character(FunDec(duty.paid.d,2)))) -> tab02


# 18 fuel duty as prop of price
tab02 %>% 
  bind_rows(list(id = 18, 
                 description = "Fuel Duty on diesel (as % of total price)", 
                 value = as.character(FunDec(duty.prop.d,2)))) -> tab02

# 19 remaining cost (non-tax)
tab02 %>% 
  bind_rows(list(id = 19, 
                 description = paste("Cost of oil, fuel production",
                                     "and supply, and profit margin on diesel (p)"), 
                 value = as.character(FunDec(non.tax.cost.d,2)))) -> tab02

# 20. remaining cost as prop of price
tab02 %>% 
  bind_rows(list(id = 20, 
                 description = "Cost of oil etc. on diesel (as % of total price)", 
                 value = as.character(FunDec(non.tax.prop.d,2)))) -> tab02

# 21 tax as prop of price
tab02 %>% 
  bind_rows(list(id = 21, 
                 description = "% of diesel price which is tax", 
                 value = as.character(FunDec(tax.prop.d,2)))) -> tab02

# --------------------------------------------------------------------------- #
# Cost to fill up an average car at the pumps in the UK --------------------- #
# --------------------------------------------------------------------------- #

# initialise empty dataframe
tab03 <- data.frame(id = numeric(),
                    description = character(),
                    value = character())


# 22 average petrol tank
tab03 %>% 
  bind_rows(list(id = 22, 
                 description = "cost of filling average petrol tank today (£)", 
                 value = as.character(FunDec(tank.p ,2)))) -> tab03

# 23 average diesel tank
tab03 %>% 
  bind_rows(list(id = 23, 
                 description = "cost of filling average diesel tank today (£)", 
                 value = as.character(FunDec(tank.d ,2)))) -> tab03

# 24 average petrol tank a month ago
tab03 %>% 
  bind_rows(list(id = 24, 
                 description = "cost of filling average petrol tank last month (£)", 
                 value = as.character(FunDec(tank.last.month.p ,2)))) -> tab03

# 25 average diesel tank a month ago
tab03 %>% 
  bind_rows(list(id = 25, 
                 description = "cost of filling average diesel tank last month (£)", 
                 value = as.character(FunDec(tank.last.month.d ,2)))) -> tab03

# 26 average petrol tank a month ago
tab03 %>% 
  bind_rows(list(id = 26, 
                 description = "cost of filling average petrol tank six months ago (£)", 
                 value = as.character(FunDec(tank.six.month.p ,2)))) -> tab03

# 27 average petrol tank a month ago
tab03 %>% 
  bind_rows(list(id = 27, 
                 description = "cost of filling average diesel tank six months ago (£)", 
                 value = as.character(FunDec(tank.six.month.d ,2)))) -> tab03

# 28 12-month low as text
tab03 %>% 
  bind_rows(list(id = 28, 
                 description = "cost of filling average petrol tank  at12-month low (text)", 
                 value = year.min.tank.p)) -> tab03

# 29 12-month low as text
tab03 %>% 
  bind_rows(list(id = 29, 
                 description = "cost of filling average diesel tank at 12-month low (text)", 
                 value = year.min.tank.d)) -> tab03

# --------------------------------------------------------------------------- #
# Fuel price over the last 12 months ---------------------------------------- #
# --------------------------------------------------------------------------- #
# initialise empty dataframe
tab04 <- data.frame(id = numeric(),
                    description = character(),
                    value = character())


# 30 12-month diesel high as text
tab04 %>% 
  bind_rows(list(id = 30, 
                 description = "12 month diesel high price (text)", 
                 value = as.character(year.max.text.d))) -> tab04

# 31 12-month diesel low as text for chart
tab04 %>% 
  bind_rows(list(id = 31, 
                 description = "12 month diesel low price (text)", 
                 value = as.character(year.min.text.d))) -> tab04

# 32 12-month petrol high as text
tab04 %>% 
  bind_rows(list(id = 32, 
                 description = "12 month petrol high price (text)", 
                 value = as.character(year.max.text.p))) -> tab04

# 33 12-month diesel low as text for chart
tab04 %>% 
  bind_rows(list(id = 23, 
                 description = "12 month petrol low price (text)", 
                 value = as.character(year.min.text.p))) -> tab04

# 34 rest of chart - 12 month prices

pump.chart <- pump.prices


# --------------------------------------------------------------------------- #
# Oil price over the last 12 months ---------------------------------------- #
# --------------------------------------------------------------------------- #
# initialise empty dataframe
tab06 <- data.frame(id = numeric(),
                    description = character(),
                    value = character())


# 36 12-month brent high as text
tab06 %>% 
  bind_rows(list(id = 36, 
                 description = "12 month Brent high price (text)", 
                 value = as.character(year.max.text.b))) -> tab06

# 37 12-month brent low as text
tab06 %>% 
  bind_rows(list(id = 37, 
                 description = "12 month Brent low price (text)", 
                 value = as.character(year.min.text.b))) -> tab06

# 38 rest of chart - 12 months brent prices 
oil.chart <- select(oil.prices, -GBP.USD.xr) 

# --------------------------------------------------------------------------- #
# Oil price ----------------------------------------------------------------- #
# --------------------------------------------------------------------------- #
tab07 <- data.frame(id = numeric(),
                    description = character(),
                    value = character())

# 39 current price of brent in usd
tab07 %>% 
  bind_rows(list(id = 39, 
                 description = "Current price of Brent oil in USD", 
                 value = as.character(FunDec(current.usd.b, 2)))) -> tab07

# 40 current price of brent in gbp
tab07 %>% 
  bind_rows(list(id = 40, 
                 description = "Current price of Brent oil in GBP", 
                 value = as.character(FunDec(current.gbp.b, 2)))) -> tab07

# 41 change in brent price since previous week txt
tab07 %>% 
  bind_rows(list(id = 41, 
                 description = "Direction of change in Brent price since last week (text)", 
                 value = lw.text.pr.b)) -> tab07

# 42 absolute difference since last week
tab07 %>% 
  bind_rows(list(id = 42, 
                 description = "Absolute difference in Brent price since last week (USD)", 
                 value = as.character(FunDec(lw.adif.pr.b, 2)))) -> tab07

# 43 change in brent price since previous week arrow
tab07 %>% 
  bind_rows(list(id = 43, 
                 description = "Direction of change in Brent price since last week (arrow)", 
                 value = lw.arrow.pr.b)) -> tab07

# 44 change in brent price since previous month txt
tab07 %>% 
  bind_rows(list(id = 44, 
                 description = "Direction of change in Brent price since last month (text)", 
                 value = lm.text.pr.b)) -> tab07

# 45 absolute difference since last month
tab07 %>% 
  bind_rows(list(id = 45, 
                 description = "Absolute difference in Brent price since last month (USD)", 
                 value = as.character(FunDec(lm.adif.pr.b, 2)))) -> tab07

# 46 change in brent price since previous month arrow
tab07 %>% 
  bind_rows(list(id = 46, 
                 description = "Direction of change in Brent price since last month (arrow)", 
                 value = lw.arrow.pr.b)) -> tab07

# 47 change in brent price since previous year txt
tab07 %>% 
  bind_rows(list(id = 47, 
                 description = "Direction of change in Brent price since last year (text)", 
                 value = ly.text.pr.b)) -> tab07

# 48 absolute difference since last year
tab07 %>% 
  bind_rows(list(id = 48,  
                 description = "Absolute difference in Brent price since last year (USD)", 
                 value = as.character(FunDec(ly.adif.pr.b, 2)))) -> tab07

# 49 change in brent price since last year arrow
tab07 %>%
  bind_rows(list(id = 49, 
                 description = "Direction of change in Brent price since last year (arrow)", 
                 value = ly.arrow.pr.b)) -> tab07


# --------------------------------------------------------------------------- #
# UK average pump price change ---------------------------------------------- #
# --------------------------------------------------------------------------- #
tab08 <- data.frame(id = numeric(),
                    description = character(),
                    value = character())

# 50 change in petrol price since previous week txt
tab08 %>%
  bind_rows(list(id = 50, 
                 description = "Direction of change in petrol price since last week (text)", 
                 value = lw.word.pr.p)) -> tab08

# 51 absolute difference since last week
tab08 %>%
  bind_rows(list(id = 51, 
                 description = "Absolute change in petrol price since last week (£)", 
                 value = as.character(FunDec(lw.adif.pr.p, 2)))) -> tab08

# 52 change in petrol price since previous week arrow
tab08 %>%
  bind_rows(list(id = 52, 
                 description = "Direction of change in petrol price since last week (arrow)", 
                 value = lw.arrow.pr.p)) -> tab08

# 53 change in petrol price since previous month text
tab08 %>%
  bind_rows(list(id = 53, 
                 description = "Direction of change in petrol price since last month (text)", 
                 value = lm.word.pr.p)) -> tab08

# 54 absolute difference since last month
tab08 %>%
  bind_rows(list(id = 54, 
                 description = "Absolute change in petrol price since last month (£)", 
                 value = as.character(FunDec(lm.adif.pr.p, 2)))) -> tab08

# 55 change in petrol price since previous month arrow
tab08 %>%
  bind_rows(list(id = 55, 
                 description = "Direction of change in petrol price since month week (arrow)", 
                 value = lm.arrow.pr.p)) -> tab08

# 56 change in petrol price since previous year txt
tab08 %>%
  bind_rows(list(id = 56, 
                 description = "Direction of change in petrol price since last year (text)", 
                 value = ly.word.pr.p)) -> tab08

# 57 absolute difference since last year
tab08 %>%
  bind_rows(list(id = 57, 
                 description = "Absolute change in petrol price since last year (£)", 
                 value = as.character(FunDec(ly.adif.pr.p, 2)))) -> tab08

# 58 change in petrol price since previous year arrow
tab08 %>%
  bind_rows(list(id = 58, 
                 description = "Direction of change in petrol price since month year (arrow)", 
                 value = ly.arrow.pr.p)) -> tab08

# 59 change in diesel price since previous week txt
tab08 %>%
  bind_rows(list(id = 59, 
                 description = "Direction of change in diesel price since last week (text)", 
                 value = lw.word.pr.d)) -> tab08

# 60 absolute difference since last week
tab08 %>%
  bind_rows(list(id = 60, 
                 description = "Absolute change in  diesel since last week (£)", 
                 value = as.character(FunDec(lw.adif.pr.d, 2)))) -> tab08

# 61 change in diesel price since previous week arrow
tab08 %>%
  bind_rows(list(id = 61, 
                 description = "Direction of change in diesel since last week (arrow)", 
                 value = lw.arrow.pr.d)) -> tab08

# 62 change in diesel price since previous month 
tab08 %>%
  bind_rows(list(id = 62, 
                 description = "Direction of change in diesel price since last month (text)", 
                 value = lm.word.pr.d)) -> tab08

# 63 absolute difference since last month
tab08 %>%
  bind_rows(list(id = 63, 
                 description = "Absolute change in diesel price since last month (£)", 
                 value = as.character(FunDec(lm.adif.pr.d, 2)))) -> tab08

# 64 change in diesel price since previous month arrow
tab08 %>%
  bind_rows(list(id = 64, 
                 description = "Direction of change in diesel price since month week (arrow)", 
                 value = lm.arrow.pr.d)) -> tab08

# 65 change in diesel since previous year txt
tab08 %>%
  bind_rows(list(id = 65, 
                 description = "Direction of change in diesel price since last year (text)", 
                 value = ly.word.pr.d)) -> tab08


# 66 absolute difference since last year
tab08 %>%
  bind_rows(list(id = 66, 
                 description = "Absolute change in diesel price since last year (£)", 
                 value = as.character(FunDec(ly.adif.pr.d, 2)))) -> tab08

# 67 change in petrol price since previous year arrow
tab08 %>%
  bind_rows(list(id = 67, 
                 description = "Direction of change in diesel price since month year (arrow)", 
                 value = ly.arrow.pr.d)) -> tab08


# --------------------------------------------------------------------------- #
# UK vs EU pretax ----------------------------------------------------------- #
# --------------------------------------------------------------------------- #

tab09 <- data.frame(id = numeric(),
                    description = character(),
                    value = character())

#  68 pretax petrol ranking 
tab09 %>%
  bind_rows(list(id = 68, 
                 description = "UK ranking in EU by pre-tax petrol price", 
                 value = pre.t.rank.p)) -> tab09

#  69 pretax petrol ranking 
tab09 %>%
  bind_rows(list(id = 69, 
                 description = "UK ranking in EU by pre-tax diesel price", 
                 value = pre.t.rank.d)) -> tab09

# --------------------------------------------------------------------------- #
# UK vs EU fuel ------------------------------------------------------------- #
# --------------------------------------------------------------------------- #

# 70 & 71 & 72 & 73 petrol ranking
eu.p %>% 
  arrange(desc(retail.p))  -> eu.rank.p

# 704, 75, 76, 77 diesel ranking
eu.d %>% 
  arrange(desc(retail.d)) ->  eu.rank.d


# =========================================================================== #
# 5. Export                                                                   #
# =========================================================================== #

# bind all  together
bind_rows(tab01,
          tab02,
          tab03,
          tab04,
          tab06,
          tab07,
          tab08,
          tab09) -> master

# export as csv
write_csv(master, "data/processed/master.csv")
write_csv(pump.chart, "data/processed/pump.chart.csv")
write_csv(oil.chart, "data/processed/oil.chart.csv")
write_csv(eu.rank.p, "data/processed/eu.rank.p.csv")
write_csv(eu.rank.d, "data/processed/eu.rank.d.csv")



# =========================================================================== #
# test                                                                        #
# =========================================================================== #

test04 <- run_test_file(here::here("code/tests/test-04.R"))

