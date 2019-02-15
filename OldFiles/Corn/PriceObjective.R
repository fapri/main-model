library(lubridate)

CornPO0809 <- c(mdy("03/18/08",
                    "03/25/08",
                    "05/16/08",
                    "07/07/08",
                    "07/14/08",
                    "09/02/08",
                    "09/09/08",
                    "09/16/08",
                    "09/29/08",
                    "10/17/08"))
CornPreAndPost0809.ds$Sale <- "no"
CornPreAndPost0809.ds$Sale[match(CornPO0809, CornPreAndPost0809.ds$Date)] <- "Price Objective"

CornPO0910 <- c(mdy("01/02/09",
                    "01/09/09",
                    "01/16/09",
                    "01/28/09",
                    "02/05/09",
                    "01/06/10"))
CornSeasonal0910 <- c(mdy("03/10/10",
                          "03/22/10",
                          "06/10/10",
                          "06/21/10"))
CornPreAndPost0910.ds$Sale <- "no"
CornPreAndPost0910.ds$Sale[match(CornPO0910, CornPreAndPost0910.ds$Date)] <- "Price Objective"
CornPreAndPost0910.ds$Sale[match(CornSeasonal0910, CornPreAndPost0910.ds$Date)] <- "Seasonal"

CornPO1011 <- c(mdy("08/06/10",
                    "08/30/10",
                    "09/17/10",
                    "09/24/10",
                    "10/08/10",
                    "10/20/10",
                    "11/23/10",
                    "12/15/10",
                    "01/07/11",
                    "03/18/11"))
CornSeasonal1011 <- c(mdy("03/10/11"))
CornPreAndPost1011.ds$Sale <- "no"
CornPreAndPost1011.ds$Sale[match(CornPO1011, CornPreAndPost1011.ds$Date)] <- "Price Objective"
CornPreAndPost1011.ds$Sale[match(CornSeasonal1011, CornPreAndPost1011.ds$Date)] <- "Seasonal"

CornPO1112 <- c(mdy("01/21/11",
                    "01/31/11",
                    "04/04/11",
                    "04/13/11",
                    "04/29/11",
                    "09/01/11",
                    "09/08/11",
                    "09/15/11",
                    "09/27/11",
                    "10/05/11"))
CornPreAndPost1112.ds$Sale <- "no"
CornPreAndPost1112.ds$Sale[match(CornPO1112, CornPreAndPost1112.ds$Date)] <- "Price Objective"

CornPO1213 <- c(mdy("01/26/12",
                    "02/13/12",
                    "02/29/12",
                    "03/16/12",
                    "04/05/12",
                    "09/17/12",
                    "09/26/12",
                    "12/12/12",
                    "12/19/12",
                    "02/11/13"))
CornPreAndPost1213.ds$Sale <- "no"
CornPreAndPost1213.ds$Sale[match(CornPO1213, CornPreAndPost1213.ds$Date)] <- "Price Objective"

CornPO1314 <- c(mdy("02/12/13",
                    "02/20/13",
                    "03/25/13",
                    "06/19/13",
                    "03/04/14",
                    "03/31/14",
                    "04/14/14",
                    "04/23/14"))
CornSeasonal1314 <- c(mdy("03/10/14",
                          "03/20/14"))
CornPreAndPost1314.ds$Sale <- "no"
CornPreAndPost1314.ds$Sale[match(CornPO1314, CornPreAndPost1314.ds$Date)] <- "Price Objective"
CornPreAndPost1314.ds$Sale[match(CornSeasonal1314, CornPreAndPost1314.ds$Date)] <- "Seasonal"

CornPO1415 <- c(mdy("03/03/14",
                    "05/23/14",
                    "06/13/14",
                    "06/27/14"))
CornSeasonal1415 <- c(mdy("03/10/15",
                          "03/20/15",
                          "06/10/15",
                          "06/22/15"))
CornPreAndPost1415.ds$Sale <- "no"
CornPreAndPost1415.ds$Sale[match(CornPO1415, CornPreAndPost1415.ds$Date)] <- "Price Objective"
CornPreAndPost1415.ds$Sale[match(CornSeasonal1415, CornPreAndPost1415.ds$Date)] <- "Seasonal"

CornPO1516 <- c(mdy("06/30/15",
                    "05/25/16",
                    "06/17/16"))
CornSeasonal1516 <- c(mdy("03/10/16",
                          "03/21/16",
                          "06/10/16",
                          "06/20/16"))
CornPreAndPost1516.ds$Sale <- "no"
CornPreAndPost1516.ds$Sale[match(CornPO1516, CornPreAndPost1516.ds$Date)] <- "Price Objective"
CornPreAndPost1516.ds$Sale[match(CornSeasonal1516, CornPreAndPost1516.ds$Date)] <- "Seasonal"

CornPO1617 <- c(mdy("06/03/16",
                    "06/17/16"))
CornSeasonal1617 <- c(mdy("03/10/17",
                          "03/20/17",
                          "06/12/17",
                          "06/20/17"))
CornPreAndPost1617.ds$Sale <- "no"
CornPreAndPost1617.ds$Sale[match(CornPO1617, CornPreAndPost1617.ds$Date)] <- "Price Objective"
CornPreAndPost1617.ds$Sale[match(CornSeasonal1617, CornPreAndPost1617.ds$Date)] <- "Seasonal"
