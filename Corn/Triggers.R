# Common Trigger Functions 

# Checks 5% Drop from Ten Day High
isTenDayHigh = function(date, price, percentile, preInterval, postInterval, TDH, MY) {
  # Checks if date is NC
  if(MY == FALSE) {  
    if (date %within% preInterval) {
      # Checks if the price is in 95 percentile.
      # Checks if the price is > 95%TDH for NC
      if (is.na(TDH[which(TDH$Date == date),]$NC)) {
        return(F)
      } else if (percentile == 95 && price < TDH[which(TDH$Date == date),]$NC) {
        return(T)
      } else 
        return(F)
    }
    
    # Checks if date is OC
    else if (date %within% postInterval) {
      # Checks if the price is in 95 percentile.
      # Checks if the price is > 95%TDH for OC
      if (percentile == 95 && price < TDH[which(TDH$Date == date),]$OC) {
        return(T)
      } else 
        return(F)
    }
  }
  
  else{
    if (is.na(TDH[which(TDH$Date == date),]$NC)) {
      return(F)
    } else if (percentile == 95 && price < TDH[which(TDH$Date == date),]$NC) {
      return(T)
    } else 
      return(F)
  }
}

# Checks All Time High
isAllTimeHigh = function(date, price, percentile, preInterval, postInterval, TDH, ATH, MY) {
  if (MY == FALSE) {#Checks if date is NC
    if (date %within% preInterval){
      # Checks if the price is in 95 percentile.
      # Checks if the price is > 95%TDH for NC
      if (is.na(TDH[which(TDH$Date == date),]$NC)) {
        return(F)
      } else if (((price - ATH[which(ATH$Date == date),]$NC) > (-1)) && price < TDH[which(TDH$Date == date),]$NC) {
        return(T)
      } else 
        return(F)
    }
    
    # Checks if date is OC
    else if (date %within% postInterval) {
      # Checks if the price is in 95 percentile.
      # Checks if the price is > 95%TDH for OC
      if (((price - ATH[which(ATH$Date == date),]$OC) > (-1)) && price < TDH[which(TDH$Date == date),]$OC) {
        return(T)
      } else 
        return(F)
    }
  }
  else{
    if (is.na(TDH[which(TDH$Date == date),]$NC)) {
      return(F)
    } else if (((price - ATH[which(ATH$Date == date),]$NC) > (-1)) && price < TDH[which(TDH$Date == date),]$NC) {
      return(T)
    } else 
      return(F)
  }
}

# Checks End of the Year Trailing Stop
isEndYearTrailingStop = function(date, previousPercentile, currentPercentile, postInterval) {
  # checks if date is in June
  if (month(date) >= 6 && year(date) == year(int_end(postInterval))) {
    # Checks if Market passes down a percentile
    if (currentPercentile < previousPercentile && currentPercentile >= 60) {
      return(T)
    } else 
      return(F)
  } else 
    return(F)
}