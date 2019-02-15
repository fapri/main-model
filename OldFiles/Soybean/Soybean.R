library(readxl)

SoybeanModel <- read_excel("D:/Soybean Model.xlsx", 
                            sheet = "Daily Crop Year Data")

names(SoybeanModel) <- c("Date", "Price", "Crop.Year")

SoybeanModel$Crop.Year <- factor(SoybeanModel$Crop.Year)
SoybeanModel$Date <- as.Date(SoybeanModel$Date)

SoybeanPreAndPost0809.ds <- subset(SoybeanModel, Crop.Year == "08-09")
SoybeanPreAndPost0910.ds <- subset(SoybeanModel, Crop.Year == "09-10")
SoybeanPreAndPost1011.ds <- subset(SoybeanModel, Crop.Year == "10-11")
SoybeanPreAndPost1112.ds <- subset(SoybeanModel, Crop.Year == "11-12")
SoybeanPreAndPost1213.ds <- subset(SoybeanModel, Crop.Year == "12-13")
SoybeanPreAndPost1314.ds <- subset(SoybeanModel, Crop.Year == "13-14")
SoybeanPreAndPost1415.ds <- subset(SoybeanModel, Crop.Year == "14-15")
SoybeanPreAndPost1516.ds <- subset(SoybeanModel, Crop.Year == "15-16")
SoybeanPreAndPost1617.ds <- subset(SoybeanModel, Crop.Year == "16-17")
