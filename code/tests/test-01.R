# test packages are all loaded correclty. 
expect_true("tinytest" %in% (.packages()), 
            info = "The tinytest package did not load properly.") # meta B)
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
expect_true("rstudioapi" %in% (.packages()), 
            info = "The rstudioapi package did not load properly.")
if(.Platform$OS.type != "unix") {expect_true("RDCOMClient" %in% (.packages()), 
                                             info = "The RDCOMClient package did not load properly.")}

