library(ggplot2)

CornS1 <- ggplot(CornPreAndPost0809.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost0809.ds[CornPreAndPost0809.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2008-09-01"), linetype = 2) +
  ggtitle("08-09 Pre & Post - Strictly Seasonal w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.70,.75)) +
  scale_fill_manual(values = c("#00BA38"))

CornS2 <- ggplot(CornPreAndPost0910.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost0910.ds[CornPreAndPost0910.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2009-09-01"), linetype = 2) +
  ggtitle("09-10 Pre & Post - Strictly Seasonal w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.80,.20)) +
  scale_fill_manual(values = c("#00BA38"))

CornS3 <- ggplot(CornPreAndPost1011.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost1011.ds[CornPreAndPost1011.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2010-09-01"), linetype = 2) +
  ggtitle("10-11 Pre & Post - Strictly Seasonal w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.80,.25)) +
  scale_fill_manual(values = c("#00BA38"))

CornS4 <- ggplot(CornPreAndPost1112.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost1112.ds[CornPreAndPost1112.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2011-09-01"), linetype = 2) +
  ggtitle("11-12 Pre & Post - Strictly Seasonal w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.65,.85)) +
  scale_fill_manual(values = c("#00BA38"))

CornS5 <- ggplot(CornPreAndPost1213.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost1213.ds[CornPreAndPost1213.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2012-09-01"), linetype = 2) +
  ggtitle("12-13 Pre & Post - Strictly Seasonal w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.65,.80)) +
  scale_fill_manual(values = c("#00BA38"))

CornS6 <- ggplot(CornPreAndPost1314.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost1314.ds[CornPreAndPost1314.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2013-09-01"), linetype = 2) +
  ggtitle("13-14 Pre & Post - Strictly Seasonal w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.70,.20)) +
  scale_fill_manual(values = c("#00BA38"))

CornS7 <- ggplot(CornPreAndPost1415.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost1415.ds[CornPreAndPost1415.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2014-09-01"), linetype = 2) +
  ggtitle("14-15 Pre & Post - Strictly Seasonal w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.80,.80)) +
  scale_fill_manual(values = c("#00BA38"))

CornS8 <- ggplot(CornPreAndPost1516.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost1516.ds[CornPreAndPost1516.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2015-09-01"), linetype = 2) +
  ggtitle("15-16 Pre & Post - Strictly Seasonal w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.60,.70)) +
  scale_fill_manual(values = c("#00BA38"))

CornS9 <- ggplot(CornPreAndPost1617.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost1617.ds[CornPreAndPost1617.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2016-09-01"), linetype = 2) +
  ggtitle("16-17 Pre & Post - Strictly Seasonal w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.80,.75)) +
  scale_fill_manual(values = c("#00BA38"))
