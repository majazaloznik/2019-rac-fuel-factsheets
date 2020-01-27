# =========================================================================== #
# 1. Preliminaries                                                            #
# =========================================================================== #

# Packages ------------------------------------------------------------------ #
suppressPackageStartupMessages(library(tinytest))
suppressPackageStartupMessages(library(XLConnect))
suppressPackageStartupMessages(library(mailR))
suppressPackageStartupMessages(library(googlesheets))
suppressPackageStartupMessages(library(RCurl))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(lubridate))
suppressPackageStartupMessages(library(readr))
suppressPackageStartupMessages(library(rstudioapi))
if(.Platform$OS.type != "unix") {suppressPackageStartupMessages(library(RDCOMClient))}
options(stringsAsFactors=FALSE)

# set working directory ----------------------------------------------------- #
if("rstudioapi" %in% (.packages())) {
  setwd(dirname(getSourceEditorContext()$path))
  setwd('..')
}

# Functions ----------------------------------------------------------------- #

# round to exactly n decimal places
FunDec <- function(x, n) {
  format(round(x, n), nsmall = n)
}

# =========================================================================== #
# test                                                                        #
# =========================================================================== #

test01 <- run_test_file("code/tests/test-01.R")
