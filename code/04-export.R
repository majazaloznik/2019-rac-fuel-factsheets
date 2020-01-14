# =========================================================================== #
# 4. Prepare all required data for export                                     #
# =========================================================================== #

# 0 initialise empty dataframe
master <- data.frame(id = numeric(),
                     description = character(),
                     value = character())

# --------------------------------------------------------------------------- #
# Average UK pump prices ---------------------------------------------------- #
# --------------------------------------------------------------------------- #

# 1 date 
master %>% 
  bind_rows(list(id = 1, 
                 description = "date", 
                 value = as.character(date))) -> master

# 2 petrol price
master %>% 
  bind_rows(list(id = 2, 
                 description = "current petrol price", 
                 value = as.character(current.pr.p))) -> master

# 3 text change since last week.
master %>% 
  bind_rows(list(id = 3, 
                 description = "change in petrol price since last week (txt)", 
                 value = lw.text.pr.p)) -> master

# 4 diesel price
master %>% 
  bind_rows(list(id = 4, 
                 description = "current diesel price", 
                 value = as.character(current.pr.d))) -> master

# 5 text change since last week.
master %>% 
  bind_rows(list(id = 5, 
                 description = "change in dieselprice since last week (txt)", 
                 value = lw.text.pr.d)) -> master

# --------------------------------------------------------------------------- #
# Breakdown of average UK pump prices --------------------------------------- #
# --------------------------------------------------------------------------- #

# 6 petrol price = same as 2
master %>% 
  bind_rows(list(id = 6, 
                 description = "current petrol price", 
                 value = as.character(current.pr.p))) -> master

# 7 vat paid
master %>% 
  bind_rows(list(id = 7, 
                 description = "VAT paid on petrol (p)", 
                 value = as.character(FunDec(vat.paid.p,2)))) -> master

# 8 vat as prop of price
master %>% 
  bind_rows(list(id = 8, 
                 description = "VAT paid on petrol (as % of total price)", 
                 value = as.character(FunDec(vat.prop.p,2)))) -> master

# 9 fuel duty paid
master %>% 
  bind_rows(list(id = 9, 
                 description = "Fuel Duty on petrol (p)", 
                 value = as.character(FunDec(duty.paid.p,2)))) -> master

# 10 fueld duty as prop of price
master %>% 
  bind_rows(list(id = 10, 
                 description = "Fuel Duty on petrol (as % of total price)", 
                 value = as.character(FunDec(duty.prop.p,2)))) -> master

# 11 remaining cost (non-tax)
master %>% 
  bind_rows(list(id = 11, 
                 description = paste("Cost of oil, fuel production",
                 "and supply, and profit margin on petrol (p)"), 
                 value = as.character(FunDec(non.tax.cost.p,2)))) -> master

# 12. remaining cost as prop of price
master %>% 
  bind_rows(list(id = 12, 
                 description = "Cost of oil etc. on petrol (as % of total price)", 
                 value = as.character(FunDec(non.tax.prop.p,2)))) -> master


# 13 tax as prop of price
master %>% 
  bind_rows(list(id = 13, 
                 description = "% of petrol price which is tax", 
                 value = as.character(FunDec(tax.prop.p,2)))) -> master

# 14 diesel price = same as 4
master %>% 
  bind_rows(list(id = 14, 
                 description = "current diesel price", 
                 value = as.character(current.pr.d))) -> master

# 15 vat paid
master %>% 
  bind_rows(list(id = 15, 
                 description = "VAT paid on diesel (p)", 
                 value = as.character(FunDec(vat.paid.d,2)))) -> master


# 16 vat as prop of price
master %>% 
  bind_rows(list(id = 16, 
                 description = "VAT paid on diesel (as % of total price)", 
                 value = as.character(FunDec(vat.prop.d,2)))) -> master

# 17 fuel duty paid
master %>% 
  bind_rows(list(id = 17, 
                 description = "Fuel Duty on diesel (p)", 
                 value = as.character(FunDec(duty.paid.d,2)))) -> master


