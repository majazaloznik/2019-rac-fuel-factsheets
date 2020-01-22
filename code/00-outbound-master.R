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
#             If you are running this script from a non-work computer         #
#                  change logical value below to FALSE                        #
#              and enter your data folder, email and password                 #
#                                                                             #
#                         Then source this file.                              #
#                                                                             #
#                Check output in console for any issues.                      #
#                                                                             #
# =========================================================================== #

work.computer <- FALSE
work.data.folder <- "data/processed"
non.work.data.folder <- "data/processed"
sender.email <- "bhavin.makwana@racfoundation.org"
password <- "XXX"

# =========================================================================== #
# 1. Preliminaries                                                            #
# =========================================================================== #
source("code/01-preliminaries.R")

# =========================================================================== #
# 2. Download and clean data                                                  #
# =========================================================================== #
if (all(sapply(test01, isTRUE)))   {
  print("Prelimnaries script completed. Now running Download and clean.")
  source("code/02-download.R") 
} else {
  print("The preliminary script did not run smoothly. See errors below:")
  print(paste("->", sapply(test01, function(x) attributes(x)$info)[!sapply(test01, isTRUE)]))
}

# =========================================================================== #
# 3. Preform necessary calculations                                           #
# =========================================================================== #
if (!exists("test02")) {
  print("Download script was not attempted.")
} else {
  if (all(c(sapply(test02, isTRUE), sapply(test01, isTRUE))))   {
    print("Download and clean script completed. Now running calculations.")
    source("code/03-calculations.R")
  } else {
    print("The download script did not run smoothly. See errors below:")
    print(paste("->", sapply(test02, function(x) attributes(x)$info)[!sapply(test02, isTRUE)]))
  }
}

# =========================================================================== #
# 4. Prepare all required data for export                                     #
# =========================================================================== #
if (!exists("test03")) {
  print("Calculations script was not attempted.")
} else {
  if (all(c(sapply(test03, isTRUE), sapply(test02, isTRUE), sapply(test01, isTRUE))))   {
    print("Calculations script completed. Now running export script")
  source("code/04-export.R")
  } else {
    print("The calculations script did not run smoothly. See errors below:")
    print(paste("->", sapply(test03, function(x) attributes(x)$info)[!sapply(test03, isTRUE)]))
  }
}

# =========================================================================== #
# 5. email edits                                                              #
# =========================================================================== #
if (!exists("test04")) {
  print("Export script was not attempted.")
} else {
  if (all(c(sapply(test04, isTRUE), sapply(test03, isTRUE), 
            sapply(test02, isTRUE), sapply(test01, isTRUE))))   {
    print("Export script completed. Now running email script")
    source("code/05-email.R")
  } else {
    print("The Export script did not run smoothly. See errors below:")
    print(paste("->", sapply(test04, function(x) attributes(x)$info)[!sapply(test04, isTRUE)]))
  }
}
