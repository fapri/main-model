# Corn and Soybeans
# Plotting and working with clean data

library(tidyverse)
library(sf)
library(ggplot2)
library(rnaturalearth)
library(rnaturalearthdata)
library(rgeos)
library(tools)
library(maps)
library(stringi)
library(readxl)
library(readr)
library(tm)
library(Ckmeans.1d.dp)
library(grid)
library(gridExtra)
library(scales)
library(rhandsontable)
library(cowplot)

# Load data saved from the other basis script
Load_Data = function() {
  filePath = choose.files(default = paste0(getwd(), "/Miscellaneous/Basis/*.rds"), caption = "Select RDS Files:",
                          multi = FALSE, filters = Filters,
                          index = nrow(Filters))
  
  extenstion = file_ext(filePath)
  
  while (all(extenstion == "rds") == FALSE) {
    if (dlg_message(message = "File is not RDS! Quit?", type = "yesno")[["res"]] == "yes") {
      stop("Program Ending Now.")
    }
    filePath = NA
    extenstion = NA
    filePath = choose.files(default = paste0(getwd(), "/Miscellaneous/Basis/*.rds"), caption = "Select RDS Files:",
                            multi = FALSE, filters = Filters,
                            index = nrow(Filters))
    extenstion = file_ext(filePath)
  }
  
  return(filePath)
}

if (dlg_message(message = "Load Corn Merge Data?", type = "yesno")[["res"]] == "yes") {
  kLocBasisMergeCorn = read_rds(Load_Data())
}
if (dlg_message(message = "Load Corn Weekly Data?", type = "yesno")[["res"]] == "yes") {
  weeklyAverageListCorn = read_rds(Load_Data())
}
if (dlg_message(message = "Load Soybean Merge Data?", type = "yesno")[["res"]] == "yes") {
  kLocBasisMergeSoybeans = read_rds(Load_Data())
}
if (dlg_message(message = "Load Soybean Weekly Data?", type = "yesno")[["res"]] == "yes") {
  weeklyAverageListSoybeans = read_rds(Load_Data())
}


################################################################################
# Plotting WITHOUT Clusters
################################################################################

# Get minimum and maximum limits
kLocBasisMergeCorn = data.frame(kLocBasisMergeCorn)
minLimitCorn = round(min(na.omit(kLocBasisMergeCorn[, 2:7])) - 0.05, digits = 2)
maxLimitCorn = round(max(na.omit(kLocBasisMergeCorn[, 2:7])) + 0.05, digits = 2)

kLocBasisMergeSoybeans = data.frame(kLocBasisMergeSoybeans)
minLimitSoybeans = round(min(na.omit(kLocBasisMergeSoybeans[, 2:7])) - 0.05, digits = 2)
maxLimitSoybeans = round(max(na.omit(kLocBasisMergeSoybeans[, 2:7])) + 0.05, digits = 2)

minLimitCommon = min(minLimitCorn, minLimitSoybeans)
maxLimitCommon = max(maxLimitCorn, maxLimitSoybeans)

# Convert data frame to sf
# CRITICAL FOR PLOTTING
kLocBasisMergeCorn = kLocBasisMergeCorn %>% as_tibble() %>% st_as_sf()
kLocBasisMergeCorn = kLocBasisMergeCorn %>% st_buffer(0)

kLocBasisMergeSoybeans = kLocBasisMergeSoybeans %>% as_tibble() %>% st_as_sf()
kLocBasisMergeSoybeans = kLocBasisMergeSoybeans %>% st_buffer(0)

# Plot 3 Year Averages
heatPlotThreeYearAvgCorn = ggplot(kLocBasisMergeCorn) +
  geom_sf(fill = "white", color = "black", size = 0.5) +
  theme_void() +
  coord_sf(ndiscr = F) + 
  geom_sf(data = kLocBasisMergeCorn, aes(fill = threeYearAvg, geometry = geometry)) +
  scale_fill_distiller(palette = "Spectral", na.value = "White",
                       limits = c(minLimitCommon, maxLimitCommon), direction = "reverse", breaks = pretty_breaks(15)) +
  ggtitle(paste("Corn", sep = " ")) +
  labs(fill = "Basis (cents)") +
  theme(plot.title = element_text(hjust = 0.5, size = 30), legend.key.size = unit(2, "cm"))

heatPlotThreeYearAvgSoybeans = ggplot(kLocBasisMergeSoybeans) +
  geom_sf(fill = "white", color = "black", size = 0.5) +
  theme_void() +
  coord_sf(ndiscr = F) + 
  geom_sf(data = kLocBasisMergeSoybeans, aes(fill = threeYearAvg, geometry = geometry)) +
  scale_fill_distiller(palette = "Spectral", na.value = "White",
                       limits = c(minLimitCommon, maxLimitCommon), direction = "reverse") +
  ggtitle(paste("Soybeans", sep = " ")) +
  labs(fill = "Basis (cents)") +
  theme(plot.title = element_text(hjust = 0.5, size = 30), legend.position = "none")

thelegend = get_legend(heatPlotThreeYearAvgCorn)
heatPlotThreeYearAvgCorn = heatPlotThreeYearAvgCorn + theme(legend.position = "none")

grid.arrange(heatPlotThreeYearAvgCorn,
             heatPlotThreeYearAvgSoybeans,
             thelegend,
             ncol = 3,
             top = textGrob("Missouri 3-Year Average Basis", gp = gpar(fontsize = 40, font = 1)))
