# =========================================================================== #
#                                                                             #
#                            RACF Fuel Factsheet                              #
#                            -------------------                              #
#                                                                             #
#       Download, Check, Compile and email the weekly fuel factsheet file     #
#                                                                             #
# =========================================================================== #

# =========================================================================== #
#                                INSTRUCTIONS                                 #
# =========================================================================== #
#                                                                             #
#   1.  Source this file.                                                     #
#                                                                             #
#   2.  Check output in the console for any issues.                           #
#                                                                             #
#   3.  The output Excel file is in the /data folder.                          #
#                                                                             #
# =========================================================================== #

# =========================================================================== #
# constants which might change 
# =========================================================================== #
# all time high petrol price (p)
max.p <- 142
# minimum petrol price (p)
min.p <- 90
# all time high diesel price (p)
max.d <- 148
# minimum diesel price (p)
min.d <- 90
# all time high oil price (usd)
max.usd.b <- 142
# minimum oil price (usd.c)
min.usd.b <- 20
# max percent diff from previous data point
max.perc.diff.1d <- 1
# max percent diff from last week's data point
max.perc.diff.1w <- 3
# vat for petrol
vat.p <- 20
# vat for diesel (currently same as petrol)
vat.d <- vat.p
# fuel duty for petrol
duty.p <- 57.95
# fued duty for diesel (currently same as petrol)
duty.d <- duty.p



# =========================================================================== #
# 1. Preliminaries                                                            #
# =========================================================================== #
source("code/scripts/01-preliminaries.R")

# =========================================================================== #
# 2. Download and clean data                                                  #
# =========================================================================== #
if (all(sapply(test01, isTRUE)))   {
  writeLines("Prelimnaries script completed. \n\nNow running Download and clean.")
  source("code/scripts/02-download.R") 
} else {
  writeLines("The preliminary script did not run smoothly. See errors below:")
  writeLines(paste("->", sapply(test01, function(x) 
    attributes(x)$info)[!sapply(test01, isTRUE)]))
}

# =========================================================================== #
# 3. Preform necessary calculations                                           #
# =========================================================================== #
if (!exists("test02")) {
  writeLines("Download script was not attempted.")
} else {
  if (all(c(sapply(test02, isTRUE), sapply(test01, isTRUE))))   {
    writeLines("Download and clean script completed. \n\nNow running calculations.")
    source("code/scripts/03-calculations.R")
  } else {
    writeLines("The download script did not run smoothly. See errors below:")
    writeLines(paste("->", sapply(test02, function(x) 
      attributes(x)$info)[!sapply(test02, isTRUE)]))
  }
}


# =========================================================================== #
# 4. Prepare all required data for export                                     #
# =========================================================================== #
if (!exists("test03")) {
  writeLines("Calculations script was not attempted.")
} else {
  if (all(c(sapply(test03, isTRUE), sapply(test02, isTRUE), 
            sapply(test01, isTRUE))))   {
    writeLines("Calculations script completed. \n\nNow running export script")
  fisource("code/scripts/04-export.R")
  } else {
    writeLines("The calculations script did not run smoothly. See errors below:")
    writeLines(paste("->", sapply(test03, function(x) 
      attributes(x)$info)[!sapply(test03, isTRUE)]))
    x <- askYesNo("do you want to continue with the script anyway?")
    if(x == FALSE | is.na(x)) {writeLines("Exiting script.")
      opt <- options(show.error.messages = FALSE)
      on.exit(options(opt))
      stop()} else {
      writeLines("Now running export script")
      source("code/scripts/04-export.R")
    }
  }
}

# =========================================================================== #
# 5. email edits                                                              #
# =========================================================================== #
if (!exists("test04")) {
  writeLines("Export script was not attempted.")
} else {
  if (all(c(sapply(test04, isTRUE), 
            sapply(test02, isTRUE), sapply(test01, isTRUE))))   {
    writeLines("Export script completed. \n\nNow running email script")
    source("code/scripts/05-email.R")
  } else {
    writeLines("The Export script did not run smoothly. See errors below:")
    writeLines(paste("->", sapply(test04, function(x) 
      attributes(x)$info)[!sapply(test04, isTRUE)]))
  }
}

