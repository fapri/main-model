# Corn
# Price Objective
# Table Creation



library(formattable)

tables = list()
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

data = Corn_CropYearObjects[[1]][["Storage"]]
getTables(Corn_CropYearObjects[[1]][["Storage"]])

