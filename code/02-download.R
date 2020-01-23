# =========================================================================== #
# 2. Download and clean data                                                  #
# =========================================================================== #

# Download ------------------------------------------------------------------ #

# register googlesheet
# gs.real <- gs_url(paste0("https://docs.google.com/spreadsheets/d/",
#                      "1sj_T9S2AkFYMrDZqL4ZQfUJTWeQEPCIKqlGS7kJOZ2A/",
#                      "edit#gid=1319741025"), 
#               lookup = FALSE, visibility = NULL, verbose = FALSE)

# test google sheet. 
gs <- gs_url(paste0("https://docs.google.com/spreadsheets/d/",
                    "1-pBRy5IcBpMuZmf-2zzmSNM-0hWPyd4HGPrd-JbFZQw/edit#gid=0"), 
             lookup = FALSE, visibility = NULL, verbose = FALSE)




# Download data and assign -------------------------------------------------- #

# pump prices over the last year 
pump.prices <- gs_read(gs, ws="Max/min fuel working", "E1:G260", verbose = F)  

# oil prices for the last year
oil.prices <- gs_read(gs, ws="Oil Price", "A2:D260", 
                      col_names = c("Date",
                                    "Brent.USD",
                                    "Brent.GBP",
                                    "GBP.USD.xr"),
                      verbose = FALSE)

# fuel price rankings of EU countries
eu.p <- gs_read(gs, ws="UK vs EU Fuel", "A3:C30", 
                      col_names = c("order.p",
                                    "country.p",
                                    "retail.p"),
                                       verbose = FALSE)

eu.d <- gs_read(gs, ws="UK vs EU Fuel", "E3:G30", 
                                   col_names = c("order.d",
                                                 "country.d",
                                                 "retail.d"),
                                   verbose = FALSE)

# pre-tax fuel price rankings of EU countries
eu.pre.t.p <- gs_read(gs, ws="UK vs EU Fuel", "A46:D73", 
                col_names = c("pretax",
                              "tax.perc",
                              "retail.p", 
                              "country"),
                verbose = FALSE)

eu.pre.t.d <- gs_read(gs, ws="UK vs EU Fuel", "F46:I73", 
                      col_names = c("pretax",
                                    "tax.perc",
                                    "retail.p", 
                                    "country"),
                      verbose = FALSE)

# raw basil data - for reference
basil <- gs_read(gs, ws="basil data","B1:L260", verbose = FALSE)

# duty and vat numbers -raw
suppressWarnings(
  suppressMessages(
    taxes <- gs_read(gs, ws="Fuel Data", verbose = FALSE)))

# Functions ----------------------------------------------------------------- #

# Helper function cleaning out any googlesheet remnants such as #DIV/0 or 
# similar. They all start with the hash symbol: #
Fun.gs.clean <- function(df) {
  df[] <- lapply(df, function(x) gsub("^#", NA, x))
  as.data.frame(df)
}

# correct column types as well
Fun.col.types <- function(df){
  df$Date <- as.Date(df$Date, "%d/%m/%Y")
  df <- lapply(df, function(x) 
    if(is.character(x)) suppressWarnings(as.numeric(x)) else x)
  as.data.frame(df)
}

# Clean data ---------------------------------------------------------------- #
# remove any googlesheet errors
pump.prices <- Fun.gs.clean(pump.prices)
oil.prices <- Fun.gs.clean(oil.prices)
eu.p <- Fun.gs.clean(eu.p)
eu.d <- Fun.gs.clean(eu.d)
eu.pre.t.p <- Fun.gs.clean(eu.pre.t.p)
eu.pre.t.d <- Fun.gs.clean(eu.pre.t.d)
taxes <- Fun.gs.clean(taxes)
basil <- Fun.gs.clean(basil)

#  and fix column types
pump.prices <- Fun.col.types(pump.prices)
oil.prices <- Fun.col.types(oil.prices)
taxes <- Fun.col.types(taxes)
basil <- Fun.col.types(basil)

# clean currency symbols
eu.p$retail.p <- as.numeric(gsub("\\£", "", eu.p$retail.p))
eu.d$retail.d <- as.numeric(gsub("\\£", "", eu.d$retail.d))
eu.pre.t.p$tax.perc <- as.numeric(gsub("\\£", "", eu.pre.t.p$tax.perc))
eu.pre.t.d$tax.perc <- as.numeric(gsub("\\£", "", eu.pre.t.d$tax.perc))


# =========================================================================== #
# test                                                                        #
# =========================================================================== #

test02 <- run_test_file(here::here("code/tests/test-02.R"))

