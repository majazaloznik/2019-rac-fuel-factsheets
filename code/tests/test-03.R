# =========================================================================== #
#  Tests for 03-calculations                                                  #
# =========================================================================== #

# check the date is yesterday ----------------------------------------------- #
expect_true(Sys.Date() - 1 == date, 
            info = "The data is not from yesterday")

#checks fuel prices are no more than 10ppl apart ---------------------------- #
expect_true(pp.current - dp.current < 10, 
            info = "Diesel and petrol prices are more than 10ppl apart.")

#checks prices are lower than all time high --------------------------------- #
expect_true(pp.current < 142, 
            info = "Petro price is higher than all time high.")

expect_true(dp.current < 148, 
            info = "Diesel price is higher than all time high.")

#checks prices are not dramatically too low --------------------------------- #
expect_true(pp.current > 90, 
            info = "Petrol price is lower than 90p, are you sure that's right?")

expect_true(dp.current > 90, 
            info = "Diesel price is lower than 90p, are you sure that's right?.")


# check price change since last week is less than 5p ------------------------ #
expect_true(abs(pp.lw.dif) < 5, 
            info = "Petrol prices changed by more than 5p in a week, is that right?")

expect_true(abs(dp.lw.dif) < 5, 
            info = "Diesel prices changed nby more than 5p in a week, is that right?")

