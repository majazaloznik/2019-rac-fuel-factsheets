# check the google sheet 
expect_true("googlesheet" %in% class(gs))

# check all tables are imported
expect_true(is.data.frame(pump.prices), info = "Needs to be a dataframe")
expect_true(is.data.frame(oil.prices))
expect_true(is.data.frame(eu.compare))
expect_true(is.data.frame(taxes))
expect_true(is.data.frame(basil))

# check pump prices
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
