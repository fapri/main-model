library(tidyverse)
library(sf)
library(ggplot2)
library(rnaturalearth)
library(tools)
library(maps)
library(stringi)
library(readxl)
library(readr)
library(tm)
library(Ckmeans.1d.dp)
library(gridExtra)

# Load files
test = read_csv("Miscellaneous/test.csv")
citiesCounties = read_excel("Miscellaneous/Cities and Counties.xlsx")
countyCenters = read_excel("Miscellaneous/County Centers.xlsx")

# mo = map('county', region = 'Missouri')

# Gets world geographic data
world = ne_countries(scale = "medium", returnclass = "sf")

# Plot point in a particular location
sites = data.frame(longitude = c(-95.76416, -89.08348), latitude = c(35.99894, 40.61698))

# Gets coordinates for all states
states = st_as_sf(map("state", plot = FALSE, fill = TRUE))
states = cbind(states, st_coordinates(st_centroid(states)))
states$ID = toTitleCase(states$ID)

# Plot Missouri with points
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = states, fill = NA) + 
  geom_point(data = sites, aes(x = longitude, y = latitude), size = 4, 
             shape = 23, fill = "darkred") +
  geom_text(data = states, aes(X, Y, label = ID), size = 5) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE)

# Clean text and get cities from K State data frame
test$City = gsub("MO", "", test$City, fixed = TRUE)
test$City = trimws(test$City, "r")
test$City = gsub(".", "", test$City, fixed = TRUE)
test$City = tolower(test$City)

# initialize column
test$County = NA

# Standardize data
citiesCounties$CITY = tolower(citiesCounties$CITY)
citiesCounties$COUNTY = tolower(citiesCounties$COUNTY)

# Matches counties to K State data
for (i in seq_len(nrow(citiesCounties))) {
  tempRows = which(test$City == citiesCounties$CITY[i])
  test$County[tempRows] = as.character(citiesCounties$COUNTY[i])
}

# Gets coordinates for Missouri counties
counties = st_as_sf(map("county", plot = FALSE, fill = TRUE))
counties = subset(counties, grepl("missouri", counties$ID))

# Isolates county name
splitCountyState = unlist(strsplit(counties$ID, ","))
splitCountyState = splitCountyState[!splitCountyState %in% "missouri"]

# Atttach county to coordinate data
counties$County = splitCountyState

# initialize variables
listOfYears = list()
averageBasisCounty = data.frame()
requiredYears = c("2019", "2018", "2017", "2016", "2015", "2014")
k
# Gets average basis for each county for every year
for (year in requiredYears) {
  years = which(grepl(year, colnames(test)))
  listOfYears[[year]] = test[, c(c(1, 14, 15, 16), c(years))]
  
  if (nrow(averageBasisCounty) == 0) {
    averageBasisCounty = setNames(aggregate(listOfYears[[year]][, 6],
                                            list(listOfYears[[year]]$County), 
                                            mean, na.rm = TRUE), 
                                  c("County", paste("avgBasis", year, sep = "")))
    
  } else {
    
    temp = setNames(aggregate(listOfYears[[year]][, 6], list(listOfYears[[year]]$County), mean, na.rm = TRUE), 
                    c("County", paste("avgBasis", year, sep = "")))
    averageBasisCounty = merge(x = averageBasisCounty, y = temp, by = "County", all = TRUE)
  }
}

# Gets average basis by county by week
weeklyAverages = data.frame()
weeklyAverages = setNames(aggregate(x = test[, 8:13],
                                    by = list(test$Week, test$County),
                                    FUN = mean,
                                    na.rm = TRUE),
                          c("Week", "County", "weeklyBasis2019", "weeklyBasis2018", "weeklyBasis2017", 
                            "weeklyBasis2016", "weeklyBasis2015", "weeklyBasis2014"))

# Merge average basis to geographic coordinates for plotting
yearlyMerge = merge(x = averageBasisCounty, y = counties, by = "County", all = TRUE)

# Replace NaN values with NA
for (column in 2:ncol(averageBasisCounty)) {
  averageBasisCounty[which(is.nan(averageBasisCounty[, column])), column] = NA
}

split_tibble = function(tibble, col = 'col') tibble %>% split(., .[,col])
weeklyAverageList = split_tibble(weeklyAverages, 'Week')
weeklyAverageList = lapply(names(weeklyAverageList), function(x) merge(x = weeklyAverageList[[x]], y = counties, by = "County", all = TRUE))

