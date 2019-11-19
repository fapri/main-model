


library(pdftools)
library(tm)



x = pdf_text("Miscellaneous/Production By County/DATA/MO-Corn-Production-by-County 2017.pdf") %>% strsplit(split = "\n")



x[[1]] = x[[1]][9:66]

x[[1]] = gsub("\r", "", x[[1]])
