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

expect_true(exists("eu.compare") & ifelse(exists("eu.compare"),
                                          is.data.frame(eu.compare), FALSE),
            info = "EU comparison table does not exist")

expect_true(exists("taxxes") & ifelse(exists("taxxes"),
                                          is.data.frame(taxxes), FALSE),
            info = "Taxes table does not exist")

expect_true(exists("basil") & ifelse(exists("basil"),
                                          is.data.frame(basil), FALSE),
            info = "Basil table does not exist")

# check pump prices --------------------------------------------------------- #

expect_equal(ncol(pump.prices), 3, 
             info = "There should be exactly 3 columns in pump.prices")
expect_true(nrow(pump.prices) > 250 , 
            info = "There should be over 250 rows in pump.prices")
expect_true(inherits(pump.prices$Date, "Date"), 
            info = "The first column in pump.prices should be in date format")
expect_true(is.numeric(pump.prices$Petrol), 
            info = "The petrol price column in pump.prices should be numeric")
expect_true(is.numeric(pump.prices$Diesel), 
            info = "The diesel price column in pump.prices should be numeric")
