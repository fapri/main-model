library(lubridate)

CornSeasonal0809 <- c(mdy("03/10/08","03/20/08","06/10/08","06/20/08",
                          "03/10/09","03/20/09","06/10/09","06/22/09"))
CornPreAndPost0809.ds$Sale <- "no"
CornPreAndPost0809.ds$Sale[match(CornSeasonal0809, CornPreAndPost0809.ds$Date)] <- "Seasonal"

CornSeasonal0910 <- c(mdy("03/10/09","03/20/09","06/10/09","06/22/09",
                          "03/10/10","03/22/10","06/10/10","06/21/10"))
CornPreAndPost0910.ds$Sale <- "no"
CornPreAndPost0910.ds$Sale[match(CornSeasonal0910, CornPreAndPost0910.ds$Date)] <- "Seasonal"

CornSeasonal1011 <- c(mdy("03/10/10","03/22/10","06/10/10","06/21/10",
                          "03/10/11","03/21/11","06/10/11","06/20/11"))
CornPreAndPost1011.ds$Sale <- "no"
CornPreAndPost1011.ds$Sale[match(CornSeasonal1011, CornPreAndPost1011.ds$Date)] <- "Seasonal"

CornSeasonal1112 <- c(mdy("03/10/11","03/21/11","06/10/11","06/20/11",
                          "03/12/12","03/20/12","06/11/12","06/20/12"))
CornPreAndPost1112.ds$Sale <- "no"
CornPreAndPost1112.ds$Sale[match(CornSeasonal1112, CornPreAndPost1112.ds$Date)] <- "Seasonal"

CornSeasonal1213 <- c(mdy("03/12/12","03/20/12","06/11/12","06/20/12",
                          "03/11/13","03/20/13","06/10/13","06/20/13"))
CornPreAndPost1213.ds$Sale <- "no"
CornPreAndPost1213.ds$Sale[match(CornSeasonal1213, CornPreAndPost1213.ds$Date)] <- "Seasonal"

CornSeasonal1314 <- c(mdy("03/11/13","03/20/13","06/10/13","06/20/13",
                          "03/10/14","03/20/14","06/10/14","06/20/14"))
CornPreAndPost1314.ds$Sale <- "no"
CornPreAndPost1314.ds$Sale[match(CornSeasonal1314, CornPreAndPost1314.ds$Date)] <- "Seasonal"

CornSeasonal1415 <- c(mdy("03/10/14","03/20/14","06/10/14","06/20/14",
                          "03/10/15","03/20/15","06/10/15","06/22/15"))
CornPreAndPost1415.ds$Sale <- "no"
CornPreAndPost1415.ds$Sale[match(CornSeasonal1415, CornPreAndPost1415.ds$Date)] <- "Seasonal"

CornSeasonal1516 <- c(mdy("03/10/15","03/20/15","06/10/15","06/22/15",
                          "03/10/16","03/21/16","06/10/16","06/20/16"))
CornPreAndPost1516.ds$Sale <- "no"
CornPreAndPost1516.ds$Sale[match(CornSeasonal1516, CornPreAndPost1516.ds$Date)] <- "Seasonal"

CornSeasonal1617 <- c(mdy("03/10/16","03/21/16","06/10/16","06/20/16",
                          "03/10/17","03/20/17","06/12/17","06/20/17"))
CornPreAndPost1617.ds$Sale <- "no"
CornPreAndPost1617.ds$Sale[match(CornSeasonal1617, CornPreAndPost1617.ds$Date)] <- "Seasonal"
