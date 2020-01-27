# test packages are all loaded correclty. 
expect_true("tinytest" %in% (.packages()), 
            info = "The tinytest package did not load properly.") # meta B)
expect_true("here" %in% (.packages()), 
            info = "The here package did not load properly.")
expect_true("XLConnect" %in% (.packages()), 
            info = "The XLConnect package did not load properly.")
expect_true("mailR" %in% (.packages()), 
            info = "The mailR package did not load properly.")
expect_true("googlesheets" %in% (.packages()), 
            info = "The googlesheets package did not load properly.")
expect_true("RCurl" %in% (.packages()), 
            info = "The RCurl package did not load properly.")
expect_true("dplyr" %in% (.packages()), 
            info = "The dplyr package did not load properly.")
if(.Platform$OS.type != "unix") {expect_true("RDCOMClient" %in% (.packages()), 
                                             info = "The RDCOMClient package did not load properly.")}

# sexpect_true("xdsf" %in% (.packages()), info = "The xdfs package did not load properly")

# test correct working directory - doesn't work - https://github.com/markvanderloo/tinytest/issues/45
# expect_equal(getwd(), "/home/mz/Dropbox/XtraWork/consulting/2019-rac-fuel-factsheets")

# test it isn't a Monday
Sys.setlocale("LC_TIME", "C")
expect_false(weekdays(Sys.Date()) == "Monday",
             info = "You shouldn't be preparing the factsheet on a Monday!")
