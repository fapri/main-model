# Clusters Production by county

library(tidyverse)
library(tibble)
library(sf)
library(maps)
library(readxl)




corn_Production_List = readRDS(file = "Miscellaneous/Production By County/Data/Production_List_Corn.rds")
soybean_Production_List = readRDS(file = "Miscellaneous/Production By County/Data/Production_List_Soybeans.rds")
countyCenters = read_excel("Miscellaneous/Basis/County Centers.xlsx")


# Gets coordinates for Missouri counties
counties = st_as_sf(map("county", plot = FALSE, fill = TRUE))
counties = subset(counties, grepl("missouri", counties$ID))

# Isolates county name
splitCountyState = unlist(strsplit(counties$ID, ","))
splitCountyState = splitCountyState[!splitCountyState %in% "missouri"]

# Atttach county to coordinate data
counties$County = splitCountyState

countyCenters$County = tolower(countyCenters$County)

# Attach geographical information to basis
counties = merge(x = counties, y = countyCenters, by = "County", all = TRUE)





corn_Production_List[["2014"]]$County = tolower(corn_Production_List[["2014"]]$County)

corn = corn_Production_List[["2014"]]


corn = merge(x = counties, y = corn, by = "County", all.y = TRUE)


corn = data.frame(corn)

################################################################################
# Clustering - Latitude, Longitude, and Basis
################################################################################



# # K means clusters based on latitude, longitude, and basis
# kLocBasisMerge = data.frame()
# yearlyMerge$index = as.numeric(rownames(yearlyMerge))
# for (year in names(listOfYears)) {
#   colYear = paste("avgBasis", year, sep = "")
#   
#   kMeansLocBasis = list()
#   locBasisClusters = data.frame()
#   
#   
#   
#   kMeansLocBasis = kmeans(na.omit(corn[,c("Production", "Latitude", "Longitude")]), centers = 4, nstart = 25)
#   
#   
#   
#   locBasisClusters = data.frame(cluster = kMeansLocBasis$cluster)
#   colnames(locBasisClusters) = paste("cluster", year, sep = "")
#   locBasisClusters$index = as.numeric(rownames(locBasisClusters))
#   
#   # Merge location and basis data to the clusters
#   if (nrow(kLocBasisMerge) == 0) {
#     kLocBasisMerge = merge(x = yearlyMerge, y = locBasisClusters, by = "index", all = TRUE)
#   }
#   else {
#     kLocBasisMerge = merge(x = kLocBasisMerge, y = locBasisClusters, by = "index", all = TRUE)
#   }
# }






library(factoextra)


corn = data.frame(corn)



set.seed(1029)
# clusters = kmeans(na.omit(corn[,c(3,4,7)]), 20)
clusters = kmeans(na.omit(corn[, c("Latitude", "Longitude", "Production")]), centers = 6, nstart = 10)
# clusters = kmeans(na.omit(corn[, c("Production")]), centers = 4, nstart = 25)



fviz_cluster(clusters, data = corn[, c("Production", "Latitude", "Longitude")])

test = data.frame(na.omit(corn[, c("Production", "Latitude", "Longitude")]))

# Dissimilarity matrix
d <- dist(na.omit(corn[, c("Production", "Latitude", "Longitude")]), method = "euclidean")


# Ward's method
hc5 <- hclust(d = d, method = "ward.D2")

# Cut tree into 4 groups
sub_grp <- cutree(hc5, k = 6)


corn$Cluster = sub_grp


# Number of members in each cluster
table(sub_grp)


plot(hc5, cex = 0.6)
rect.hclust(hc5, k = 6, border = 2:5)



fviz_cluster(list(data = d, cluster = sub_grp))



corn$Cluster = clusters$cluster



# corn = merge(x = corn, y = counties, by = "County", all = TRUE)


# Convert data frame to sf
# CRITICAL FOR PLOTTING
corn = corn %>% as_tibble() %>% st_as_sf()
corn = corn %>% st_buffer(0)


# corn$County[which(corn$Cluster == 7)]



ggplot(counties) +
  geom_sf(fill = "white", color = "black", size = 0.5) +
  theme_void() +
  coord_sf(ndiscr = F) +
  geom_sf(data = corn, aes(fill = Production, geometry = geometry)) +
  scale_fill_distiller(palette = "RdYlGn", na.value = "White",
                       limits = c(-max(abs(min(corn$Production, na.rm = TRUE)),
                                       abs(max(corn$Production, na.rm = TRUE))) - 0.05,
                                  max(abs(min(corn$Production, na.rm = TRUE)),
                                      abs(max(corn$Production, na.rm = TRUE))) + 0.05), direction = "reverse") +
  geom_sf(fill = "transparent", size = 3, aes(color = levels(as.factor(corn$Cluster))),
          data = corn %>% group_by(Cluster) %>% summarise() %>% na.omit())






