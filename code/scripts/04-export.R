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
                 value = as.character(date.print))) -> tab01

# 2 petrol price
tab01 %>% 
  bind_rows(list(id = 2, 
                 description = "current petrol price", 
                 value = paste0(current.pr.p, "p"))) -> tab01

# 3 text change since last week.
tab01 %>% 
  bind_rows(list(id = 3, 
                 description = "change in petrol price since last week (txt)", 
                 value = lw.text.pr.p)) -> tab01

# 4 diesel price
tab01 %>% 
  bind_rows(list(id = 4, 
                 description = "current diesel price", 
                 value = paste0(current.pr.d, "p"))) -> tab01

# 5 text change since last week.
tab01 %>% 
  bind_rows(list(id = 5, 
                 description = "change in diesel price since last week (txt)", 
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
                 value = paste0(current.pr.p, "p"))) -> tab02

# 7 vat paid
tab02 %>% 
  bind_rows(list(id = 7, 
                 description = "VAT paid on petrol (p)", 
                 value = paste0(FunDec(vat.paid.p,2), "p"))) -> tab02

# 8 vat as prop of price
tab02 %>% 
  bind_rows(list(id = 8, 
                 description = "VAT paid on petrol (as % of total price)", 
                 value = paste0(FunDec(vat.prop.p,2), "%"))) -> tab02

# 9 fuel duty paid
tab02 %>% 
  bind_rows(list(id = 9, 
                 description = "Fuel Duty on petrol (p)", 
                 value = paste0(FunDec(duty.paid.p,2), "p"))) -> tab02

# 10 fueld duty as prop of price
tab02 %>% 
  bind_rows(list(id = 10, 
                 description = "Fuel Duty on petrol (as % of total price)", 
                 value = paste0(FunDec(duty.prop.p,2), "%"))) -> tab02

# 11 remaining cost (non-tax)
tab02 %>% 
  bind_rows(list(id = 11, 
                 description = paste("Cost of oil, fuel production",
                 "and supply, and profit margin on petrol (p)"), 
                 value = paste0(FunDec(non.tax.cost.p,2), "p"))) -> tab02

# 12. remaining cost as prop of price
tab02 %>% 
  bind_rows(list(id = 12, 
                 description = "Cost of oil etc. on petrol (as % of total price)", 
                 value = paste0(FunDec(non.tax.prop.p,2), "%"))) -> tab02


# 13 tax as prop of price
tab02 %>% 
  bind_rows(list(id = 13, 
                 description = "% of petrol price which is tax", 
                 value = paste0(FunDec(tax.prop.p,2), "%"))) -> tab02

# 14 diesel price = same as 4
tab02 %>% 
  bind_rows(list(id = 14, 
                 description = "current diesel price", 
                 value = paste0(current.pr.d, "p"))) -> tab02

# 15 vat paid
tab02 %>% 
  bind_rows(list(id = 15, 
                 description = "VAT paid on diesel (p)", 
                 value = paste0(FunDec(vat.paid.d,2), "p"))) -> tab02


# 16 vat as prop of price
tab02 %>% 
  bind_rows(list(id = 16, 
                 description = "VAT paid on diesel (as % of total price)", 
                 value = paste0(FunDec(vat.prop.d,2), "%"))) -> tab02

# 17 fuel duty paid
tab02 %>% 
  bind_rows(list(id = 17, 
                 description = "Fuel Duty on diesel (p)", 
                 value = paste0(FunDec(duty.paid.d,2), "p"))) -> tab02


# 18 fuel duty as prop of price
tab02 %>% 
  bind_rows(list(id = 18, 
                 description = "Fuel Duty on diesel (as % of total price)", 
                 value = paste0(FunDec(duty.prop.d,2), "%"))) -> tab02

# 19 remaining cost (non-tax)
tab02 %>% 
  bind_rows(list(id = 19, 
                 description = paste("Cost of oil, fuel production",
                                     "and supply, and profit margin on diesel (p)"), 
                 value = paste0(FunDec(non.tax.cost.d,2), "p"))) -> tab02

