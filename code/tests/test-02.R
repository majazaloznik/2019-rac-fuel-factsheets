# =========================================================================== #
# 2. Tests for 02-download.R                                                  #
# =========================================================================== #

# check the google sheet  --------------------------------------------------- #
expect_true("googlesheet" %in% class(gs), 
            info = "The googlesheet was not registered correctly")

# check all tables are imported --------------------------------------------- #

expect_true(exists("pump.prices") & ifelse(exists("pump.prices"),
                                           is.data.frame(pump.prices), FALSE),
            info = "Pump price table does not exist")
expect_true(exists("oil.prices") & ifelse(exists("oil.prices"),
                                          is.data.frame(oil.prices), FALSE),
            info = "Oil price table does not exist")
expect_true(exists("eu.p") & ifelse(exists("eu.p"),
                                          is.data.frame(eu.p), FALSE),
            info = "EU petrol comparison table does not exist")
expect_true(exists("eu.d") & ifelse(exists("eu.d"),
                                          is.data.frame(eu.d), FALSE),
            info = "EU diesel comparison table does not exist")
expect_true(exists("taxes") & ifelse(exists("taxes"),
                                          is.data.frame(taxes), FALSE),
            info = "Taxes table does not exist")
expect_true(exists("basil") & ifelse(exists("basil"),
                                          is.data.frame(basil), FALSE),
            info = "Basil table does not exist")

# check pump prices --------------------------------------------------------- #

expect_equal(ncol(pump.prices), 3, 
             info = "There should be exactly 3 columns in pump.prices.")
expect_true(nrow(pump.prices) > 250 , 
            info = "There should be over 250 rows in pump.prices.")
expect_true(inherits(pump.prices$Date, "Date"), 
            info = "The first column in pump.prices should be in date format.")
expect_true(is.numeric(pump.prices$Petrol), 
            info = "The petrol price column in pump.prices should be numeric.")
expect_true(is.numeric(pump.prices$Diesel), 
            info = "The diesel price column in pump.prices should be numeric.")


# check oil prices ---------------------------------------------------------- #

expect_equal(ncol(oil.prices), 4, 
             info = "There should be exactly 4 columns in oil.prices")
expect_true(nrow(oil.prices) > 250 , 
            info = "There should be over 250 rows in oil.prices")
expect_true(inherits(oil.prices$Date, "Date"), 
            info = "The first column in oil.prices should be in date format.")
expect_true(all(sapply(select(oil.prices, -Date),function(x) is.numeric(x))),
            info = paste("The non-date columns in the oil prices table",
                         "should be in numeric format,"))

# check taxes table --------------------------------------------------------- #

expect_equal(ncol(taxes), 7, 
             info = "There should be exactly 7 columns in the VAT/duty table.")
expect_true(inherits(taxes$Date, "Date"), 
            info = paste("The first column in the VAT/duty table",
            "should be in date forma."))
expect_true(all(sapply(select(taxes, -Date),function(x) is.numeric(x))),
            info = paste("The non-date columns in the VAT/duty table",
                         "should be in numeric format,"))

# check eu comparison tables ------------------------------------------------ #

expect_equal(ncol(eu.p), 3, 
             info = "There should be exactly 3 columns in the EU petrol price table.")
expect_equal(ncol(eu.d), 3, 
             info = "There should be exactly 3 columns in the EU diesel price table.")
expect_true(is.numeric(eu.p$retail.p),
            info = paste("The EU petrol price column should be in numeric format."))
expect_true(is.numeric(eu.d$retail.d),
            info = paste("The EU diesel price column should be in numeric format."))
expect_equal(nrow(eu.p), 28, 
             info = "There should be exactly 28 rows in the EU petrol price table.")
expect_equal(nrow(eu.d), 28, 
             info = "There should be exactly 28 rows in the EU diesel price table.")



# check basil data ---------------------------------------------------------- #

expect_equal(ncol(basil), 11, 
             info = "There should be exactly 11 columns in the basil data")
expect_true(nrow(basil) > 250 , 
            info = "There should be over 250 rows in the basil data")
expect_true(inherits(basil$Date, "Date"), 
            info = "The first column in basil should be in date format.")
expect_true(all(sapply(select(oil.prices, -Date),function(x) is.numeric(x))),
            info = paste("The non-date columns in the basil table",
                         "should be in numeric format,"))





