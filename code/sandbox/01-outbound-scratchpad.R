# =========================================================================== #
#                                                                             #
#                            RACF Fuel Factsheet                              #
#                            -------------------                              #
#                                                                             #
#       Download, Check, Compile and email the weekly fuel factsheet file     #
#                                                                             #
# =========================================================================== #


# =========================================================================== #
#                                INSTRUCTIONS                                 #
# =========================================================================== #


# =========================================================================== #
#                                   TOC                                       #
# =========================================================================== #
# 1. Preliminaries                                                            #
# 2. Download and clean data                                                  #
# 3. Data checks                                                              #
# 4. Prepare edits                                                            #
# 5. Email file                                                               #
# =========================================================================== #


# =========================================================================== #
# 1. Preliminaries                                                            #
# =========================================================================== #

# Packages ------------------------------------------------------------------ #
library(XLConnect)
library(mailR)
library(googlesheets)
library(RCurl)
suppressPackageStartupMessages(library("dplyr"))

# Working directory --------------------------------------------------------- #
setwd("K:\\\\RESEARCH\\Data\\Fuel Factsheet")

print("1. Preliminaries done")

# =========================================================================== #
# 2. Download and clean data                                                  #
# =========================================================================== #

# Download ------------------------------------------------------------------ #

# register googlesheet
factsheet <- gs_url(paste0("https://docs.google.com/spreadsheets/d/",
                           "1sj_T9S2AkFYMrDZqL4ZQfUJTWeQEPCIKqlGS7kJOZ2A/",
                           "edit#gid=1319741025"), 
                    lookup = FALSE, visibility = NULL, verbose = TRUE)
print("2. Googlesheet registered")

# download and assign requried data

pumpprice <- gs_read(factsheet, ws="Breakdown of pump price")                           
#breakdown of pump price
maxmin <- gs_read(factsheet, ws="Max/min fuel working", col_names = FALSE, "i1:j26") 
#max/min working
lastyear <- gs_read(factsheet, ws="Max/min fuel working", "E1:G260")                
#pump rices over the lat year
lastweek <- gs_read(factsheet, ws="Change from last week", col_names = FALSE)         
#change from last week text
overtime <- gs_read(factsheet, ws="Fuel Price over time", col_names = FALSE)         
#fuel prices over time highs and lows only
oilprice <- gs_read(factsheet, ws="Oil Price", "A1:d260")                 
#one year oil data 
oilmaxmin <- gs_read(factsheet, ws="Oil Price", "f1:h5")                  
#max min workings
UKvsEU <- gs_read(factsheet, ws="UK vs EU Fuel")                              
#rankings EU fuel
predictor <- gs_read(factsheet, ws="Fuel Predictor", range = "c23:i31")      
#fuel price predictor data
FPP <- gs_read(factsheet, ws="FPP -R", "A12:C14")
#formatted predictor data 
costtofillup <- gs_read(factsheet, ws="Av. family car", col_names = FALSE)    
#cost to fill up an average car, today, one month, 6 month and low
basil <- gs_read(factsheet, ws="basil data","b1:l260")
#raw basil data - for reference
# oilworking <- gs_read(factsheet, ws=13)                       
#oil price working - for reference
Changeoilfuel <- gs_read(factsheet, ws="Change fuel and oil", "A1:k30")
#change info for fuel and oil 

print("3. Data imported")

  
  
  

