# Corn 
# All Strategies
# Graphing

#Set Color Palette
myColors = c("#ffff00", "#ffff00","#800080", "#800080", "#ed7d31", "#4286f4", "#ff4242", "#FF69B4", "#000080", "#000080")
colorLabels = c("Price Objective", "Price Objective Special","Trailing Stop", "Trailing Stop Special", "Seasonal", "Ten Day High", "All Time High", "End of Year Trailing Stop", "Multiyear Year 1", "Multiyear Year 2")
names(myColors) = colorLabels 

# i = 1
# cropYear = Corn_CropYearObjects[[i]]$`Crop Year`
# startDate = mdy(Corn_CropYearObjects[[i]]$`Start Date`)
# stopDate = mdy(Corn_CropYearObjects[[i]]$`Stop Date`)
# marketingYear = Corn_CropYearObjects[[i]]$`Marketing Year MY`
# actualizedSales = Corn_CropYearObjects[[i]]$`PO Actualized MY`
# dynamicTitle = POMYTitle



plotMarketingYear = function(cropYear, startDate, stopDate, marketingYear, actualizedSales, dynamicTitle) {
  harvest = mdy(paste("09-01", toString(year(startDate)), sep="-"))
  marchUpdate1 = mdy(paste("03-01", toString(year(startDate)), sep="-"))
  marchUpdate2 = mdy(paste("03-01", toString(year(stopDate)), sep="-"))
  xcenter = c((startDate + floor((marchUpdate1 - startDate)/2)), (marchUpdate1 + floor((harvest - marchUpdate1)/2)), 
              (harvest + floor((marchUpdate2 - harvest)/2)), (marchUpdate2 + floor((stopDate - marchUpdate2)/2)))
  
  # initialize variables
  baseline = NA
  sixty = NA
  seventy = NA
  eighty = NA
  ninety = NA
  ninetyFive = NA
  
  # read in basis adjusted baseline values
  for(j in 1:4){
    baseline[j] = unique(marketingYear$Baseline)[j]
    sixty[j] = unique(marketingYear$`60th`)[j]
    seventy[j] = unique(marketingYear$`70th`)[j]
    eighty[j] = unique(marketingYear$`80th`)[j]
    ninety[j] = unique(marketingYear$`90th`)[j]
    ninetyFive[j] = unique(marketingYear$`95th`)[j]
  }
  
  # create a data frame for baseline values for each of the four segments
  baselineLines = data.frame(baseline, sixty, seventy, eighty, ninety, ninetyFive)
  
  segment_data = data.frame(x = c(startDate, marchUpdate1, harvest, marchUpdate2),
                            xgreen = c(startDate, marchUpdate1, harvest, marchUpdate2),
                            xcenter,
                            xend = c(marchUpdate1, harvest, marchUpdate2, stopDate), 
                            baselineLines)
  
  plot = ggplot(marketingYear, aes(x = mdy(Date), y = Price)) +
    geom_line(size = 0.5) +
    geom_point(data = actualizedSales, aes(x = Date, y = Price, fill = Type), shape = 21, size = 3, alpha = .75) +
    geom_vline(xintercept = as.Date(paste(year(startDate), "09-01", sep = "-")), linetype = 2) +
    xlab("Day") + ylab("Price") +
    ggtitle(paste(cropYear, dynamicTitle, sep = " ")) +
    scale_x_date(date_labels = "%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month") +
    
    geom_segment(data = segment_data[1:2,], aes(x = x, y = baseline, xend = xend, yend = baseline), linetype = 5) + 
    geom_text(data = segment_data[1:2,], aes(x = xcenter, y = baseline, fontface = "bold"), label = "Baseline", color = "#0000FF", size = 4) +
    geom_segment(data = segment_data[1:2,], aes(x = x, y = seventy, xend = xend, yend = seventy), linetype = 5) + 
    geom_text(data = segment_data[1:2,], aes(x = xcenter, y = seventy, fontface = "bold"), label = "70th", color = "#0000FF", size = 4) +
    geom_segment(data = segment_data[1:2,], aes(x = x, y = eighty, xend = xend, yend = eighty), linetype = 5) +
    geom_text(data = segment_data[1:2,], aes(x = xcenter, y = eighty, fontface = "bold"), label = "80th", color = "#0000FF", size = 4) +
    geom_segment(data = segment_data[1:2,], aes(x = x, y = ninety, xend = xend, yend = ninety), linetype = 5) +
    geom_text(data = segment_data[1:2,], aes(x = xcenter, y = ninety, fontface = "bold"), label = "90th", color = "#0000FF", size = 4) +
    geom_segment(data = segment_data[1:2,], aes(x = x, y = ninetyFive, xend = xend, yend = ninetyFive), linetype = 5) +
    geom_text(data = segment_data[1:2,], aes(x = xcenter, y = ninetyFive, fontface = "bold"), label = "95th", color = "#0000FF", size = 4) +
    geom_segment(data = segment_data[3:4,], aes(x = x, y = baseline, xend = xend, yend = baseline), linetype = 5) + 
    geom_text(data = segment_data[3:4,], aes(x = xcenter, y = baseline, fontface = "bold"), label = "Baseline", color = "#04dd04", size = 4) +
    geom_segment(data = segment_data[3:4,], aes(x = x, y = seventy, xend = xend, yend = seventy), linetype = 5) + 
    geom_text(data = segment_data[3:4,], aes(x = xcenter, y = seventy, fontface = "bold"), label = "70th", color = "#04dd04", size = 4) +
    geom_segment(data = segment_data[3:4,], aes(x = x, y = eighty, xend = xend, yend = eighty), linetype = 5) +
    geom_text(data = segment_data[3:4,], aes(x = xcenter, y = eighty, fontface = "bold"), label = "80th", color = "#04dd04", size = 4) +
    geom_segment(data = segment_data[3:4,], aes(x = x, y = ninety, xend = xend, yend = ninety), linetype = 5) +
    geom_text(data = segment_data[3:4,], aes(x = xcenter, y = ninety, fontface = "bold"), label = "90th", color = "#04dd04", size = 4) +
    geom_segment(data = segment_data[3:4,], aes(x = x, y = ninetyFive, xend = xend, yend = ninetyFive), linetype = 5) +
    geom_text(data = segment_data[3:4,], aes(x = xcenter, y = ninetyFive, fontface = "bold"), label = "95th", color = "#04dd04", size = 4) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = c(0.70, 0.75)) + 
    scale_fill_manual(name = "Sale", values = myColors) + 
    theme(legend.position="bottom")
  
  return(plot)
}