# 20. remaining cost as prop of price
tab02 %>% 
  bind_rows(list(id = 20, 
                 description = "Cost of oil etc. on diesel (as % of total price)", 
                 value = paste0(FunDec(non.tax.prop.d,2), "%"))) -> tab02

# 21 tax as prop of price
tab02 %>% 
  bind_rows(list(id = 21, 
                 description = "% of diesel price which is tax", 
                 value = paste0(FunDec(tax.prop.d,2), "%"))) -> tab02

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
                 value = paste0("£", FunDec(tank.p ,2)))) -> tab03

# 23 average diesel tank
tab03 %>% 
  bind_rows(list(id = 23, 
                 description = "cost of filling average diesel tank today (£)", 
                 value = paste0("£", FunDec(tank.d ,2)))) -> tab03

# 24 average petrol tank a month ago
tab03 %>% 
  bind_rows(list(id = 24, 
                 description = "cost of filling average petrol tank last month (£)", 
                 value = paste0("£", FunDec(tank.last.month.p ,2)))) -> tab03

# 25 average diesel tank a month ago
tab03 %>% 
  bind_rows(list(id = 25, 
                 description = "cost of filling average diesel tank last month (£)", 
                 value = paste0("£", FunDec(tank.last.month.d ,2)))) -> tab03

# 26 average petrol tank a month ago
tab03 %>% 
  bind_rows(list(id = 26, 
                 description = "cost of filling average petrol tank six months ago (£)", 
                 value = paste0("£", FunDec(tank.six.month.p ,2)))) -> tab03

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
  bind_rows(list(id = 33, 
                 description = "12 month petrol low price (text)", 
                 value = as.character(year.min.text.p))) -> tab04

# 34 rest of chart - 12 month prices
pump.prices %>% 
  mutate_if(is.numeric, function(x) FunDec(x,2)) -> pump.chart


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
oil.prices %>%
  rename('Brent Crude Oil ($/barrel)' = Brent.USD,
         'Brent Crude Oil (£/barrel)' = Brent.GBP) -> oil.prices



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
                 value = paste0("$", FunDec(current.usd.b, 2)))) -> tab07

# 40 current price of brent in gbp
tab07 %>% 
  bind_rows(list(id = 40, 
                 description = "Current price of Brent oil in GBP", 
                 value = paste0("£", FunDec(current.gbp.b, 2)))) -> tab07

# 41 change in brent price since previous week txt
tab07 %>% 
  bind_rows(list(id = 41, 
                 description = "Absolute change in Brent price since last week (text)", 
                 value = paste0(lw.text.pr.b, " $", FunDec(lw.adif.pr.b, 2)))) -> tab07

# 44 change in brent price since previous month txt
tab07 %>% 
  bind_rows(list(id = 44, 
                 description = "Absolute change in Brent price since last month (text)", 
                 value = paste0(lm.text.pr.b, " $", FunDec(lm.adif.pr.b, 2)))) -> tab07

# 47 change in brent price since previous year txt
tab07 %>% 
  bind_rows(list(id = 47, 
                 description = "Absolute change in Brent price since last year (text)", 
                 value = paste0(ly.text.pr.b, " $", FunDec(ly.adif.pr.b, 2)))) -> tab07

# --------------------------------------------------------------------------- #
# UK average pump price change ---------------------------------------------- #
# --------------------------------------------------------------------------- #
tab08 <- data.frame(id = numeric(),
                    description = character(),
                    value = character())

# 50 change in petrol price since previous week txt
tab08 %>%
  bind_rows(list(id = 50, 
                 description = "Absolute change in petrol price since last week (text)", 
                 value = paste0(lw.word.pr.p, " £", FunDec(lw.adif.pr.p, 2)))) -> tab08

# 53 change in petrol price since previous month text
tab08 %>%
  bind_rows(list(id = 53, 
                 description = "Absolute change in petrol price since last month (text)", 
                 value = paste0(lm.word.pr.p, " £", FunDec(lm.adif.pr.p, 2)))) -> tab08