#######################-------------------- FUNCTIONS --------------------##########################
{                                     
  ############## FUNCTION 1 #################
  # check for NAs
  error.check <- function(x) {
    if ( any(is.na(x) == TRUE) ) {
      ss <-"ERROR" 
    } else {
      ss <- "GO"
    } 
    return(ss)
  }
  
  ############## FUNCTION 2 #################
  sheet.check <- function(x) {
    if ( any(x == "ERROR") ) {
      sc <- "STOP"
    } else {
      sc <- "All OK"
    } 
    return(sc)
  }
  
  ############# FUNCTION 3 ##################
  # remove any google sheet remnants leaving only numbers and NAs?
  gg.convert <- function(x) {
    x[x == "#N/A"] <- NA 
    x[x == "#REF!"] <- NA 
    x[x == "#DIV/0!"] <- NA 
    x[x == "#NULL!"] <- NA 
    x[x == "#VALUE!"] <- NA 
    x[x == "#NAME?"] <- NA
    x[x == "#NUM!"] <- NA
    return(x)
  }
  
  
  ############# FUNCTION 4 ##################
  date.check <- function(x) {
    date <- Sys.Date()-1 == as.Date(x, format = "%d/%m/%Y")
    if (date ==TRUE ){
      dc <- ("DATE CORRECT")
    } else {
      dc <- stop("DATE IS WRONG")
    } 
    return(dc)
  }
  
  ############# FUNCTION 5 #################
  
  
  
  
  ################################################################################################
  
  # Check the data is correct
  #############################
  
  ## PUMP PRICE CHECKS ##
  
  #daily pump price data cells
  cellpprow <- c(1:11)
  cellspp <- c(1:11, 15:18, 20:23)
  cellspp2 <- c(15:17, 20:22)
  
  #turn #N/A google errors into R errors
  pumpprice <- gg.convert(pumpprice)
  
  #check for errors in each column of the sheet
  pp.1 <- error.check(pumpprice$X1[cellpprow])
  pp.2 <- error.check(pumpprice$Daily[cellspp])
  pp.3 <- error.check(pumpprice$X3[cellspp2])
  pp <- c(pp.1, pp.2, pp.3)
  
  #check for errors in the entire sheet
  if (sheet.check(pp) == "STOP"){
    stop("ERROR IN PUMP PRICE")
  } else {
    print("BREAKDOWN OF PUMP PRICE CHECKED FOR ERRORS")
  }
  
  #Check the date is correct
  date.check(pumpprice$Daily[1])
  
  #LOGIC TESTS
  as.numeric(pumpprice$Daily[2]) ->petrol
  as.numeric(pumpprice$Daily[3]) -> diesel
  
  
  #checks fuel prices are no more than 10ppl apart
  if (petrol+10<diesel) {
    stop("CHECK THE FUEL PRICES")
  } else {
    print("Fuel prices ok - not more than 10ppl apart")
  }
  
  #checks less than all time high
  if (petrol>142) {
    stop("CHECK THE PETROL PRICE")
  } else {
    print("Petrol price less than all time high")
  }
  
  if (diesel>148) {
    stop("CHECK THE DIESEL PRICE")
  } else {
    print("Diesel price less than all time high")
  }
  
  #checks duty 
  if((as.numeric(pumpprice$Daily[6]) == 57.95 & as.numeric(pumpprice$Daily[7]) == 57.95)==TRUE){
    print("Duty rates are correct")
  } else {
    stop("DUTY RATES ARE NOT CORRECT")
  }
  
  ## MAX/MIN PRICE WORKING CHECK ###
  
  #cells to check
  cellsmm <- c(1:4, 6:8)
  cellsmm2 <-c(1:4, 6:8,13,15:16,19:20,22:23,25:26)
  
  #convert google errors into R errors
  maxmin <- gg.convert(maxmin)


#check errors in each column of the sheet
mm.1 <- error.check(maxmin$X1[cellsmm])
mm.2 <- error.check(maxmin$X2[cellsmm2])
mm <- c(mm.1,mm.2)

#check sheet for errors
if (sheet.check(mm) == "STOP"){
  stop("ERROR IN MAX MIN WORKING")
} else {
  print("MAX MIN WORKING CHECKED & ALL OK")
}

#Check the date is correct
date.check(maxmin$X1[1])
date.check(as.Date(maxmin$X2[13], "%d/%m/%Y") +7) #week before date

#LOGIC TESTS
petrol.max <- as.numeric(maxmin$X2[3])
as.numeric(maxmin$X2[4]) -> petrol.min
as.numeric(maxmin$X2[7]) -> diesel.max
as.numeric(maxmin$X2[8]) -> diesel.min
petrol.lw <- as.numeric(maxmin$X2[15])
diesel.lw <- as.numeric(maxmin$X2[16])

#checks fuel prices are not extreme
if (diesel.max>148 | diesel.min<90) {
  stop("CHECK THE DIESEL PRICE")
} else {
  print("Diesel price OK")
}

if (petrol.max>142 | petrol.min<90) {
  stop("CHECK THE PETROL PRICES")
} else {
  print("Petrol prices ok")
}

#checks fuel price change is less than 5ppl 
if ((abs(petrol-petrol.lw))>5 | (abs(diesel-diesel.lw))>5) {
  stop("CHECK THE FUEL PRICES")
} else {
  print("Fuel prices ok")
}
## Fuel date from last year ##

# convert google errors in R errors
lastyear <- gg.convert(lastyear)

#colum error check
ly.1 <- error.check(lastyear$Date)
ly.2 <- error.check(lastyear$Petrol)
ly.3 <- error.check(lastyear$Diesel)
ly <- c(ly.1, ly.2, ly.3)

# sheet check
if (sheet.check(ly) == "STOP"){
  stop("ERROR IN LAST YEAR FUEL DATA")
} else {
  print("LAST YEAR FUEL DATA CHECKED & ALL OK")
}

# date check
date.check(lastyear$Date[1])

#check the date range is a year +- 3 days (from a leap year)
if ( (as.Date(lastyear$Date[1], "%d/%m/%Y") -
      as.Date(tail(lastyear$Date)[6], "%d/%m/%Y") <369 |
      as.Date(lastyear$Date[1], "%d/%m/%Y") -
      as.Date(tail(lastyear$Date)[6], "%d/%m/%Y") >363) == TRUE) {
  print("Year range OK")
} else {
  stop("Check fuel data year range")
}

##  Change from last week ##

# convert google errors in R errors
lastweek <- gg.convert(lastweek)

#colum error check
lw.1 <- error.check(lastweek$X1)
lw.2 <- error.check(lastweek$X2)
lw <- c(lw.1, lw.2)

# sheet check
if (sheet.check(lw) == "STOP"){
  stop("ERROR IN LAST WEEK DATA")
} else {
  print("LAST WEEK DATA CHECKED & ALL OK")
}

## Fuel prices over time ##

# convert google errors in R errors
overtime <- gg.convert(overtime)

#colum error check
ot.1 <- error.check(overtime$X1)
ot.2 <- error.check(overtime$X2)
ot.3 <- error.check(overtime$X3)
ot.4 <- error.check(overtime$X4)
ot <- c(ot.1, ot.2, ot.3, ot.4)

# sheet check
if (sheet.check(ot) == "STOP"){
  stop("ERROR IN PRICE OVER TIME DATA")
} else {
  print("PRICE OVER TIME DATA CHECKED & ALL OK")
}

## Oil price data check ##

# convert google errors in R errors
oilprice <- gg.convert(oilprice)

#colum error check
op.1 <- error.check(oilprice$Date)
op.2 <- error.check(oilprice$`Brent Crude Oil ($/barrel)`)
op.3 <- error.check(oilprice$`Brent Crude Oil (£/barrel)`)
op.4 <- error.check(oilprice$`Pound to USD Exchange Rate`)
op <- c(op.1, op.2, op.3, op.4)

# sheet check
if (sheet.check(op) == "STOP"){
  stop("ERROR IN OIL PRICE OVER TIME DATA")
} else {
  print("OIL PRICE OVER TIME DATA CHECKED & ALL OK")
}

# date check
date.check(oilprice$Date[1])

#check the date range is a year +- 3 days (from a leap year)
if ( (as.Date(oilprice$Date[1], "%d/%m/%Y") -
      as.Date(tail(oilprice$Date)[6], "%d/%m/%Y") <369 |
      as.Date(oilprice$Date[1], "%d/%m/%Y") -
      as.Date(tail(oilprice$Date)[6], "%d/%m/%Y") >363) == TRUE) {
  print("Year range OK")
} else {
  stop("Check fuel data year range")
}

#sense check the max
if (max(oilprice$`Brent Crude Oil ($/barrel)`) <143) {
  print("Oil max less than record high")
}  else {
  stop("OIL PRICE MAX GREATER THAN RECORD HIGH")
}

#sense check the min
if (max(oilprice$`Brent Crude Oil ($/barrel)`) >20) {
  print("Oil min greater than $20per barrel")
}  else {
  stop("OIL PRICE LESS THAN $20 PER BARREL")
}

## UK vs EU Fuel ##
#cellsneeded
cellsEU <- c(1:29)
cellsEU2 <- c(32:35)
cellsEU3 <- c(35:37)

# convert google errors in R errors
UKvsEU <- gg.convert(UKvsEU)
names(UKvsEU)[names(UKvsEU)==colnames(UKvsEU[1])] <- "col1"
#colum error check
EU.1 <- error.check(UKvsEU$col1[cellsEU])
EU.2 <- error.check(UKvsEU$X2[cellsEU])
EU.3 <- error.check(UKvsEU$`//yesterday's date`[cellsEU])
EU.4 <- error.check(UKvsEU$X5[cellsEU])
EU.5 <- error.check(UKvsEU$X6[cellsEU])
EU.6 <- error.check(UKvsEU$X7[cellsEU])
EU.7 <- error.check(UKvsEU$X8[cellsEU])
EU.8 <- error.check(UKvsEU$X9[cellsEU])
EU.9 <- error.check(UKvsEU$`Cheapest Petrol`[1])
EU.10 <- error.check(UKvsEU$`Cheapest Diesel`[1])
EU <- c(EU.1, EU.2, EU.3, EU.4, EU.5, EU.6, EU.7, EU.8, EU.9, EU.10)


# sheet check
if (sheet.check(EU) == "STOP"){
  stop("ERROR IN EU PRICE DATA")
} else {
  print("EU PRICE DATA CHECKED & ALL OK")
}


## oil price working check ##

# convert google errors in R errors
oilmaxmin <- gg.convert(oilmaxmin)

#colum error check
omm.1 <- error.check(oilmaxmin$X1)
omm.2 <- error.check(oilmaxmin$`$`)
omm <- c(omm.1, omm.2)


# sheet check
if (sheet.check(omm) == "STOP"){
  stop("ERROR IN FUEL OIL PRICE MAX MIN WORKING")
} else {
  print("OIL PRICE MAX MIN ")
}

# date check
date.check(oilmaxmin$X1[1])

#sense check 
if (oilmaxmin$`$`[1] <143 & oilmaxmin$`$`[1]>20){
  print("Oil price is OK")
} else {
  stop("Oil price is outside the range of 20 to 143")
}

if (oilmaxmin$`$`[2] == max(oilprice$`Brent Crude Oil ($/barrel)`)){
  print("Max oil working is OK")
} else {
  stop("Max oil price working is WRONG")
}

if (oilmaxmin$`$`[3] == min(oilprice$`Brent Crude Oil ($/barrel)`)){
  print("Min oil working is OK")
} else {
  stop("Min oil price working is WRONG")
}

## cost to fill up an average car ##

#daily pump price data cells
cellcf <- c(1,2,4,5,7,8,9,11,12,14,15,16,18,19,21,22,24,26,28,29,30,32,33)
cellcf2 <- c(1,2,5,6,8,9,11,12,15,16,18,19,21,22,26,27,29,30,32,33)


#turn #N/A google errors into R errors
costtofillup <- gg.convert(costtofillup)


##  Basil data check ##

#turn #N/A google errors into R errors
basil <- gg.convert(basil)

#check for errors in each column of the sheet
bs.1 <- error.check(basil$Date)
bs.2 <- error.check(basil$`Pound to USD Exchange Rate`)
bs.3 <- error.check(basil$`Brent Crude Oil Dated`)
bs.4 <- error.check(basil$`Platts Unleaded Gasoline 10ppm  $/Tonne`)
bs.5 <- error.check(basil$`Platts Diesel 10 ppm UK $/Tonne  `)
bs.6 <- error.check(basil$`Platts Fuel grade Ethanol T2  Euro / CM`)
bs.7 <- error.check(basil$`Platts Biodiesel FAME -10 $ / Tonne`)
bs.8 <- error.check(basil$`Experian Catalist Average Pump  Unleaded Petrol`)
bs.9 <- error.check(basil$`Experian Catalist Average Pump Unleaded Petrol-VAT`)
bs.10 <- error.check(basil$`Unleaded Pump-Wholesale`)
bs.11 <- error.check(basil$`Experian Catalist Average Pump  Diesel`)

bs <- c(bs.1, bs.2, bs.3, bs.4, bs.5, bs.6, bs.7, bs.8, bs.9, bs.10, bs.11)

#check for errors in the entire sheet
if (sheet.check(bs) == "STOP"){
  stop("ERROR BASIL DATA")
} else {
  print("BASIL DATA OK")
}

#date check
date.check(basil$Date[1])

#sense check not needed - the others check all the data. Just error check required.

##  Change from last week NEW - fuel and oil ##

# convert google errors in R errors
changefueloil <- gg.convert(Changeoilfuel)

#colum error check
cfo.1 <- error.check(Changeoilfuel$`Today's price `[c(1:3,5:7,9:12)])
cfo.2 <- error.check(Changeoilfuel$`latest date`[c(15:17,19:21,23:25,27:29)])
cfo.3 <- error.check(Changeoilfuel$X5[c(5:7,9:12)])
cfo.4 <- error.check(Changeoilfuel$X6[c(15:17,19:21,23:25,27:29)])
cfo.5 <- error.check(Changeoilfuel$X9[c(5:7,9:12)])
cfo.6 <- error.check(Changeoilfuel$X10[c(15:17,19:21,23:25,27:29)])

cfo <- c(cfo.1, cfo.2,cfo.3,cfo.4,cfo.5,cfo.6)

# sheet check
if (sheet.check(cfo) == "STOP"){
  stop("ERROR IN CHANGE IN FUEL PRICE DATA")
} else {
  print("CHANGE IN FUEL PRICE DATA CHECKED & ALL OK")
}



# Creating the custom data frames in the current Factsheet layout
#################################################################

#fuel price data frame
FuelPriceData.df <- data.frame(lastyear) 

#oil price data frame
OilPrice.df <- data.frame(oilprice)
names(OilPrice.df)[names(OilPrice.df)==colnames(OilPrice.df[1])] <- "Date"
names(OilPrice.df)[names(OilPrice.df)==colnames(OilPrice.df[2])] <- "Brent Crude Oil ($/barrel)"
names(OilPrice.df)[names(OilPrice.df)==colnames(OilPrice.df[3])] <- "Brent Crude Oil (?/barrel)"
names(OilPrice.df)[names(OilPrice.df)==colnames(OilPrice.df[4])] <- "Pound to USD Exchange Rate"

#Breakdown of pump price 

bd.m <- matrix(nrow=29,ncol=3)
bd.m[1:3] <- pumpprice$Daily[1:3]
bd.m[4:12] <- pumpprice$Daily[15:23]
bd.m[15:16] <- costtofillup$X1[1:2]
bd.m[18:19] <- costtofillup$X1[11:12]
bd.m[21:22] <- costtofillup$X1[21:22]
bd.m[24:25] <- costtofillup$X1[32:33]
bd.m[28:29] <- c("Petrol", "Diesel")
bd.m[4:11, 2] <- pumpprice$X3[15:22]
bd.m[21:22, 2] <- costtofillup$X2[21:22]
bd.m[28:29, 2] <- lastweek$X2[1:2]
bd.m[is.na(bd.m)] <- ""

breakdown.df <- data.frame(bd.m)

#Fuel Price over time
fp.m <- matrix(nrow=6,ncol=3)

fp.m[1:6] <- overtime$X2
fp.m[1:6,2] <- overtime$X4
fp.m[is.na(fp.m)] <- ""

FuelPriceOverTime.df <- data.frame(fp.m)

#UK vs EU Fuel

UKvsEUFuel <- UKvsEU[44:72,]
UKvsEUFuel$X5[2:29] <- rank(as.numeric(as.character(UKvsEUFuel$col1[2:29])), na.last = NA, ties.method = "min")
UKvsEUFuel$`Cheapest Petrol`[2:29] <- rank(as.numeric(as.character(UKvsEUFuel$X6[2:29])), na.last = NA, ties.method = "min")
UKvsEUFuel <- subset(UKvsEUFuel, UKvsEUFuel$X4 == "UK" | UKvsEUFuel$X9 == "UK")
UKvsEUFuel$PretaxPetrolRank <- UKvsEUFuel$X5
UKvsEUFuel$PretaxDieselRank <- UKvsEUFuel$`Cheapest Petrol`
UKvsEUFuel <- UKvsEUFuel[,12:13]

#EU Fuel table 

names(UKvsEU)[names(UKvsEU)==colnames(UKvsEU[1])] <- "col1"

EU.t <- matrix(nrow = 30, ncol = 7)
EU.t[1,2] <- "Petrol"
EU.t[1,6] <- "Diesel"
EU.t[2,] <- c("Rank", "Country", "Price", "", "Rank", "Country", "Price")
EU.t[3:30] <- UKvsEU$col1[2:29]
EU.t[3:30, 2] <- UKvsEU$X2[2:29] 
EU.t[3:30, 3] <- UKvsEU$`//yesterday's date`[2:29] 
EU.t[3:30, 4] <- UKvsEU$X4[2:29] 
EU.t[3:30, 5] <- UKvsEU$X5[2:29]

EU.t[3:30, 6] <- UKvsEU$X6[2:29] 
EU.t[3:30, 7] <- UKvsEU$X7[2:29] 
EU.t[is.na(EU.t)] <- ""

EU.df <- data.frame(EU.t)

#fuel price prediction

c("", "// predicted price of petrol in 2 weeks ? confidence (p)", "// predicted price of diesel in 2 weeks ? confidence (p)", "")
FPP.1 <- cbind(FPP, c("// predicted price of petrol in 2 weeks ? confidence (p)", "// predicted price of diesel in 2 weeks ? confidence (p)"))
names(FPP.1)[names(FPP.1)==colnames(FPP.1[4])] <- "Notes"
FPP.1 <- FPP.1[c("Date", "Price", "Confidence interval", "Notes")]

predictor.df <- data.frame(FPP.1)

# oil price workings

OilPriceWK.df <- data.frame(oilmaxmin$X1, oilmaxmin$`$`)
OilPriceWK.df$Oil1weekchange[1] <- as.character(Changeoilfuel$`latest date`[29])
OilPriceWK.df$Oil1monthchange[1] <- as.character(Changeoilfuel$X6[29])
OilPriceWK.df$Oil1yearchange[1] <- as.character(Changeoilfuel$X10[29])
OilPriceWK.df[2:4, 3:5] <- NA
OilPriceWK.df$Oil1weekchange[2] <- "Change in Oil price compared to 1 week ago"
OilPriceWK.df$Oil1monthchange[2] <- "Change in Oil price compared to 1 month ago"
OilPriceWK.df$Oil1yearchange[2] <- "Change in Oil price compared to 1 year ago"
##chnage in average fuel price data 

ChangeFuel.df <- data.frame(changefueloil[c(27:28),])


# Write to xls file
####################
workingyear <- format(Sys.Date(), "%Y")
setwd("K:/RESEARCH/Data/Fuel Factsheet/Data/Template") 
wbfs <- loadWorkbook("data/dictionaries/original/RACF Fuel factsheet 2019-08-12.xls")  #load the template file


dir.create(paste0("K:/RESEARCH/Data/Fuel Factsheet/Data/",workingyear)) #create directory if needed
setwd(paste0("K:/RESEARCH/Data/Fuel Factsheet/Data/",workingyear)) #these two line eliminate the need to update year manually
#CHANGE IF NOT ON OFFICE PC
sys.date.1 <- Sys.Date()-1
spreadsheetname <- "RACF Fuel factsheet "
name <- paste0(spreadsheetname, sys.date.1, ".xls")

# compute excel dates!?
FuelPriceData.df$Date <-
  (-as.numeric(as.Date("1900-01-01")) + as.numeric(    as.Date((FuelPriceData.df$Date), format = "%d/%m/%Y")) +2)

OilPrice.df$Date <-
  (-as.numeric(as.Date("1900-01-01")) + as.numeric(    as.Date((OilPrice.df$Date), format = "%d/%m/%Y")) +2)

writeWorksheet(wbfs, breakdown.df[,1:2], "Breakdown of pump price", header = FALSE)
writeWorksheet(wbfs, OilPrice.df, "Oil Price chart data", header = FALSE)
writeWorksheet(wbfs, UKvsEUFuel, "UK vs EU Fuel", header = FALSE)
writeWorksheet(wbfs, FuelPriceOverTime.df[,1:2], "Fuel Price over time", header = FALSE)
writeWorksheet(wbfs,EU.df, "EU Fuel Table", header = FALSE)
writeWorksheet(wbfs, predictor.df, "Fuel Price Prediction", header = FALSE)
writeWorksheet(wbfs, OilPriceWK.df, "Oil Price", header = FALSE)
writeWorksheet(wbfs, OilPrice.df, "Oil Price chart data")
writeWorksheet(wbfs, FuelPriceData.df, "Weekly fuel price data")
writeWorksheet(wbfs, ChangeFuel.df, "Fuel Price Change", header = FALSE)

saveWorkbook(wbfs, name)

# Email File 
#############
subject<- paste0(spreadsheetname, sys.date.1)

# USE IF NOT USING AN OFFICE PC

#{
#attachment <- paste0("./",name) #need to edit depending on the factsheet location
#sender <- "bhavin.makwana@racfoundation.org" 
#recipients <- c("bhavin.makwana@racfoundation.org") # Replace with one or more valid addresses
#email <- send.mail(from = sender,
#                   to = recipients,
#                   subject= subject,
#                   body = "
#Please find attached the lastest RACF fuel factsheet data
#
#Sent via an automated R script
#
#Kind Regards, 
#Bhavin Makwana",
#                   smtp = list(host.name = "smtp.office365.com", port = 587, user.name= "bhavin.makwana@racfoundation.org", passwd ="xxx", tls = TRUE),
#                   authenticate = TRUE,
#                   send = TRUE, 
#                   attach.files = attachment
#)
#}

# Email using Outlook
######################

OutAttach <- paste0("K:\\RESEARCH\\Data\\Fuel Factsheet\\Data\\",workingyear,"\\", name)
msg <- "Dear Nick and Marc, 

Please find attached the data for this week's fuel factsheet.

Please note that this email has been sent via an automated script.

"

sendEmail("anneka.lawson@racfoundation.org; ivo.wengraf@racfoundation.org; nick@javelin.eu; marc@javelin.eu; philip.gomm@racfoundation.org", Subject= subject, msg, file=OutAttach )


print("Email Sent")
print("END OF THE SCRIPT")
}
