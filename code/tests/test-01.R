# test packages are all loaded correclty. 
expect_true("tinytest" %in% (.packages())) # meta B)
expect_true("here" %in% (.packages()))
expect_true("XLConnect" %in% (.packages()))
expect_true("mailR" %in% (.packages()))
expect_true("googlesheets" %in% (.packages()))
expect_true("RCurl" %in% (.packages()))
expect_true("dplyr" %in% (.packages()))
# sexpect_true("xdsf" %in% (.packages()), info = "The xdfs package did not load properly")

# test correct working directory - doesn't work - https://github.com/markvanderloo/tinytest/issues/45
# expect_equal(getwd(), "/home/mz/Dropbox/XtraWork/consulting/2019-rac-fuel-factsheets")

# test it isn't a Monday
Sys.setlocale("LC_TIME", "C")
expect_false(weekdays(Sys.Date()) == "Monday",
             info = "You shouldn't be preparing the factsheet on a Monday!")
