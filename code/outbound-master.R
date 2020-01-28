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
#   1.  If you are running this script from your work computer                #
#       make sure the logical value work.computer below is set to TRUE        #
#                                                                             #
#   2.  If you are running this script from a non-work computer               #
#       change the logical value below to FALSE                               #
#       and enter your email and password.                                    #              
#                                                                             #
#   3.  Then source this file.                                                #
#                                                                             #
#   4.  Check output in the console for any issues.                           #
#                                                                             #
#   5.  The output Excel file is in the data folder.                          #
#                                                                             #
# =========================================================================== #

# =========================================================================== #
# setup if not on work PC                                                     #
# =========================================================================== #
work.computer <- TRUE
sender.email <- "bhavin.makwana@racfoundation.org"
password <- "XXX"

# =========================================================================== #
# constants which might change 
# =========================================================================== #
# all time high petrol price
max.p <- 142
# all time high diesel price
max.d <- 148
# all time high oil price (usd)
max.usd.b <- 142
# vat
vat <- 20
# fuel duty
duty <- 57.95
# =========================================================================== #

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
  source("code/scripts/04-export.R")
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
      yattributes(x)$info)[!sapply(test04, isTRUE)]))
  }
}
