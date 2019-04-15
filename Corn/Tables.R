# Corn
# Price Objective
# Table Creation



library(formattable)

#Storage Tables
getTables = function(data) {
  data = cbind(" " = data[,1], round(data[, 2:3], digits = 2))
  table = formattable(data, 
                      align = "c",
                      list(~ formatter("span",
                                       style = x ~ style(display = "block",
                                                         "border-radius" = "2px",
                                                         "padding" = "5px",
                                                         "text-align" = "center")),
                           `Total Avg Price` = formatter("span",
                                                         style = x ~ style(color = "white", background = "gray",
                                                                           padding.left = "10px",
                                                                           padding.right = "10px",
                                                                           border.radius = "5px")),
                           `Pre-Harvest Avg Price` = formatter("span",
                                                               style = x ~ style(color = "white", background = "blue",
                                                                                 padding.left = "10px",
                                                                                 padding.right = "10px",
                                                                                 border.radius = "5px")),
                           `Post-Harvest Avg Price` = formatter("span",
                                                                style = x ~ style(color = "white", background = "green",
                                                                                  padding.left = "10px",
                                                                                  padding.right = "10px",
                                                                                  border.radius = "5px")),
                           
                           ` ` = formatter("span", style = ~ style(display = "block",
                                                                   "border-radius" = "2px",
                                                                   "padding" = "5px",
                                                                   "font.weight" = "bold",  
                                                                   "text-align" = "left"))))
  return(table)
}

# data = Corn_CropYearObjects[[1]][["Storage"]]
# getTables(Corn_CropYearObjects[[1]][["Storage"]])





# Loads all into corn crop year object in a format ready for tables
for (i in 1:length(Corn_CropYearObjects)){
  # dates = Corn_CropYearObjects[[i]]$`PO Actualized`$Date
  # 
  # Corn_CropYearObjects[[i]]$`Sales Summary` = data.frame(matrix(nrow = 6, ncol = length(dates)))
  # 
  # colnames(Corn_CropYearObjects[[i]]$`Sales Summary`) = dates
  # 
  # Corn_CropYearObjects[[i]]$`Sales Summary` = cbind("Date" = NA, Corn_CropYearObjects[[i]]$`Sales Summary`)
  # 
  # Corn_CropYearObjects[[i]]$`Sales Summary`$`Date` =  c("Price", "Percentage", "Trigger", "On Farm", "Commercial", "Price - Storage")
  # 
  Corn_CropYearObjects[[i]]$`Sales Summary`[1,2:(length(dates) + 1)] = formatC(round(Corn_CropYearObjects[[i]]$`PO Actualized`$Price, digits = 2), format = 'f', digits = 2)
  Corn_CropYearObjects[[i]]$`Sales Summary`[2,2:(length(dates) + 1)] = Corn_CropYearObjects[[i]]$`PO Actualized`$Percent.Sold
  Corn_CropYearObjects[[i]]$`Sales Summary`[3,2:(length(dates) + 1)] = Corn_CropYearObjects[[i]]$`PO Actualized`$Type
  # Moved to Storage script 
  # Corn_CropYearObjects[[i]]$`Sales Summary`[4,2:(length(dates) + 1)] = formatC(round(Corn_CropYearObjects[[i]]$`PO Actualized`$onFarmStorage, digits = 2), format = 'f', digits = 2)
  # Corn_CropYearObjects[[i]]$`Sales Summary`[5,2:(length(dates) + 1)] = formatC(round(Corn_CropYearObjects[[i]]$`PO Actualized`$CommercialStorage, digits = 2), format = 'f', digits = 2)
  # Corn_CropYearObjects[[i]]$`Sales Summary`[6,2:(length(dates) + 1)] = formatC(round(Corn_CropYearObjects[[i]]$`PO Actualized`$finalPrice, digits = 2), format = 'f', digits = 2)
  
}








#Sales Summaries
getSalesTable = function(data) {
  table = formattable(data, 
                      align = "c",
                      list(~ formatter("span",
                                       style = x ~ style(display = "block",
                                                         "border-radius" = "2px",
                                                         "padding" = "5px",
                                                         "text-align" = "center")),
                           # `Price` = formatter("span",
                           #                               style = x ~ style(color = "white", background = "gray",
                           #                                                 padding.left = "10px",
                           #                                                 padding.right = "10px",
                           #                                                 border.radius = "5px")),
                           # `Percentage` = formatter("span",
                           #                                     style = x ~ style(color = "white", background = "blue",
                           #                                                       padding.left = "10px",
                           #                                                       padding.right = "10px",
                           #                                                       border.radius = "5px")),
                           # `Post-Harvest Avg Price` = formatter("span",
                           #                                      style = x ~ style(color = "white", background = "green",
                           #                                                        padding.left = "10px",
                           #                                                        padding.right = "10px",
                           #                                                        border.radius = "5px")),
                           
                           `Date` = formatter("span", style = ~ style(display = "block",
                                                                      "border-radius" = "2px",
                                                                      "padding" = "5px",
                                                                      "font.weight" = "bold",  
                                                                      "text-align" = "left"))))
  return(table)
}


# getSalesTable(Corn_CropYearObjects[[1]]$`Sales Summary`)





