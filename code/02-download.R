# =========================================================================== #
# 2. Download and clean data                                                  #
# =========================================================================== #

# Download ------------------------------------------------------------------ #

# register googlesheet
gs <- gs_url(paste0("https://docs.google.com/spreadsheets/d/",
                     "1sj_T9S2AkFYMrDZqL4ZQfUJTWeQEPCIKqlGS7kJOZ2A/",
                     "edit#gid=1319741025"), 
              lookup = FALSE, visibility = NULL, verbose = FALSE)

# Download data and assign -------------------------------------------------- #

# pump prices over the last year 
pump.prices <- gs_read(gs, ws="Max/min fuel working", "E1:G260", verbose = F)  

# oil prices for the last year 
oil.prices <- gs_read(gs, ws="Oil Price", "A1:D260", verbose = FALSE)  

# fuel price rankings of EU countries 
suppressWarnings(
  suppressMessages(
    eu.compare <- gs_read(gs, ws="UK vs EU Fuel", verbose = FALSE)))

# raw basil data - for reference
basil <- gs_read(gs, ws="basil data","B1:L260", verbose = FALSE)  

# duty and vat numbers -raw
suppressWarnings(
  suppressMessages(
    taxes <- gs_read(gs, ws="Fuel Data", verbose = FALSE) ))

# Functions ----------------------------------------------------------------- #

# Helper function cleaning out any googlesheet remnants such as #DIV/0 or 
# similar. They all start with the hash symbol: #
Fun.gs.clean <- function(df) {
  df[] <- lapply(df, function(x) gsub("^#", NA, x))
  df
}

# Clean data ---------------------------------------------------------------- #

# remove any googlesheet errors
pump.prices <- Fun.gs.clean(pump.prices)
oil.prices <- Fun.gs.clean(oil.prices)
eu.compare <- Fun.gs.clean(eu.compare)
taxes <- Fun.gs.clean(taxes)
basil <- Fun.gs.clean(basil)

# chage dates to actual dates
pump.prices$Date <- as.Date(pump.prices$Date, "%d/%m/%Y")
pump.prices[] <- lapply(pump.prices, function(x) 
  if(is.character(x)) as.numeric(x) else x)



# =========================================================================== #
# test                                                                        #
# =========================================================================== #

test02 <- run_test_file(here::here("code/tests/test-02.R"))

