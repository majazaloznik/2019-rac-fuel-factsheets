# =========================================================================== #
# TEST data export                                                            #
# =========================================================================== #

expect_equal(nrow(master), 48, 
             info = paste("There should be exactly 66 rows master edits table,",
                          "but there are", nrow(master), "instead."))

expect_true(nrow(pump.prices) > 250, 
             info = paste("There should be more than 250 rows in the pump price,",
                          " table but there are", nrow(eu.rank.d), "instead."))

expect_true(nrow(oil.prices) > 250, 
             info = paste("There should be more than 250 rows in the oil price,",
                          "table but there are", nrow(eu.rank.d), "instead."))

expect_equal(nrow(eu.rank.p), 28, 
             info = paste("There should be exactly 28 rows in the EU petrol table,",
                          "but there are", nrow(eu.rank.p), "instead."))

expect_equal(nrow(eu.rank.d), 28, 
             info = paste("There should be exactly 28 rows in the EU diesel table,",
                          "but there are", nrow(eu.rank.d), "instead."))