# Plot basis 2019
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = yearlyMerge, aes(fill = avgBasis2019, geometry = geometry)) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) + 
  scale_fill_distiller(palette = "RdYlGn", na.value = "White", 
                       limits = c(-max(abs(min(yearlyMerge$avgBasis2019, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2019, na.rm = TRUE))) - 0.05,
                                  max(abs(min(yearlyMerge$avgBasis2019, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2019, na.rm = TRUE))) + 0.05), direction = "reverse") + 
  ggtitle("Missouri - Corn Basis 2019") +
  labs(fill = "Basis (cents)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 30))

# Plot basis 2018
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = yearlyMerge, aes(fill = avgBasis2018, geometry = geometry)) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) + 
  scale_fill_distiller(palette = "RdYlGn", na.value = "White", 
                       limits = c(-max(abs(min(yearlyMerge$avgBasis2018, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2018, na.rm = TRUE))) - 0.05,
                                  max(abs(min(yearlyMerge$avgBasis2018, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2018, na.rm = TRUE))) + 0.05), direction = "reverse") + 
  ggtitle("Missouri - Corn Basis 2018") +
  labs(fill = "Basis (cents)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 30))

# Plot basis 2017
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = yearlyMerge, aes(fill = avgBasis2017, geometry = geometry)) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) + 
  scale_fill_distiller(palette = "RdYlGn", na.value = "White", 
                       limits = c(-max(abs(min(yearlyMerge$avgBasis2017, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2017, na.rm = TRUE))) - 0.05,
                                  max(abs(min(yearlyMerge$avgBasis2017, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2017, na.rm = TRUE))) + 0.05), direction = "reverse") + 
  ggtitle("Missouri - Corn Basis 2017") +
  labs(fill = "Basis (cents)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 30))

# Plot first week of 2019
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = weeklyAverageList[[1]], aes(fill = weeklyBasis2019, geometry = geometry)) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) + 
  scale_fill_distiller(palette = "RdYlGn", na.value = "White", 
                       limits = c(-max(abs(min(weeklyAverageList[[1]]$weeklyBasis2019, na.rm = TRUE)), abs(max(weeklyAverageList[[1]]$weeklyBasis2019, na.rm = TRUE))) - 0.05,
                                  max(abs(min(weeklyAverageList[[1]]$weeklyBasis2019, na.rm = TRUE)), abs(max(weeklyAverageList[[1]]$weeklyBasis2019, na.rm = TRUE))) + 0.05), direction = "reverse") + 
  ggtitle("Missouri - Weekly Corn Basis 2019") +
  labs(fill = "Basis (cents)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 30))

# Save all weekly plots for 2019
plots = list()
for (week in seq_len(length(weeklyAverageList))) {
  plots[[week]] = ggplot(data = world) +
    geom_sf() +
    geom_sf(data = weeklyAverageList[[week]], aes(fill = weeklyBasis2019, geometry = geometry)) +
    coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) + 
    scale_fill_distiller(palette = "RdYlGn", na.value = "White", 
                         limits = c(-max(abs(min(weeklyAverageList[[week]]$weeklyBasis2019, na.rm = TRUE)), abs(max(weeklyAverageList[[week]]$weeklyBasis2019, na.rm = TRUE))) - 0.05,
                                    max(abs(min(weeklyAverageList[[week]]$weeklyBasis2019, na.rm = TRUE)), abs(max(weeklyAverageList[[week]]$weeklyBasis2019, na.rm = TRUE))) + 0.05), direction = "reverse") + 
    ggtitle("Missouri - Weekly Corn Basis 2019") +
    labs(fill = "Basis (cents)") + 
    theme(plot.title = element_text(hjust = 0.5, size = 30))
}


#################################################################################
# Clustering - Strictly Geographical
#################################################################################

# Get data for only 2019 - yearly
lastYear = yearlyMerge[, c(1, 2, 8, 9)]
lastYear = yearlyMerge

# Format data
countyCenters$County = tolower(countyCenters$County)

# Attach geographical information to basis
lastYear = merge(x = lastYear, y = countyCenters, by = "County", all = TRUE)

# Get only latitude and longitude
lastYearLatLong = lastYear[,c("Latitude", "Longitude")]

# Determine number of strictly geographical clusters
wss = (nrow(lastYearLatLong) - 1) * sum(apply(lastYearLatLong, 2, var))
for (i in 2:100) wss[i] = sum(kmeans(lastYearLatLong, centers = i)$withinss)
plot(1:100, wss, type = "b", xlab = "Number of Clusters",
     ylab = "Within groups sum of squares")

# K-Means Cluster Analysis
set.seed(20)
fit = kmeans(lastYearLatLong, 6) # 6 clusters
# get cluster means
aggregate(lastYearLatLong, by = list(fit$cluster), FUN = mean)
# append cluster assignment
lastYearLatLong = data.frame(lastYearLatLong, fit$cluster)
lastYearLatLong$fit.cluster = as.factor(lastYearLatLong$fit.cluster)
ggplot(lastYearLatLong, aes(x = Longitude, y = Latitude, color = lastYearLatLong$fit.cluster)) + geom_point(size = 10)

