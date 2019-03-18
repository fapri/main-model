
source("Corn/Main.R")

# Finds actualized Price Objective sales
isActualized = function(cropYear){
  priceObjectiveActualized = data.frame(matrix(ncol = 4, nrow = 0))
  priceObjectiveActualizedPost = data.frame(matrix(ncol = 4, nrow = 0))
  colnames(priceObjectiveActualized) = c("Date", "Percentile", "Type", "PercentSold")
  
  marketingYear = cropYear[['Marketing Year']]
  marketingYear$Date = mdy(marketingYear$Date)
  triggers = cropYear[['PO Triggers']]
  intervalPre = cropYear$`Pre/Post Interval`$intervalPre
  intervalPost = cropYear$`Pre/Post Interval`$intervalPost
  percentSold = 0
  
  for(row in 1:nrow(marketingYear)){
    #check if the day is a trigger date
    if(marketingYear$Date[row] %in% triggers$Date){
      #find trigger row
      tRow = which(marketingYear$Date[row] == triggers$Date)
      #check if preharvest
      if(triggers$Date[tRow] %within% intervalPre){
        #check if sale was made in last 7 days
        if(nrow(priceObjectiveActualized) == 0 || difftime(triggers$Date[tRow], priceObjectiveActualized$Date[nrow(priceObjectiveActualized)]) >= 7){
          #if < 50% sold
          if(percentSold < 50){
            #if sale has not been made in that percentile yet
            if(!(triggers$Percentile[tRow] %in% priceObjectiveActualized$Percentile)){
              #PO, ATH, TDH at 10% increments
              percentSold = percentSold + 10
              priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                    "Percentile" = triggers$Percentile[tRow],
                                                                                     "Type" = triggers$Type[tRow],
                                                                                     "Percent Sold" = percentSold))
            }
          }
        }
      }
  
      #check if postharvest
      else if(triggers$Date[tRow] %within% intervalPost){
        #check if in postharvest and before january
        month = month(triggers$Date[tRow])
        if(month == 9 || month == 10 || month == 11 || month == 12){
          #if > 0% of crop remains
          if(percentSold < 100){
            #if day not within 7 days of last sale
            if(difftime(triggers$Date[tRow], priceObjectiveActualized$Date[nrow(priceObjectiveActualized)]) >= 7){
              #if >=10% of crop remains
              if(percentSold <= 90){
                #check if this percentile has had a sale yet
                if(!(triggers$Percentile[tRow] %in% priceObjectiveActualizedPost$Percentile)){
                  #PO, ATH, TDH at 10% increments
                  percentSold = percentSold + 10
                  priceObjectiveActualizedPost = rbind(priceObjectiveActualizedPost, data.frame("Date" = triggers$Date[tRow], 
                                                                                            "Percentile" = triggers$Percentile[tRow],
                                                                                            "Type" = triggers$Type[tRow],
                                                                                            "Percent Sold" = percentSold))
                }
              }
            }
          }
        }
  
        #if > 0% of crop remains
        else if(percentSold < 100){
          #if day not within 7 days of last sale
          if(difftime(triggers$Date[tRow], priceObjectiveActualizedPost$Date[nrow(priceObjectiveActualizedPost)]) >= 7){
            #if >=10% of crop remains
            if(percentSold <= 90){
              #PO, TDH, ATH sale at 10% interval
              percentSold = percentSold + 10
              priceObjectiveActualizedPost = rbind(priceObjectiveActualizedPost, data.frame("Date" = triggers$Date[tRow], 
                                                                                        "Percentile" = triggers$Percentile[tRow],
                                                                                        "Type" = triggers$Type[tRow],
                                                                                        "Percent Sold" = percentSold))
            }
            
            # else sell remaining crop. DO WE NEED THIS????
            else{
              percentSold = 100
              priceObjectiveActualizedPost = rbind(priceObjectiveActualizedPost, data.frame("Date" = triggers$Date[tRow], 
                                                                                        "Percentile" = triggers$Percentile[tRow],
                                                                                        "Type" = triggers$Type[tRow],
                                                                                        "Percent Sold" = percentSold))
            }
          }
        }
      }
      
    #SEASONAL SALES
    #else if the remaining crop is less than or equal to 30%
    # else if(percentSold <= 70){
    #   #if month is march seasonal sale month OR june seasonal sale month
    #   if(month(marketingYear$Date[row]) == 3 || month(marketingYear$Date[row]) == 6){
    #     #if the day is within a seasonal sale date
    #     day = day(marketingYear$Date[row])
    #     if(day == 10 || day == 11 || day == 12 || day = 13 || day = 20 || day == 21 || day == 22 || day = 23){
    #       #if price < 70 percentile
    #       #LESS THAN OR EQUAL TO?????????
    #       if(marketingYear$Percentile < 70){
    #         #sell percent of crop left/number of season sale days left
    #         seasonSell = 100 - percentSold
    #         seasonDaysLeft = sum(priceObjectiveActualized$Type = )
    #         seasonSell = seasonSell/
    #         percentSold = percentSold + seasonSell
    #         priceObjectiveActualizedPost = rbind(priceObjectiveActualizedPost, data.frame("Date" = marketingYear$Date[row], 
    #                                                                               "Percentile" = marketingYear$Percentile[row],
    #                                                                               "Type" = "Seasonal",
    #                                                                               "Percent Sold" = percentSold))
    #       }
    #     }
    #   }
    # }
    #     
    #else if price >= 70 percentile
      #make EYTS sale
    }
  }

  priceObjectiveActualized = rbind(priceObjectiveActualized, priceObjectiveActualizedPost)
  
  cropYear[['PO Actualized']] = priceObjectiveActualized
  
  return(cropYear)
}
  
  
for(i in 1:5) {
  Corn_CropYearObjects[[i]] = isActualized(Corn_CropYearObjects[[i]])
}


cropYear = Corn_CropYearObjects[[6]]  
  
  
  