# 56 change in petrol price since previous year txt
tab08 %>%
  bind_rows(list(id = 56, 
                 description = "Absolute change in petrol price since last year (text)", 
                 value = paste0(ly.word.pr.p, " £", FunDec(ly.adif.pr.p, 2)))) -> tab08

# 59 change in diesel price since previous week txt
tab08 %>%
  bind_rows(list(id = 59, 
                 description = "Absolute change in diesel price since last week (text)", 
                 value = paste0(lw.word.pr.d, " £", FunDec(lw.adif.pr.d, 2)))) -> tab08

# 62 change in diesel price since previous month 
tab08 %>%
  bind_rows(list(id = 62, 
                 description = "Absolute change in diesel price since last month (text)", 
                 value = paste0(lm.word.pr.d, " £", FunDec(lm.adif.pr.d, 2)))) -> tab08

# 65 change in diesel since previous year txt
tab08 %>%
  bind_rows(list(id = 65, 
                 description = "Absolute change in diesel price since last year (text)", 
                 value = paste0(ly.word.pr.d, " £", FunDec(ly.adif.pr.d, 2)))) -> tab08


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
  arrange(desc(retail.p))   %>% 
  mutate_if(is.numeric, function(x) paste0("£", FunDec(x,2))) -> eu.rank.p

# 704, 75, 76, 77 diesel ranking
eu.d %>% 
  arrange(desc(retail.d)) %>% 
  mutate_if(is.numeric, function(x) paste0("£", FunDec(x,2))) ->  eu.rank.d


# =========================================================================== #
# 5. Export                                                                   #
# =========================================================================== #

# bind all subtables together
bind_rows(tab01,
          tab02,
          tab03,
          tab04,
          tab06,
          tab07,
          tab08,
          tab09) -> master

# create data folder if needed
working.year <- format(Sys.Date(), "%Y")

data.folder <- file.path("data", working.year)

suppressWarnings(dir.create(data.folder, recursive = TRUE))

# export to excel workbook
# open template
wb <- loadWorkbook(paste0("code/scripts/RACF_Fuel_factsheet_template.xlsx"))
# create new file name
name <- paste0(data.folder, "/RACF_Fuel_factsheet_",  date.calc, ".xlsx")
# clear sheets in case it existed already

# clearSheet(wb, getSheets(wb))

setStyleAction(wb, XLC$"STYLE_ACTION.DATATYPE")
cs <- createCellStyle(wb)
setDataFormat(cs, format = "dd/mm/yyyy")
setCellStyleForType(wb, style = cs, type = XLC$"DATA_TYPE.DATETIME")

# Save master data table 
createSheet(wb, name = "master")
writeWorksheet(wb, master, sheet = "master")
setColumnWidth(wb, sheet = "master", column = 2:3, width = -1)

# Save eu rank data table 
createSheet(wb, name = "eu.rank")
writeWorksheet(wb, eu.rank.p, sheet = "eu.rank")
writeWorksheet(wb, eu.rank.d, sheet = "eu.rank", startRow = 1, startCol = 5)
setColumnWidth(wb, sheet = "eu.rank", column = 1:7, width = -1)

# Save pump chart data table 
createSheet(wb, name = "pump.chart.data")
writeWorksheet(wb, pump.prices[1:3], sheet = "pump.chart.data")
setColumnWidth(wb, sheet = "pump.chart.data", column = 1:3, width = -1)

# Save poin chart data table 
createSheet(wb, name = "oil.chart.data")
writeWorksheet(wb, oil.prices[1:3], sheet = "oil.chart.data")
setColumnWidth(wb, sheet = "oil.chart.data", column = 1:3, width = -1)



saveWorkbook(wb, name)

attachments <- wb@filename


# =========================================================================== #
# test                                                                        #
# =========================================================================== #

test04 <- run_test_file("code/tests/test-04.R")