# 18 fuel duty as prop of price
master %>% 
  bind_rows(list(id = 18, 
                 description = "Fuel Duty on diesel (as % of total price)", 
                 value = as.character(FunDec(duty.prop.d,2)))) -> master

# 19 remaining cost (non-tax)
master %>% 
  bind_rows(list(id = 19, 
                 description = paste("Cost of oil, fuel production",
                                     "and supply, and profit margin on diesel (p)"), 
                 value = as.character(FunDec(non.tax.cost.d,2)))) -> master

# 20. remaining cost as prop of price
master %>% 
  bind_rows(list(id = 20, 
                 description = "Cost of oil etc. on diesel (as % of total price)", 
                 value = as.character(FunDec(non.tax.prop.d,2)))) -> master

# 21 tax as prop of price
master %>% 
  bind_rows(list(id = 21, 
                 description = "% of diesel price which is tax", 
                 value = as.character(FunDec(tax.prop.d,2)))) -> master

# --------------------------------------------------------------------------- #
# Cost to fill up an average car at the pumps in the UK --------------------- #
# --------------------------------------------------------------------------- #

# 22 average petrol tank
master %>% 
  bind_rows(list(id = 22, 
                 description = "cost of filling average petrol tank today (£)", 
                 value = as.character(FunDec(tank.p ,2)))) -> master

# 23 average diesel tank
master %>% 
  bind_rows(list(id = 23, 
                 description = "cost of filling average diesel tank today (£)", 
                 value = as.character(FunDec(tank.d ,2)))) -> master

# 24 average petrol tank a month ago
master %>% 
  bind_rows(list(id = 24, 
                 description = "cost of filling average petrol tank last month (£)", 
                 value = as.character(FunDec(tank.last.month.p ,2)))) -> master

# 25 average diesel tank a month ago
master %>% 
  bind_rows(list(id = 25, 
                 description = "cost of filling average diesel tank last month (£)", 
                 value = as.character(FunDec(tank.last.month.d ,2)))) -> master

# 26 average petrol tank a month ago
master %>% 
  bind_rows(list(id = 26, 
                 description = "cost of filling average petrol tank six months ago (£)", 
                 value = as.character(FunDec(tank.six.month.p ,2)))) -> master

# 27 average petrol tank a month ago
master %>% 
  bind_rows(list(id = 27, 
                 description = "cost of filling average diesel tank six months ago (£)", 
                 value = as.character(FunDec(tank.six.month.d ,2)))) -> master

# 28 12-month low as text
master %>% 
  bind_rows(list(id = 28, 
                 description = "cost of filling average petrol tank  at12-month low (text)", 
                 value = year.min.tank.p)) -> master

# 29 12-month low as text
master %>% 
  bind_rows(list(id = 29, 
                 description = "cost of filling average diesel tank at 12-month low (text)", 
                 value = year.min.tank.d)) -> master

# --------------------------------------------------------------------------- #
# Fuel price over the last 12 months ---------------------------------------- #
# --------------------------------------------------------------------------- #

# 30 12-month diesel high as text
master %>% 
  bind_rows(list(id = 30, 
                 description = "12 month diesel high price (text)", 
                 value = year.max.text.d)) -> master

# 31 12-month diesel low as text for chart
master %>% 
  bind_rows(list(id = 31, 
                 description = "12 month diesel low price (text)", 
                 value = year.min.text.d)) -> master

# 32 12-month petrol high as text
master %>% 
  bind_rows(list(id = 32, 
                 description = "12 month petrol high price (text)", 
                 value = year.max.text.p)) -> master

# 33 12-month diesel low as text for chart
master %>% 
  bind_rows(list(id = 23, 
                 description = "12 month petrol low price (text)", 
                 value = year.min.text.p)) -> master

# 34 rest of chart - 12 month prices

# pump.prices 















