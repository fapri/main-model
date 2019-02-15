library(readxl)
library(lubridate)

CornModel <- read_excel("D:/Corn Model - New Basis.xlsx", 
                           sheet = "PO Sales - R (New Basis)")

names(CornModel) <- c("Date", "Price", "Crop.Year", "Sale")

CornModel$Crop.Year <- factor(CornModel$Crop.Year)
CornModel$Date <- as.Date(CornModel$Date)

CornPreAndPost0809.ds <- subset(CornModel, Crop.Year == "08-09")
CornPreAndPost0910.ds <- subset(CornModel, Crop.Year == "09-10")
CornPreAndPost1011.ds <- subset(CornModel, Crop.Year == "10-11")
CornPreAndPost1112.ds <- subset(CornModel, Crop.Year == "11-12")
CornPreAndPost1213.ds <- subset(CornModel, Crop.Year == "12-13")
CornPreAndPost1314.ds <- subset(CornModel, Crop.Year == "13-14")
CornPreAndPost1415.ds <- subset(CornModel, Crop.Year == "14-15")
CornPreAndPost1516.ds <- subset(CornModel, Crop.Year == "15-16")
CornPreAndPost1617.ds <- subset(CornModel, Crop.Year == "16-17")
