# =========================================================================== #
#  Tests for 03-calculations                                                  #
# =========================================================================== #

# check the date is yesterday ----------------------------------------------- #
expect_true(Sys.Date() - 1 == date, 
            info = "The data is not from yesterday")

#checks fuel prices are no more than 10ppl apart ---------------------------- #
expect_true(abs(current.pr.p - current.pr.d) < 10, 
            info = "Diesel and petrol prices are more than 10ppl apart.")

#checks prices are lower than all time high --------------------------------- #
expect_true(current.pr.p < 142, 
            info = "Petrol price is higher than all time high.")
expect_true(current.pr.d < 148, 
            info = "Diesel price is higher than all time high.")

#checks prices are not dramatically too low --------------------------------- #
expect_true(current.pr.p > 90, 
            info = "Petrol price is lower than 90p, are you sure that's right?")
expect_true(current.pr.d > 90, 
            info = "Diesel price is lower than 90p, are you sure that's right?.")

# check price change since last week is less than 5p ------------------------ #
expect_true(abs(lw.dif.pr.p) < 5, 
            info = "Petrol prices changed by more than 5p in a week, is that right?")
expect_true(abs(lw.dif.pr.d) < 5, 
            info = "Diesel prices changed by more than 5p in a week, is that right?")

#checks oil prices are in sensible range ------------------------------------ #
expect_true(between(current.usd.b, 20, 142),
            info = "Oil price is outside the range of 20 to 143c, is that right?.")


