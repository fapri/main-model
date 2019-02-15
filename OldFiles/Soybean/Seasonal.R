library(lubridate)

SoybeanSeasonal0809 <- c(mdy("05/12/08",
                      "05/20/08",
                      "07/10/08",
                      "07/21/08",
                      "05/11/09",
                      "05/20/09",
                      "07/10/09",
                      "07/20/09"))
SoybeanPreAndPost0809.ds$Sale <- "no"
SoybeanPreAndPost0809.ds$Sale[match(SoybeanSeasonal0809, SoybeanPreAndPost0809.ds$Date)] <- "Seasonal"

SoybeanSeasonal0910 <- c(mdy("05/11/09",
                      "05/20/09",
                      "07/10/09",
                      "07/20/09",
                      "05/10/10",
                      "05/20/10",
                      "07/12/10",
                      "07/20/10"))
SoybeanPreAndPost0910.ds$Sale <- "no"
SoybeanPreAndPost0910.ds$Sale[match(SoybeanSeasonal0910, SoybeanPreAndPost0910.ds$Date)] <- "Seasonal"

SoybeanSeasonal1011 <- c(mdy("05/10/10",
                      "05/20/10",
                      "07/12/10",
                      "07/20/10",
                      "05/10/11",
                      "05/20/11",
                      "07/11/11",
                      "07/20/11"))
SoybeanPreAndPost1011.ds$Sale <- "no"
SoybeanPreAndPost1011.ds$Sale[match(SoybeanSeasonal1011, SoybeanPreAndPost1011.ds$Date)] <- "Seasonal"

SoybeanSeasonal1112 <- c(mdy("05/10/11",
                      "05/20/11",
                      "07/11/11",
                      "07/20/11",
                      "05/10/12",
                      "05/21/12",
                      "07/10/12",
                      "07/20/12"))
SoybeanPreAndPost1112.ds$Sale <- "no"
SoybeanPreAndPost1112.ds$Sale[match(SoybeanSeasonal1112, SoybeanPreAndPost1112.ds$Date)] <- "Seasonal"

SoybeanSeasonal1213 <- c(mdy("05/10/12",
                      "05/21/12",
                      "07/10/12",
                      "07/20/12",
                      "05/10/13",
                      "05/20/13",
                      "07/10/13",
                      "07/22/13"))
SoybeanPreAndPost1213.ds$Sale <- "no"
SoybeanPreAndPost1213.ds$Sale[match(SoybeanSeasonal1213, SoybeanPreAndPost1213.ds$Date)] <- "Seasonal"

SoybeanSeasonal1314 <- c(mdy("05/10/13",
                      "05/20/13",
                      "07/10/13",
                      "07/22/13",
                      "05/12/14",
                      "05/20/14",
                      "07/10/14",
                      "07/21/14"))
SoybeanPreAndPost1314.ds$Sale <- "no"
SoybeanPreAndPost1314.ds$Sale[match(SoybeanSeasonal1314, SoybeanPreAndPost1314.ds$Date)] <- "Seasonal"

SoybeanSeasonal1415 <- c(mdy("05/12/14",
                      "05/20/14",
                      "07/10/14",
                      "07/21/14",
                      "05/11/15",
                      "05/20/15",
                      "07/10/15",
                      "07/20/15"))
SoybeanPreAndPost1415.ds$Sale <- "no"
SoybeanPreAndPost1415.ds$Sale[match(SoybeanSeasonal1415, SoybeanPreAndPost1415.ds$Date)] <- "Seasonal"

SoybeanSeasonal1516 <- c(mdy("05/11/15",
                      "05/20/15",
                      "07/10/15",
                      "07/20/15",
                      "05/10/16",
                      "05/20/16",
                      "07/11/16",
                      "07/20/16"))
SoybeanPreAndPost1516.ds$Sale <- "no"
SoybeanPreAndPost1516.ds$Sale[match(SoybeanSeasonal1516, SoybeanPreAndPost1516.ds$Date)] <- "Seasonal"

SoybeanSeasonal1617 <- c(mdy("05/10/16",
                      "05/20/16",
                      "07/11/16",
                      "07/20/16",
                      "05/10/17",
                      "05/22/17",
                      "07/10/17",
                      "07/20/17"))
SoybeanPreAndPost1617.ds$Sale <- "no"
SoybeanPreAndPost1617.ds$Sale[match(SoybeanSeasonal1617, SoybeanPreAndPost1617.ds$Date)] <- "Seasonal"

