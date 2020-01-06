library(pdftools)
library(OpenImageR)
library(magick)
library(lubridate)

# Read in PDF & save as images (one per page)
pdf <- "code/sandbox/RACF – Fuel Factsheet.pdf"
pdf_convert(pdf, format = "jpg", pages = NULL, filenames = NULL,
            dpi = 600, antialias = TRUE, opw = "", upw = "", verbose = TRUE)

# Extract and format "date of publication"
pdf.text <- pdf_text(pdf)
pdf.text <- pdf.text[1]
pdf.text.clean <- strsplit(pdf.text, " ")
pdf.text.clean <- as.data.frame(pdf.text.clean[[1]])
pdf.text.clean <- subset(pdf.text.clean, pdf.text.clean[1] != "")
pdf.text.clean <- as.data.frame(pdf.text.clean[3:5,]) #*
pdf.text.clean[3,] <- gsub("\n", "", pdf.text.clean[3,], fixed = TRUE) #*

today <- dmy(paste0(as.character(pdf.text.clean[1,]),
                    " ", 
                    as.character(pdf.text.clean[2,]),
                    " ", 
                    as.character(pdf.text.clean[3,])))

today <- format(today, format="%d %b %Y")

# Read in the page jpgs
page1 <- readImage("RACF – Fuel Factsheet_2.jpg")
page2 <- readImage("RACF – Fuel Factsheet_2.jpg")

# Crop and save tweetable images
cost_to_fill_up <- cropImage(page1, 2900:4635, 2050:4830, type = 'user_defined')
writeImage(cost_to_fill_up, file_name = 'cost_to_fill_up.jpg')

average_UK_pump <- cropImage(page1, 1000:2900, 130:2000, type = 'user_defined')
writeImage(average_UK_pump, file_name = 'average_UK_pump.jpg')

breakdown_UK_pump <- cropImage(page1, 1050:2925, 2050:4830, type = 'user_defined')
writeImage(breakdown_UK_pump, file_name = 'breakdown_UK_pump.jpg')

UK_pump_change <- cropImage(page2, 2750:4225, 125:2450, type = 'user_defined')
writeImage(UK_pump_change, file_name = 'UK_pump_change.jpg')

# Annotate images
annotation <- paste0("Source: RAC Foundation, ", today)

cost_to_fill_up.2 <- image_read("cost_to_fill_up.jpg")
cost_to_fill_up.2 <- image_annotate(cost_to_fill_up.2, annotation, gravity = "southwest", location = "+10+10",
                                    degrees = 0, size = 55, font = "", color = NULL, strokecolor = NULL,
                                    boxcolor = NULL)
image_write(cost_to_fill_up.2, path = "cost_to_fill_up.jpg", format = "jpg")

average_UK_pump.2 <- image_read("average_UK_pump.jpg")
average_UK_pump.2 <- image_annotate(average_UK_pump.2, annotation, gravity = "southeast", location = "+10+10",
                                    degrees = 0, size = 45, font = "", color = NULL, strokecolor = NULL,
                                    boxcolor = NULL)
image_write(average_UK_pump.2, path = "average_UK_pump.jpg", format = "jpg")

breakdown_UK_pump.2 <- image_read("breakdown_UK_pump.jpg")
breakdown_UK_pump.2 <- image_annotate(breakdown_UK_pump.2, annotation, gravity = "southeast", location = "+8+8",
                                      degrees = 0, size = 50, font = "", color = NULL, strokecolor = NULL,
                                      boxcolor = NULL)
image_write(breakdown_UK_pump.2, path = "breakdown_UK_pump.jpg", format = "jpg")

UK_pump_change.2 <- image_read("UK_pump_change.jpg")
UK_pump_change.2 <- image_annotate(UK_pump_change.2, annotation, gravity = "southeast", location = "+10+10",
                                   degrees = 0, size = 55, font = "", color = NULL, strokecolor = NULL,
                                   boxcolor = NULL)
image_write(UK_pump_change.2, path = "UK_pump_change.jpg", format = "jpg")