# Plot geographical clusters over basis data for Missouri
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = weeklyAverageList[[week]], aes(fill = weeklyBasis2019, geometry = geometry)) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) + 
  scale_fill_distiller(palette = "RdYlGn", na.value = "White",
                       limits = c(-max(abs(min(weeklyAverageList[[week]]$weeklyBasis2019, na.rm = TRUE)), abs(max(weeklyAverageList[[week]]$weeklyBasis2019, na.rm = TRUE))) - 0.05,
                                  max(abs(min(weeklyAverageList[[week]]$weeklyBasis2019, na.rm = TRUE)), abs(max(weeklyAverageList[[week]]$weeklyBasis2019, na.rm = TRUE))) + 0.05), direction = "reverse") +
  ggtitle("Missouri - Weekly Corn Basis 2019") +
  labs(fill = "Basis (cents)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 30)) + 
  geom_point(data = lastYearLatLong, aes(x = Longitude, y = Latitude, size = 20, colour = lastYearLatLong$fit.cluster),
             alpha = 1)


################################################################################
# Clustering - Latitude, Longitude, and Basis
################################################################################

# K means clusters based on latitude, longitude, and basis
kLocBasisMerge = data.frame()
lastYear$index = as.numeric(rownames(lastYear))
for (year in names(listOfYears)) {
  colYear = paste("avgBasis", year, sep = "")
  
  kMeansLocBasis = list()
  locBasisClusters = data.frame()
  kMeansLocBasis = kmeans(na.omit(lastYear[,c(colYear, "Latitude", "Longitude")]), centers = 4, nstart = 25) # 4 clusters
  locBasisClusters = data.frame(cluster = kMeansLocBasis$cluster)
  colnames(locBasisClusters) = paste("cluster", year, sep = "")
  locBasisClusters$index = as.numeric(rownames(locBasisClusters))
  
  # Merge location and basis data to the clusters
  if (nrow(kLocBasisMerge) == 0) {
    kLocBasisMerge = merge(x = lastYear, y = locBasisClusters, by = "index", all = TRUE)
  }
  else {
    kLocBasisMerge = merge(x = kLocBasisMerge, y = locBasisClusters, by = "index", all = TRUE)
  }
}

# Get 3 and 5 year averages
kLocBasisMerge$threeYearAvg = rowMeans(kLocBasisMerge[, c("avgBasis2019", "avgBasis2018", "avgBasis2017")], na.rm = TRUE)
kLocBasisMerge$fiveYearAvg = rowMeans(kLocBasisMerge[, c("avgBasis2019", "avgBasis2018", "avgBasis2017", "avgBasis2016", "avgBasis2015")], na.rm = TRUE)

# Replace NaN values with NA
kLocBasisMerge$threeYearAvg[which(is.nan(kLocBasisMerge$threeYearAvg))] = NA
kLocBasisMerge$fiveYearAvg[which(is.nan(kLocBasisMerge$fiveYearAvg))] = NA

# 3 and 5 Year K means clusters based on latitude, longitude, and basis
longTermAverages = c("threeYearAvg", "fiveYearAvg")
for (term in longTermAverages) {
  kMeansLocBasis = list()
  locBasisClusters = data.frame()
  kMeansLocBasis = kmeans(na.omit(kLocBasisMerge[, c(term, "Latitude", "Longitude")]), centers = 4, nstart = 25) # 4 clusters
  locBasisClusters = data.frame(cluster = kMeansLocBasis$cluster)
  colnames(locBasisClusters) = paste("cluster", term, sep = "")
  locBasisClusters$index = as.numeric(rownames(locBasisClusters))
  kLocBasisMerge = merge(x = kLocBasisMerge, y = locBasisClusters, by = "index", all = TRUE)
}

################################################################################
# Clean Data
################################################################################

clusterNames = c("cluster2019", "cluster2018", "cluster2017", "cluster2016", "cluster2015", "cluster2014")

# aggregate(kLocBasisMerge$avgBasis2019, by = list(kLocBasisMerge$cluster2019), FUN = mean)

# Standardize the clusters
for (i in 1) {
  kLocBasisMerge = kLocBasisMerge %>% 
    mutate(cluster2018 = case_when(
      cluster2018 == 1 ~ 3,
      cluster2018 == 4 ~ 1,
      cluster2018 == 2 ~ 2,
      cluster2018 == 3 ~ 4))
  
  kLocBasisMerge = kLocBasisMerge %>% 
    mutate(cluster2017 = case_when(
      cluster2017 == 4 ~ 3,
      cluster2017 == 1 ~ 1,
      cluster2017 == 3 ~ 2,
      cluster2017 == 2 ~ 4))
  
  kLocBasisMerge = kLocBasisMerge %>% 
    mutate(cluster2016 = case_when(
      cluster2016 == 2 ~ 3,
      cluster2016 == 3 ~ 1,
      cluster2016 == 1 ~ 2,
      cluster2016 == 4 ~ 4))
  
  kLocBasisMerge = kLocBasisMerge %>% 
    mutate(cluster2015 = case_when(
      cluster2015 == 2 ~ 3,
      cluster2015 == 1 ~ 1,
      cluster2015 == 4 ~ 2,
      cluster2015 == 3 ~ 4))
  
  kLocBasisMerge = kLocBasisMerge %>% 
    mutate(cluster2014 = case_when(
      cluster2014 == 2 ~ 3,
      cluster2014 == 1 ~ 1,
      cluster2014 == 4 ~ 2,
      cluster2014 == 3 ~ 4))
  
  kLocBasisMerge = kLocBasisMerge %>% 
    mutate(clusterfiveYearAvg = case_when(
      clusterfiveYearAvg == 1 ~ 4,
      clusterfiveYearAvg == 2 ~ 1,
      clusterfiveYearAvg == 3 ~ 2,
      clusterfiveYearAvg == 4 ~ 3))
}

# Get average basis for each cluster
avg = data.frame()
for (clusterName in clusterNames) {
  Col = grep(str_extract_all(clusterName, "\\d+")[[1]], colnames(kLocBasisMerge))[1]
  Year = str_extract_all(clusterName, "\\d+")[[1]]
  for (i in 1:4) { # 4 clusters
    avg = rbind(avg, data.frame(year = Year, 
                                clusterName = i, 
                                avgBasis = mean(kLocBasisMerge[which(kLocBasisMerge[, clusterName] == i), Col], na.rm = TRUE)))
  }
}

################################################################################
# Plotting
################################################################################

# Convert data frame to sf
# CRITICAL FOR PLOTTING
kLocBasisMerge = kLocBasisMerge %>% as_tibble() %>% st_as_sf()
kLocBasisMerge = kLocBasisMerge %>% st_buffer(0)

# Plot maps for all years
clusterPlot = list()
for (i in 1) {
  clusterPlot2019 = ggplot(kLocBasisMerge) +
           geom_sf(fill = "white", color = "black", size = 0.5) +
           theme_void() +
           coord_sf(ndiscr = F) + 
           geom_sf(data = yearlyMerge, aes(fill = avgBasis2019, geometry = geometry)) +
           scale_fill_distiller(palette = "RdYlGn", na.value = "White",
                                limits = c(-max(abs(min(yearlyMerge$avgBasis2019, na.rm = TRUE)),
                                                abs(max(yearlyMerge$avgBasis2019, na.rm = TRUE))) - 0.05,
                                           max(abs(min(yearlyMerge$avgBasis2019, na.rm = TRUE)),
                                               abs(max(yearlyMerge$avgBasis2019, na.rm = TRUE))) + 0.05), direction = "reverse") +
           ggtitle(paste("Missouri - Corn Basis 2019", sep = " ")) +
           labs(fill = "Basis (cents)") +
           theme(plot.title = element_text(hjust = 0.5, size = 30)) + 
           geom_sf(fill = "transparent", size = 3, aes(color = as.factor(cluster2019)),
                   data = . %>% group_by(cluster2019) %>% summarise() %>% na.omit()) + 
           
           scale_colour_manual(name = "Clusters",
                               values = c("#FB61D7", "#00B6EB", "#53B400", "#A58AFF"),
                               breaks = c("1", "2", "3", "4"),
                               labels = c(paste("Cluster 1 Avg: $", round(avg$avgBasis[which(avg$year == 2019 & avg$clusterName == 1)], digits = 2)), 
                                          paste("Cluster 2 Avg: $", round(avg$avgBasis[which(avg$year == 2019 & avg$clusterName == 2)], digits = 2)), 
                                          paste("Cluster 3 Avg: $", round(avg$avgBasis[which(avg$year == 2019 & avg$clusterName == 3)], digits = 2)), 
                                          paste("Cluster 4 Avg: $", round(avg$avgBasis[which(avg$year == 2019 & avg$clusterName == 4)], digits = 2))))
  
  clusterPlot2018 = ggplot(kLocBasisMerge) +
           geom_sf(fill = "white", color = "black", size = 0.5) +
           theme_void() +
           coord_sf(ndiscr = F) + 
           geom_sf(data = yearlyMerge, aes(fill = avgBasis2018, geometry = geometry)) +
           scale_fill_distiller(palette = "RdYlGn", na.value = "White",
                                limits = c(-max(abs(min(yearlyMerge$avgBasis2018, na.rm = TRUE)),
                                                abs(max(yearlyMerge$avgBasis2018, na.rm = TRUE))) - 0.05,
                                           max(abs(min(yearlyMerge$avgBasis2018, na.rm = TRUE)),
                                               abs(max(yearlyMerge$avgBasis2018, na.rm = TRUE))) + 0.05), direction = "reverse") +
           ggtitle(paste("Missouri - Corn Basis 2018", sep = " ")) +
           labs(fill = "Basis (cents)") +
           theme(plot.title = element_text(hjust = 0.5, size = 30)) + 
           geom_sf(fill = "transparent", size = 3, aes(color = as.factor(cluster2018)),
                   data = . %>% group_by(cluster2018) %>% summarise() %>% na.omit()) + 
           
           scale_colour_manual(name = "Clusters",
                               values = c("#FB61D7", "#00B6EB", "#53B400", "#A58AFF"),
                               breaks = c("1", "2", "3", "4"),
                               labels = c(paste("Cluster 1 Avg: $", round(avg$avgBasis[which(avg$year == 2018 & avg$clusterName == 1)], digits = 2)), 
                                          paste("Cluster 2 Avg: $", round(avg$avgBasis[which(avg$year == 2018 & avg$clusterName == 2)], digits = 2)), 
                                          paste("Cluster 3 Avg: $", round(avg$avgBasis[which(avg$year == 2018 & avg$clusterName == 3)], digits = 2)), 
                                          paste("Cluster 4 Avg: $", round(avg$avgBasis[which(avg$year == 2018 & avg$clusterName == 4)], digits = 2))))
  
  clusterPlot2017 = ggplot(kLocBasisMerge) +
           geom_sf(fill = "white", color = "black", size = 0.5) +
           theme_void() +
           coord_sf(ndiscr = F) + 
           geom_sf(data = yearlyMerge, aes(fill = avgBasis2017, geometry = geometry)) +
           scale_fill_distiller(palette = "RdYlGn", na.value = "White",
                                limits = c(-max(abs(min(yearlyMerge$avgBasis2017, na.rm = TRUE)),
                                                abs(max(yearlyMerge$avgBasis2017, na.rm = TRUE))) - 0.05,
                                           max(abs(min(yearlyMerge$avgBasis2017, na.rm = TRUE)),
                                               abs(max(yearlyMerge$avgBasis2017, na.rm = TRUE))) + 0.05), direction = "reverse") +
           ggtitle(paste("Missouri - Corn Basis 2017", sep = " ")) +
           labs(fill = "Basis (cents)") +
           theme(plot.title = element_text(hjust = 0.5, size = 30)) + 
           geom_sf(fill = "transparent", size = 3, aes(color = as.factor(cluster2017)),
                   data = . %>% group_by(cluster2017) %>% summarise() %>% na.omit()) + 
           
           scale_colour_manual(name = "Clusters",
                               values = c("#FB61D7", "#00B6EB", "#53B400", "#A58AFF"),
                               breaks = c("1", "2", "3", "4"),
                               labels = c(paste("Cluster 1 Avg: $", round(avg$avgBasis[which(avg$year == 2017 & avg$clusterName == 1)], digits = 2)), 
                                          paste("Cluster 2 Avg: $", round(avg$avgBasis[which(avg$year == 2017 & avg$clusterName == 2)], digits = 2)), 
                                          paste("Cluster 3 Avg: $", round(avg$avgBasis[which(avg$year == 2017 & avg$clusterName == 3)], digits = 2)), 
                                          paste("Cluster 4 Avg: $", round(avg$avgBasis[which(avg$year == 2017 & avg$clusterName == 4)], digits = 2))))
  
  clusterPlot2016 = ggplot(kLocBasisMerge) +
           geom_sf(fill = "white", color = "black", size = 0.5) +
           theme_void() +
           coord_sf(ndiscr = F) + 
           geom_sf(data = yearlyMerge, aes(fill = avgBasis2016, geometry = geometry)) +
           scale_fill_distiller(palette = "RdYlGn", na.value = "White",
                                limits = c(-max(abs(min(yearlyMerge$avgBasis2016, na.rm = TRUE)),
                                                abs(max(yearlyMerge$avgBasis2016, na.rm = TRUE))) - 0.05,
                                           max(abs(min(yearlyMerge$avgBasis2016, na.rm = TRUE)),
                                               abs(max(yearlyMerge$avgBasis2016, na.rm = TRUE))) + 0.05), direction = "reverse") +
           ggtitle(paste("Missouri - Corn Basis 2016", sep = " ")) +
           labs(fill = "Basis (cents)") +
           theme(plot.title = element_text(hjust = 0.5, size = 30)) + 
           geom_sf(fill = "transparent", size = 3, aes(color = as.factor(cluster2016)),
                   data = . %>% group_by(cluster2016) %>% summarise() %>% na.omit()) + 
           
           scale_colour_manual(name = "Clusters",
                               values = c("#FB61D7", "#00B6EB", "#53B400", "#A58AFF"),
                               breaks = c("1", "2", "3", "4"),
                               labels = c(paste("Cluster 1 Avg: $", round(avg$avgBasis[which(avg$year == 2016 & avg$clusterName == 1)], digits = 2)), 
                                          paste("Cluster 2 Avg: $", round(avg$avgBasis[which(avg$year == 2016 & avg$clusterName == 2)], digits = 2)), 
                                          paste("Cluster 3 Avg: $", round(avg$avgBasis[which(avg$year == 2016 & avg$clusterName == 3)], digits = 2)), 
                                          paste("Cluster 4 Avg: $", round(avg$avgBasis[which(avg$year == 2016 & avg$clusterName == 4)], digits = 2))))
  
  clusterPlot2015 = ggplot(kLocBasisMerge) +
           geom_sf(fill = "white", color = "black", size = 0.5) +
           theme_void() +
           coord_sf(ndiscr = F) + 
           geom_sf(data = yearlyMerge, aes(fill = avgBasis2015, geometry = geometry)) +
           scale_fill_distiller(palette = "RdYlGn", na.value = "White",
                                limits = c(-max(abs(min(yearlyMerge$avgBasis2015, na.rm = TRUE)),
                                                abs(max(yearlyMerge$avgBasis2015, na.rm = TRUE))) - 0.05,
                                           max(abs(min(yearlyMerge$avgBasis2015, na.rm = TRUE)),
                                               abs(max(yearlyMerge$avgBasis2015, na.rm = TRUE))) + 0.05), direction = "reverse") +
           ggtitle(paste("Missouri - Corn Basis 2015", sep = " ")) +
           labs(fill = "Basis (cents)") +
           theme(plot.title = element_text(hjust = 0.5, size = 30)) + 
           geom_sf(fill = "transparent", size = 3, aes(color = as.factor(cluster2015)),
                   data = . %>% group_by(cluster2015) %>% summarise() %>% na.omit()) + 
           
           scale_colour_manual(name = "Clusters",
                               values = c("#FB61D7", "#00B6EB", "#53B400", "#A58AFF"),
                               breaks = c("1", "2", "3", "4"),
                               labels = c(paste("Cluster 1 Avg: $", round(avg$avgBasis[which(avg$year == 2015 & avg$clusterName == 1)], digits = 2)), 
                                          paste("Cluster 2 Avg: $", round(avg$avgBasis[which(avg$year == 2015 & avg$clusterName == 2)], digits = 2)), 
                                          paste("Cluster 3 Avg: $", round(avg$avgBasis[which(avg$year == 2015 & avg$clusterName == 3)], digits = 2)), 
                                          paste("Cluster 4 Avg: $", round(avg$avgBasis[which(avg$year == 2015 & avg$clusterName == 4)], digits = 2))))
  
  clusterPlot2014 = ggplot(kLocBasisMerge) +
           geom_sf(fill = "white", color = "black", size = 0.5) +
           theme_void() +
           coord_sf(ndiscr = F) + 
           geom_sf(data = yearlyMerge, aes(fill = avgBasis2014, geometry = geometry)) +
           scale_fill_distiller(palette = "RdYlGn", na.value = "White",
                                limits = c(-max(abs(min(yearlyMerge$avgBasis2014, na.rm = TRUE)),
                                                abs(max(yearlyMerge$avgBasis2014, na.rm = TRUE))) - 0.05,
                                           max(abs(min(yearlyMerge$avgBasis2014, na.rm = TRUE)),
                                               abs(max(yearlyMerge$avgBasis2014, na.rm = TRUE))) + 0.05), direction = "reverse") +
           ggtitle(paste("Missouri - Corn Basis 2014", sep = " ")) +
           labs(fill = "Basis (cents)") +
           theme(plot.title = element_text(hjust = 0.5, size = 30)) + 
           geom_sf(fill = "transparent", size = 3, aes(color = as.factor(cluster2014)),
                   data = . %>% group_by(cluster2014) %>% summarise() %>% na.omit()) + 
           
           scale_colour_manual(name = "Clusters",
                               values = c("#FB61D7", "#00B6EB", "#53B400", "#A58AFF"),
                               breaks = c("1", "2", "3", "4"),
                               labels = c(paste("Cluster 1 Avg: $", round(avg$avgBasis[which(avg$year == 2014 & avg$clusterName == 1)], digits = 2)), 
                                          paste("Cluster 2 Avg: $", round(avg$avgBasis[which(avg$year == 2014 & avg$clusterName == 2)], digits = 2)), 
                                          paste("Cluster 3 Avg: $", round(avg$avgBasis[which(avg$year == 2014 & avg$clusterName == 3)], digits = 2)), 
                                          paste("Cluster 4 Avg: $", round(avg$avgBasis[which(avg$year == 2014 & avg$clusterName == 4)], digits = 2))))
  
  # Plot 3 Year Average
  clusterPlotThreeYearAvg = ggplot(kLocBasisMerge) +
    geom_sf(fill = "white", color = "black", size = 0.5) +
    theme_void() +
    coord_sf(ndiscr = F) + 
    geom_sf(data = kLocBasisMerge, aes(fill = threeYearAvg, geometry = geometry)) +
    scale_fill_distiller(palette = "RdYlGn", na.value = "White",
                         limits = c(-max(abs(min(kLocBasisMerge$threeYearAvg, na.rm = TRUE)),
                                         abs(max(kLocBasisMerge$threeYearAvg, na.rm = TRUE))) - 0.05,
                                    max(abs(min(kLocBasisMerge$threeYearAvg, na.rm = TRUE)),
                                        abs(max(kLocBasisMerge$threeYearAvg, na.rm = TRUE))) + 0.05), direction = "reverse") +
    ggtitle(paste("Missouri - Corn Basis 2017 - 2019", sep = " ")) +
    labs(fill = "Basis (cents)") +
    theme(plot.title = element_text(hjust = 0.5, size = 30)) + 
    geom_sf(fill = "transparent", size = 3, aes(color = as.factor(clusterthreeYearAvg)),
            data = . %>% group_by(clusterthreeYearAvg) %>% summarise() %>% na.omit()) + 
    
    scale_colour_manual(name = "Clusters",
                        values = c("#FB61D7", "#00B6EB", "#53B400", "#A58AFF"),
                        breaks = c("1", "2", "3", "4"),
                        labels = c(paste("Cluster 1 Avg: $", round(mean(kLocBasisMerge$threeYearAvg[which(kLocBasisMerge$clusterthreeYearAvg == 1)]), digits = 2)), 
                                   paste("Cluster 2 Avg: $", round(mean(kLocBasisMerge$threeYearAvg[which(kLocBasisMerge$clusterthreeYearAvg == 2)]), digits = 2)), 
                                   paste("Cluster 3 Avg: $", round(mean(kLocBasisMerge$threeYearAvg[which(kLocBasisMerge$clusterthreeYearAvg == 3)]), digits = 2)), 
                                   paste("Cluster 4 Avg: $", round(mean(kLocBasisMerge$threeYearAvg[which(kLocBasisMerge$clusterthreeYearAvg == 4)]), digits = 2))))
  
  # Plot 5 Year Average
  clusterPlotFiveYearAvg = ggplot(kLocBasisMerge) +
    geom_sf(fill = "white", color = "black", size = 0.5) +
    theme_void() +
    coord_sf(ndiscr = F) + 
    geom_sf(data = kLocBasisMerge, aes(fill = fiveYearAvg, geometry = geometry)) +
    scale_fill_distiller(palette = "RdYlGn", na.value = "White",
                         limits = c(-max(abs(min(kLocBasisMerge$fiveYearAvg, na.rm = TRUE)),
                                         abs(max(kLocBasisMerge$fiveYearAvg, na.rm = TRUE))) - 0.05,
                                    max(abs(min(kLocBasisMerge$fiveYearAvg, na.rm = TRUE)),
                                        abs(max(kLocBasisMerge$fiveYearAvg, na.rm = TRUE))) + 0.05), direction = "reverse") +
    ggtitle(paste("Missouri - Corn Basis 2015 - 2019", sep = " ")) +
    labs(fill = "Basis (cents)") +
    theme(plot.title = element_text(hjust = 0.5, size = 30)) + 
    geom_sf(fill = "transparent", size = 3, aes(color = as.factor(clusterfiveYearAvg)),
            data = . %>% group_by(clusterfiveYearAvg) %>% summarise() %>% na.omit()) + 
    
    scale_colour_manual(name = "Clusters",
                        values = c("#FB61D7", "#00B6EB", "#53B400", "#A58AFF"),
                        breaks = c("1", "2", "3", "4"),
                        labels = c(paste("Cluster 1 Avg: $", round(mean(kLocBasisMerge$fiveYearAvg[which(kLocBasisMerge$clusterfiveYearAvg == 1)]), digits = 2)), 
                                   paste("Cluster 2 Avg: $", round(mean(kLocBasisMerge$fiveYearAvg[which(kLocBasisMerge$clusterfiveYearAvg == 2)]), digits = 2)), 
                                   paste("Cluster 3 Avg: $", round(mean(kLocBasisMerge$fiveYearAvg[which(kLocBasisMerge$clusterfiveYearAvg == 3)]), digits = 2)), 
                                   paste("Cluster 4 Avg: $", round(mean(kLocBasisMerge$fiveYearAvg[which(kLocBasisMerge$clusterfiveYearAvg == 4)]), digits = 2))))
}

# Plot all yearly cluster
grid.arrange(clusterPlot2019,
             clusterPlot2018,
             clusterPlot2017,
             clusterPlot2016,
             clusterPlot2015,
             clusterPlot2014)

# plot 3 and 5 year clusters
grid.arrange(clusterPlotThreeYearAvg,
             clusterPlotFiveYearAvg)













#############################################################################################################################################
#############################################################################################################################################
# Additional methods with single years

# Get just basis values
justBasisDf = data.frame(avgBasis = lastYear$avgBasis2019, index = rownames(lastYear))
justBasisDf = na.omit(justBasisDf)

# Divide basis values into 3 clusters
k = 3
result = Ckmeans.1d.dp(justBasisDf$avgBasis, k)
plot(result)
justBasis = justBasisDf$avgBasis

# Plot one dimensional clusters
plot(justBasis, col = result$cluster, pch = result$cluster, cex = 1.5,
     main = "Optimal univariate clustering given k",
     sub = paste("Number of clusters given:", k))
abline(h = result$centers, col = 1:k, lty = "dashed", lwd = 2)
legend("bottomright", paste("Cluster", 1:k), col = 1:k, pch = 1:k, cex = 1.5, bty = "n")

# Merge one dimensional clusters to basis data
justBasisDf = data.frame(justBasisDf, result$cluster)
lastYear$index = as.numeric(rownames(lastYear))
clusterMerge = merge(x = lastYear, y = justBasisDf[, c(2,3)], by = "index", all = TRUE)

# Plot one dimensional cluster results
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = yearlyMerge, aes(fill = avgBasis2019, geometry = geometry)) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) + 
  scale_fill_distiller(palette = "RdYlGn", na.value = "White", 
                       limits = c(-max(abs(min(yearlyMerge$avgBasis2019, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2019, na.rm = TRUE))) - 0.05,
                                  max(abs(min(yearlyMerge$avgBasis2019, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2019, na.rm = TRUE))) + 0.05), direction = "reverse") + 
  ggtitle("Missouri - Corn Basis 2019") +
  labs(fill = "Basis (cents)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 30)) + 
  geom_point(data = clusterMerge, aes(x = Longitude, y = Latitude, size = 20, colour = as.factor(result.cluster)),
             alpha = 1)

#################################################################################


# Tree-based clustering methods
library(cluster)    # clustering algorithms
library(factoextra) # clustering visualization
library(dendextend) # for comparing two dendrograms

# Get data for only 2019 - yearly
lastYear = yearlyMerge[, c(1, 2, 8, 9)]

# Format data
countyCenters$County = tolower(countyCenters$County)

# Attach geographical information to basis
lastYear = merge(x = lastYear, y = countyCenters, by = "County", all = TRUE)

# Dissimilarity matrix
d = dist(na.omit(lastYear[, c(2,5,6)]), method = "euclidean")

# Hierarchical clustering using Complete Linkage
hc1 = hclust(d, method = "complete")

# Plot the obtained dendrogram
plot(hc1, cex = 0.6, hang = -1)

# Compute with agnes
hc2 = agnes(na.omit(lastYear[, c(2,5,6)]), method = "complete")

# Agglomerative coefficient
hc2$ac

df = na.omit(lastYear[, c(2,5,6)])

# methods to assess
m = c( "average", "single", "complete", "ward")
names(m) = c( "average", "single", "complete", "ward")

# function to compute coefficient
ac = function(x) {
  agnes(df, method = x)$ac
}

map_dbl(m, ac)

hc3 = agnes(df, method = "ward")
pltree(hc3, cex = 0.6, hang = -1, main = "Dendrogram of agnes") 

# compute divisive hierarchical clustering
hc4 = diana(df)

# Divise coefficient; amount of clustering structure found
hc4$dc

# plot dendrogram
pltree(hc4, cex = 0.6, hang = -1, main = "Dendrogram of diana")

# Ward's method
hc5 = hclust(d, method = "ward.D2")

# Cut tree into 4 groups
sub_grp = cutree(hc5, k = 5)

# Number of members in each cluster
table(sub_grp)

df$index = rownames(df)
newDF = df %>%
  mutate(cluster = sub_grp)

plot(hc5, cex = 0.6)
rect.hclust(hc5, k = 6, border = 2:5)

fviz_cluster(list(data = df, cluster = sub_grp))

# Cut agnes() tree into 4 groups
hc_a = agnes(df, method = "ward")
cutree(as.hclust(hc_a), k = 4)

# Cut diana() tree into 4 groups
hc_d = diana(df)
cutree(as.hclust(hc_d), k = 4)

# Compute distance matrix
res.dist = dist(df, method = "euclidean")

# Compute 2 hierarchical clusterings
hc1 = hclust(res.dist, method = "complete")
hc2 = hclust(res.dist, method = "ward.D2")

# Create two dendrograms
dend1 = as.dendrogram(hc1)
dend2 = as.dendrogram(hc2)

tanglegram(dend1, dend2)

dend_list = dendlist(dend1, dend2)

tanglegram(dend1, dend2,
           highlight_distinct_edges = FALSE, # Turn-off dashed lines
           common_subtrees_color_lines = FALSE, # Turn-off line colors
           common_subtrees_color_branches = TRUE, # Color common branches 
           main = paste("entanglement =", round(entanglement(dend_list), 2))
)

fviz_nbclust(df, FUN = hcut, method = "wss")

fviz_nbclust(df, FUN = hcut, method = "silhouette")

gap_stat = clusGap(df, FUN = hcut, nstart = 25, K.max = 10, B = 50)
fviz_gap_stat(gap_stat)

lastYear$index = as.numeric(rownames(lastYear))
treeMerge = merge(x = lastYear, y = newDF[, c(4,5)], by = "index", all = TRUE)

# Plot one dimensional cluster results
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = yearlyMerge, aes(fill = avgBasis2019, geometry = geometry)) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) + 
  scale_fill_distiller(palette = "RdYlGn", na.value = "White", 
                       limits = c(-max(abs(min(yearlyMerge$avgBasis2019, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2019, na.rm = TRUE))) - 0.05,
                                  max(abs(min(yearlyMerge$avgBasis2019, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2019, na.rm = TRUE))) + 0.05), direction = "reverse") + 
  ggtitle("Missouri - Corn Basis 2019") +
  labs(fill = "Basis (cents)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 30)) + 
  geom_point(data = treeMerge, aes(x = Longitude, y = Latitude, size = 20, colour = as.factor(cluster)),
             alpha = 1)


#############################################################################################################################################
#############################################################################################################################################


mo = tigris::counties(state = "Missouri", cb = T, class = "sf")
ggplot(mo) +
  geom_sf(fill = "gray95", color = "gray50", size = 0.5) +
  # these 2 lines just clean up appearance
  theme_void() +
  coord_sf(ndiscr = F)
mo %>%
  group_by(COUNTYFP) %>%
  summarise()












