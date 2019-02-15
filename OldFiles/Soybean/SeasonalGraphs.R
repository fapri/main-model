library(ggplot2)

SoybeanSS1 <- ggplot(SoybeanPreAndPost0809.ds, aes(x = Date, y = Price)) +
      geom_line(size = .5) +
      geom_point(data = SoybeanPreAndPost0809.ds[SoybeanPreAndPost0809.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
      geom_vline(xintercept = as.Date("2008-09-01"), linetype = 2) +
      ggtitle("08-09 Pre & Post - Strictly Seasonal w/o Multi-Year") +
      scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
      scale_y_continuous(breaks = c(7, 8, 9, 10, 11, 12, 13, 14, 15, 16)) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.position = c(.70,.75)) +
      scale_fill_manual(values = c("#00BA38"))

SoybeanSS2 <- ggplot(SoybeanPreAndPost0910.ds, aes(x = Date, y = Price)) +
      geom_line(size = .5) +
      geom_point(data = SoybeanPreAndPost0910.ds[SoybeanPreAndPost0910.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
      geom_vline(xintercept = as.Date("2009-09-01"), linetype = 2) +
      ggtitle("09-10 Pre & Post - Strictly Seasonal w/o Multi-Year") +
      scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.position = c(.80,.20)) +
      scale_fill_manual(values = c("#00BA38"))

SoybeanSS3 <- ggplot(SoybeanPreAndPost1011.ds, aes(x = Date, y = Price)) +
      geom_line(size = .5) +
      geom_point(data = SoybeanPreAndPost1011.ds[SoybeanPreAndPost1011.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
      geom_vline(xintercept = as.Date("2010-09-01"), linetype = 2) +
      ggtitle("10-11 Pre & Post - Strictly Seasonal w/o Multi-Year") +
      scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.position = c(.80,.25)) +
      scale_fill_manual(values = c("#00BA38"))

SoybeanSS4 <- ggplot(SoybeanPreAndPost1112.ds, aes(x = Date, y = Price)) +
      geom_line(size = .5) +
      geom_point(data = SoybeanPreAndPost1112.ds[SoybeanPreAndPost1112.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
      geom_vline(xintercept = as.Date("2011-09-01"), linetype = 2) +
      ggtitle("11-12 Pre & Post - Strictly Seasonal w/o Multi-Year") +
      scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
      scale_y_continuous(breaks = c(11, 12, 13, 14, 15, 16, 17, 18)) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.position = c(.65,.85)) +
      scale_fill_manual(values = c("#00BA38"))

SoybeanSS5 <- ggplot(SoybeanPreAndPost1213.ds, aes(x = Date, y = Price)) +
      geom_line(size = .5) +
      geom_point(data = SoybeanPreAndPost1213.ds[SoybeanPreAndPost1213.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
      geom_vline(xintercept = as.Date("2012-09-01"), linetype = 2) +
      ggtitle("12-13 Pre & Post - Strictly Seasonal w/o Multi-Year") +
      scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
      scale_y_continuous(breaks = c(11, 12, 13, 14, 15, 16, 17, 18)) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.position = c(.65,.80)) +
      scale_fill_manual(values = c("#00BA38"))

SoybeanSS6 <- ggplot(SoybeanPreAndPost1314.ds, aes(x = Date, y = Price)) +
      geom_line(size = .5) +
      geom_point(data = SoybeanPreAndPost1314.ds[SoybeanPreAndPost1314.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
      geom_vline(xintercept = as.Date("2013-09-01"), linetype = 2) +
      ggtitle("13-14 Pre & Post - Strictly Seasonal w/o Multi-Year") +
      scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.position = c(.70,.20)) +
      scale_fill_manual(values = c("#00BA38"))

SoybeanSS7 <- ggplot(SoybeanPreAndPost1415.ds, aes(x = Date, y = Price)) +
      geom_line(size = .5) +
      geom_point(data = SoybeanPreAndPost1415.ds[SoybeanPreAndPost1415.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
      geom_vline(xintercept = as.Date("2014-09-01"), linetype = 2) +
      ggtitle("14-15 Pre & Post - Strictly Seasonal w/o Multi-Year") +
      scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.position = c(.80,.80)) +
      scale_fill_manual(values = c("#00BA38"))

SoybeanSS8 <- ggplot(SoybeanPreAndPost1516.ds, aes(x = Date, y = Price)) +
      geom_line(size = .5) +
      geom_point(data = SoybeanPreAndPost1516.ds[SoybeanPreAndPost1516.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
      geom_vline(xintercept = as.Date("2015-09-01"), linetype = 2) +
      ggtitle("15-16 Pre & Post - Strictly Seasonal w/o Multi-Year") +
      scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.position = c(.60,.70)) +
      scale_fill_manual(values = c("#00BA38"))

SoybeanSS9 <- ggplot(SoybeanPreAndPost1617.ds, aes(x = Date, y = Price)) +
      geom_line(size = .5) +
      geom_point(data = SoybeanPreAndPost1617.ds[SoybeanPreAndPost1617.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
      geom_vline(xintercept = as.Date("2016-09-01"), linetype = 2) +
      ggtitle("16-17 Pre & Post - Strictly Seasonal w/o Multi-Year") +
      scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
          legend.position = c(.80,.75)) +
      scale_fill_manual(values = c("#00BA38"))

