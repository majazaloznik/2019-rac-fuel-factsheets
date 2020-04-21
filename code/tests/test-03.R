# =========================================================================== #
#  Tests for 03-calculations                                                  #
# =========================================================================== #

# check the date is yesterday ----------------------------------------------- #
expect_true(Sys.Date() - 1 == date.calc, 
            info = "The data is not from yesterday, are you sure that's OK?")

#checks fuel prices are no more than 10ppl apart ---------------------------- #
expect_true(abs(current.pr.p - current.pr.d) < 10, 
            info = "Diesel and petrol prices are more than 10ppl apart, are you sure that's correct?")

#checks prices are lower than all time high --------------------------------- #
expect_true(current.pr.p < max.p, 
            info = "Petrol price is higher than all time high, are you sure that's correct?")
expect_true(current.pr.d < max.d, 
            info = "Diesel price is higher than all time high, are you sure that's correct?")

#checks prices are not dramatically too low --------------------------------- #
expect_true(current.pr.p > min.p, 
            info = paste0("Petrol price is lower than ", min.p, "p, are you sure that's correct?"))
expect_true(current.pr.d > min.d, 
            info = paste0("Diesel price is lower than ", min.d, "p, are you sure that's correct?"))

# check price change since last data point is less than max.perc.diff.1d ------------------------ #
expect_true(ld.dif.per.p < max.perc.diff.1d, 
            info = paste0("Petrol prices changed by more than ", max.perc.diff.1d,
            "% since the previous data point, is that correct?"))
expect_true(ld.dif.per.d < max.perc.diff.1d, 
            info = paste0("Diesel prices changed by more than ", max.perc.diff.1d,
            "% since the previous data point, is that correct?"))

# check price change since last week is less than 5p ------------------------ #
expect_true(lw.dif.per.p < max.perc.diff.1w, 
            info = paste0("Petrol prices changed by more than ", max.perc.diff.1w,
            "%  since last week, is that correct?"))
expect_true(lw.dif.per.d < max.perc.diff.1w, 
            info = paste0("Diesel prices changed by more than ", max.perc.diff.1w,
            "% since last week, is that correct?"))

#checks oil prices are in sensible range ------------------------------------ #
expect_true(between(current.usd.b, min.usd.b, max.usd.b),
            info = paste0("Oil price is outside the range of",
            min.usd.b, "c and ", max.usd.b, "c, is that correct?"))
