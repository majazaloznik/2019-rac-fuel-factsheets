# =========================================================================== #
# 1. Preliminaries                                                            #
# =========================================================================== #

# Packages ------------------------------------------------------------------ #
suppressPackageStartupMessages(library(tinytest))
suppressPackageStartupMessages(library(here))
suppressPackageStartupMessages(library(XLConnect))
suppressPackageStartupMessages(library(mailR))
suppressPackageStartupMessages(library(googlesheets))
suppressPackageStartupMessages(library(RCurl))
suppressPackageStartupMessages(library("dplyr"))



# =========================================================================== #
# test                                                                        #
# =========================================================================== #

test01 <- run_test_file("code/tests/test-01.R")