for(i in 1:length(Corn_CropYearObjects)) {
  POTitle = "Price Objective w/o Multi-Year"
  Corn_CropYearObjects[[i]]$POPlot = plotMarketingYear(Corn_CropYearObjects[[i]]$`Crop Year`,
                                                       mdy(Corn_CropYearObjects[[i]]$`Start Date`),
                                                       mdy(Corn_CropYearObjects[[i]]$`Stop Date`),
                                                       Corn_CropYearObjects[[i]]$`Marketing Year`,
                                                       Corn_CropYearObjects[[i]]$`PO Actualized`,
                                                       POTitle)
  
  POMYTitle = "Price Objective with Multi-Year"
  names(Corn_CropYearObjects[[i]]$`Marketing Year MY`) = names(Corn_CropYearObjects[[i]]$`Marketing Year`)
  Corn_CropYearObjects[[i]]$POMYPlot = plotMarketingYear(Corn_CropYearObjects[[i]]$`Crop Year`,
                                                       mdy(Corn_CropYearObjects[[i]]$`Start Date`),
                                                       mdy(Corn_CropYearObjects[[i]]$`Stop Date`),
                                                       Corn_CropYearObjects[[i]]$`Marketing Year MY`,
                                                       Corn_CropYearObjects[[i]]$`PO Actualized MY`,
                                                       POMYTitle)
  
  TSTitle = "Trailing Stop w/o Multi-Year"
  Corn_CropYearObjects[[i]]$TSPlot = plotMarketingYear(Corn_CropYearObjects[[i]]$`Crop Year`,
                                                       mdy(Corn_CropYearObjects[[i]]$`Start Date`),
                                                       mdy(Corn_CropYearObjects[[i]]$`Stop Date`),
                                                       Corn_CropYearObjects[[i]]$`Marketing Year`,
                                                       Corn_CropYearObjects[[i]]$`TS Actualized`,
                                                       TSTitle)
  
  SSTitle = "Seasonal Sales w/o Multi-Year"
  Corn_CropYearObjects[[i]]$SSPlot = plotMarketingYear(Corn_CropYearObjects[[i]]$`Crop Year`,
                                                       mdy(Corn_CropYearObjects[[i]]$`Start Date`),
                                                       mdy(Corn_CropYearObjects[[i]]$`Stop Date`),
                                                       Corn_CropYearObjects[[i]]$`Marketing Year`,
                                                       Corn_CropYearObjects[[i]]$`SS Actualized`,
                                                       SSTitle)
}
