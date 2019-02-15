library(ggplot2)

CornPO0809 <- ggplot(CornPreAndPost0809.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost0809.ds[CornPreAndPost0809.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2008-09-01"), linetype = 2) +
  geom_segment(x = as.Date("2008-03-01"), y = 5.56, xend = as.Date("2008-09-01"), yend = 5.56, linetype = 3) + geom_text(x = as.Date("2008-06-01"), y = 5.56, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2008-03-01"), y = 5.30, xend = as.Date("2008-09-01"), yend = 5.30, linetype = 3) + geom_text(x = as.Date("2008-06-01"), y = 5.30, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2008-03-01"), y = 5.00, xend = as.Date("2008-09-01"), yend = 5.00, linetype = 3) + geom_text(x = as.Date("2008-06-01"), y = 5.00, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2008-03-01"), y = 4.84, xend = as.Date("2008-09-01"), yend = 4.84, linetype = 3) + geom_text(x = as.Date("2008-06-01"), y = 4.84, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2008-09-01"), y = 4.70, xend = as.Date("2009-03-01"), yend = 4.70, linetype = 3) + geom_text(x = as.Date("2008-11-30"), y = 4.70, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2008-09-01"), y = 4.44, xend = as.Date("2009-03-01"), yend = 4.44, linetype = 3) + geom_text(x = as.Date("2008-11-30"), y = 4.44, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2008-09-01"), y = 4.14, xend = as.Date("2009-03-01"), yend = 4.14, linetype = 3) + geom_text(x = as.Date("2008-11-30"), y = 4.14, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2008-09-01"), y = 3.98, xend = as.Date("2009-03-01"), yend = 3.98, linetype = 3) + geom_text(x = as.Date("2008-11-30"), y = 3.98, label = "70th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2009-03-01"), y = 4.65, xend = as.Date("2009-09-01"), yend = 4.65, linetype = 3) + geom_text(x = as.Date("2009-08-01"), y = 4.65, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2009-03-01"), y = 4.45, xend = as.Date("2009-09-01"), yend = 4.45, linetype = 3) + geom_text(x = as.Date("2009-08-01"), y = 4.45, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2009-03-01"), y = 4.14, xend = as.Date("2009-09-01"), yend = 4.14, linetype = 3) + geom_text(x = as.Date("2009-08-01"), y = 4.14, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2009-03-01"), y = 3.97, xend = as.Date("2009-09-01"), yend = 3.97, linetype = 3) + geom_text(x = as.Date("2009-08-01"), y = 3.97, label = "70th", color = "#00FF00", size = 4) +
  ggtitle("08-09 Pre & Post - Price Objective w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.70,.75)) +
  scale_fill_manual(values = c("#ffff00", "#ed7d31"))
CornPO0809

CornPO0910 <- ggplot(CornPreAndPost0910.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost0910.ds[CornPreAndPost0910.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2009-09-01"), linetype = 2) +
  geom_segment(x = as.Date("2009-01-01"), y = 4.78, xend = as.Date("2009-03-01"), yend = 4.78, linetype = 3) + geom_text(x = as.Date("2009-02-01"), y = 4.78, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2009-01-01"), y = 4.53, xend = as.Date("2009-03-01"), yend = 4.53, linetype = 3) + geom_text(x = as.Date("2009-02-01"), y = 4.53, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2009-01-01"), y = 4.23, xend = as.Date("2009-03-01"), yend = 4.23, linetype = 3) + geom_text(x = as.Date("2009-02-01"), y = 4.23, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2009-01-01"), y = 4.04, xend = as.Date("2009-03-01"), yend = 4.04, linetype = 3) + geom_text(x = as.Date("2009-02-01"), y = 4.04, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2009-03-01"), y = 4.50, xend = as.Date("2009-09-01"), yend = 4.50, linetype = 3) + geom_text(x = as.Date("2009-08-01"), y = 4.50, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2009-03-01"), y = 4.30, xend = as.Date("2009-09-01"), yend = 4.30, linetype = 3) + geom_text(x = as.Date("2009-08-01"), y = 4.30, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2009-03-01"), y = 3.99, xend = as.Date("2009-09-01"), yend = 3.99, linetype = 3) + geom_text(x = as.Date("2009-08-01"), y = 3.99, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2009-03-01"), y = 3.82, xend = as.Date("2009-09-01"), yend = 3.82, linetype = 3) + geom_text(x = as.Date("2009-08-01"), y = 3.82, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2009-09-01"), y = 4.89, xend = as.Date("2010-03-01"), yend = 4.89, linetype = 3) + geom_text(x = as.Date("2009-11-30"), y = 4.89, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2009-09-01"), y = 4.69, xend = as.Date("2010-03-01"), yend = 4.69, linetype = 3) + geom_text(x = as.Date("2009-11-30"), y = 4.69, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2009-09-01"), y = 4.38, xend = as.Date("2010-03-01"), yend = 4.38, linetype = 3) + geom_text(x = as.Date("2009-11-30"), y = 4.38, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2009-09-01"), y = 4.21, xend = as.Date("2010-03-01"), yend = 4.21, linetype = 3) + geom_text(x = as.Date("2009-11-30"), y = 4.21, label = "70th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2010-03-01"), y = 5.00, xend = as.Date("2010-09-01"), yend = 5.00, linetype = 3) + geom_text(x = as.Date("2010-06-01"), y = 5.00, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2010-03-01"), y = 4.72, xend = as.Date("2010-09-01"), yend = 4.72, linetype = 3) + geom_text(x = as.Date("2010-06-01"), y = 4.72, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2010-03-01"), y = 4.28, xend = as.Date("2010-09-01"), yend = 4.28, linetype = 3) + geom_text(x = as.Date("2010-06-01"), y = 4.28, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2010-03-01"), y = 4.07, xend = as.Date("2010-09-01"), yend = 4.07, linetype = 3) + geom_text(x = as.Date("2010-06-01"), y = 4.07, label = "70th", color = "#00FF00", size = 4) +
  ggtitle("09-10 Pre & Post - Price Objective w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.15,.20)) +
  scale_fill_manual(values = c("#ffff00", "#ed7d31"))
CornPO0910

CornPO1011 <- ggplot(CornPreAndPost1011.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost1011.ds[CornPreAndPost1011.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2010-09-01"), linetype = 2) +
  geom_segment(x = as.Date("2010-01-01"), y = 5.05, xend = as.Date("2010-03-01"), yend = 5.05, linetype = 3) + geom_text(x = as.Date("2010-02-01"), y = 5.05, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2010-01-01"), y = 4.79, xend = as.Date("2010-03-01"), yend = 4.79, linetype = 3) + geom_text(x = as.Date("2010-02-01"), y = 4.79, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2010-01-01"), y = 4.50, xend = as.Date("2010-03-01"), yend = 4.50, linetype = 3) + geom_text(x = as.Date("2010-02-01"), y = 4.50, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2010-01-01"), y = 4.28, xend = as.Date("2010-03-01"), yend = 4.28, linetype = 3) + geom_text(x = as.Date("2010-02-01"), y = 4.28, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2010-03-01"), y = 5.12, xend = as.Date("2010-09-01"), yend = 5.12, linetype = 3) + geom_text(x = as.Date("2010-06-15"), y = 5.12, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2010-03-01"), y = 4.84, xend = as.Date("2010-09-01"), yend = 4.84, linetype = 3) + geom_text(x = as.Date("2010-06-15"), y = 4.84, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2010-03-01"), y = 4.40, xend = as.Date("2010-09-01"), yend = 4.40, linetype = 3) + geom_text(x = as.Date("2010-06-15"), y = 4.40, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2010-03-01"), y = 4.28, xend = as.Date("2010-09-01"), yend = 4.28, linetype = 3) + geom_text(x = as.Date("2010-06-15"), y = 4.28, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2010-09-01"), y = 5.95, xend = as.Date("2011-03-01"), yend = 5.95, linetype = 3) + geom_text(x = as.Date("2010-11-30"), y = 5.95, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2010-09-01"), y = 5.67, xend = as.Date("2011-03-01"), yend = 5.67, linetype = 3) + geom_text(x = as.Date("2010-11-30"), y = 5.67, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2010-09-01"), y = 5.23, xend = as.Date("2011-03-01"), yend = 5.23, linetype = 3) + geom_text(x = as.Date("2010-10-28"), y = 5.23, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2010-09-01"), y = 5.02, xend = as.Date("2011-03-01"), yend = 5.02, linetype = 3) + geom_text(x = as.Date("2010-10-28"), y = 5.02, label = "70th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2011-03-01"), y = 8.00, xend = as.Date("2011-09-01"), yend = 8.00, linetype = 3) + geom_text(x = as.Date("2011-07-10"), y = 8.00, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2011-03-01"), y = 7.56, xend = as.Date("2011-09-01"), yend = 7.56, linetype = 3) + geom_text(x = as.Date("2011-07-10"), y = 7.56, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2011-03-01"), y = 7.12, xend = as.Date("2011-09-01"), yend = 7.12, linetype = 3) + geom_text(x = as.Date("2011-06-01"), y = 7.12, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2011-03-01"), y = 6.70, xend = as.Date("2011-09-01"), yend = 6.70, linetype = 3) + geom_text(x = as.Date("2011-06-01"), y = 6.70, label = "70th", color = "#00FF00", size = 4) +
  ggtitle("10-11 Pre & Post - Price Objective w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.20,.70)) +
  scale_fill_manual(values = c("#ffff00", "#ed7d31"))
CornPO1011

CornPO1112 <- ggplot(CornPreAndPost1112.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost1112.ds[CornPreAndPost1112.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 4, alpha = .60) +
  geom_vline(xintercept = as.Date("2011-09-01"), linetype = 2) +
  geom_segment(x = as.Date("2011-01-01"), y = 6.20, xend = as.Date("2011-03-01"), yend = 6.20, linetype = 3) + geom_text(x = as.Date("2011-02-01"), y = 6.20, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2011-01-01"), y = 5.82, xend = as.Date("2011-03-01"), yend = 5.82, linetype = 3) + geom_text(x = as.Date("2011-02-01"), y = 5.82, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2011-01-01"), y = 5.42, xend = as.Date("2011-03-01"), yend = 5.42, linetype = 3) + geom_text(x = as.Date("2011-02-01"), y = 5.42, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2011-01-01"), y = 5.17, xend = as.Date("2011-03-01"), yend = 5.17, linetype = 3) + geom_text(x = as.Date("2011-02-01"), y = 5.17, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2011-03-01"), y = 7.71, xend = as.Date("2011-09-01"), yend = 7.71, linetype = 3) + geom_text(x = as.Date("2011-06-15"), y = 7.71, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2011-03-01"), y = 7.27, xend = as.Date("2011-09-01"), yend = 7.27, linetype = 3) + geom_text(x = as.Date("2011-06-15"), y = 7.27, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2011-03-01"), y = 6.83, xend = as.Date("2011-09-01"), yend = 6.83, linetype = 3) + geom_text(x = as.Date("2011-06-15"), y = 6.83, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2011-03-01"), y = 6.41, xend = as.Date("2011-09-01"), yend = 6.41, linetype = 3) + geom_text(x = as.Date("2011-06-15"), y = 6.41, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2011-09-01"), y = 6.92, xend = as.Date("2012-03-01"), yend = 6.92, linetype = 3) + geom_text(x = as.Date("2011-11-30"), y = 6.92, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2011-09-01"), y = 6.48, xend = as.Date("2012-03-01"), yend = 6.48, linetype = 3) + geom_text(x = as.Date("2011-11-30"), y = 6.48, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2011-09-01"), y = 6.04, xend = as.Date("2012-03-01"), yend = 6.04, linetype = 3) + geom_text(x = as.Date("2011-10-28"), y = 6.04, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2011-09-01"), y = 5.62, xend = as.Date("2012-03-01"), yend = 5.62, linetype = 3) + geom_text(x = as.Date("2011-10-28"), y = 5.62, label = "70th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2012-03-01"), y = 7.63, xend = as.Date("2012-09-01"), yend = 7.63, linetype = 3) + geom_text(x = as.Date("2012-06-01"), y = 7.63, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2012-03-01"), y = 7.26, xend = as.Date("2012-09-01"), yend = 7.26, linetype = 3) + geom_text(x = as.Date("2012-06-01"), y = 7.26, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2012-03-01"), y = 6.88, xend = as.Date("2012-09-01"), yend = 6.88, linetype = 3) + geom_text(x = as.Date("2012-06-01"), y = 6.88, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2012-03-01"), y = 6.61, xend = as.Date("2012-09-01"), yend = 6.61, linetype = 3) + geom_text(x = as.Date("2012-06-01"), y = 6.61, label = "70th", color = "#00FF00", size = 4) +
  ggtitle("11-12 Pre & Post - Price Objective w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.55,.75)) +
  scale_fill_manual(values = c("#ffff00", "#ed7d31"))
CornPO1112

CornPO1213 <- ggplot(CornPreAndPost1213.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost1213.ds[CornPreAndPost1213.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2012-09-01"), linetype = 2) +
  geom_segment(x = as.Date("2012-01-01"), y = 6.61, xend = as.Date("2012-03-01"), yend = 6.61, linetype = 3) + geom_text(x = as.Date("2012-02-01"), y = 6.61, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2012-01-01"), y = 6.24, xend = as.Date("2012-03-01"), yend = 6.24, linetype = 3) + geom_text(x = as.Date("2012-02-01"), y = 6.24, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2012-01-01"), y = 5.65, xend = as.Date("2012-03-01"), yend = 5.65, linetype = 3) + geom_text(x = as.Date("2012-02-01"), y = 5.65, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2012-01-01"), y = 5.33, xend = as.Date("2012-03-01"), yend = 5.33, linetype = 3) + geom_text(x = as.Date("2012-02-01"), y = 5.33, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2012-03-01"), y = 6.48, xend = as.Date("2012-09-01"), yend = 6.48, linetype = 3) + geom_text(x = as.Date("2012-06-15"), y = 6.48, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2012-03-01"), y = 6.11, xend = as.Date("2012-09-01"), yend = 6.11, linetype = 3) + geom_text(x = as.Date("2012-06-15"), y = 6.11, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2012-03-01"), y = 5.73, xend = as.Date("2012-09-01"), yend = 5.73, linetype = 3) + geom_text(x = as.Date("2012-06-15"), y = 5.73, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2012-03-01"), y = 5.46, xend = as.Date("2012-09-01"), yend = 5.46, linetype = 3) + geom_text(x = as.Date("2012-06-15"), y = 5.46, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2012-09-01"), y = 6.29, xend = as.Date("2013-03-01"), yend = 6.29, linetype = 3) + geom_text(x = as.Date("2012-11-30"), y = 6.29, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2012-09-01"), y = 5.92, xend = as.Date("2013-03-01"), yend = 5.92, linetype = 3) + geom_text(x = as.Date("2012-11-30"), y = 5.92, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2012-09-01"), y = 5.54, xend = as.Date("2013-03-01"), yend = 5.54, linetype = 3) + geom_text(x = as.Date("2012-11-30"), y = 5.54, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2012-09-01"), y = 5.27, xend = as.Date("2013-03-01"), yend = 5.27, linetype = 3) + geom_text(x = as.Date("2012-11-30"), y = 5.27, label = "70th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2013-03-01"), y = 8.82, xend = as.Date("2013-09-01"), yend = 8.82, linetype = 3) + geom_text(x = as.Date("2013-06-01"), y = 8.82, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2013-03-01"), y = 8.46, xend = as.Date("2013-09-01"), yend = 8.46, linetype = 3) + geom_text(x = as.Date("2013-06-01"), y = 8.46, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2013-03-01"), y = 7.96, xend = as.Date("2013-09-01"), yend = 7.96, linetype = 3) + geom_text(x = as.Date("2013-06-01"), y = 7.96, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2013-03-01"), y = 7.59, xend = as.Date("2013-09-01"), yend = 7.59, linetype = 3) + geom_text(x = as.Date("2013-06-01"), y = 7.59, label = "70th", color = "#00FF00", size = 4) +
  ggtitle("12-13 Pre & Post - Price Objective w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.75,.20)) +
  scale_fill_manual(values = c("#ffff00", "#ed7d31"))
CornPO1213

CornPO1314 <- ggplot(CornPreAndPost1314.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost1314.ds[CornPreAndPost1314.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2013-09-01"), linetype = 2) +
  geom_segment(x = as.Date("2013-01-01"), y = 6.31, xend = as.Date("2013-03-01"), yend = 6.31, linetype = 3) + geom_text(x = as.Date("2013-02-01"), y = 6.31, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2013-01-01"), y = 6.06, xend = as.Date("2013-03-01"), yend = 6.06, linetype = 3) + geom_text(x = as.Date("2013-02-01"), y = 6.06, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2013-01-01"), y = 5.61, xend = as.Date("2013-03-01"), yend = 5.61, linetype = 3) + geom_text(x = as.Date("2013-02-01"), y = 5.61, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2013-01-01"), y = 5.19, xend = as.Date("2013-03-01"), yend = 5.19, linetype = 3) + geom_text(x = as.Date("2013-02-01"), y = 5.19, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2013-03-01"), y = 6.92, xend = as.Date("2013-09-01"), yend = 6.92, linetype = 3) + geom_text(x = as.Date("2013-06-15"), y = 6.92, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2013-03-01"), y = 6.56, xend = as.Date("2013-09-01"), yend = 6.56, linetype = 3) + geom_text(x = as.Date("2013-06-15"), y = 6.56, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2013-03-01"), y = 6.06, xend = as.Date("2013-09-01"), yend = 6.06, linetype = 3) + geom_text(x = as.Date("2013-06-15"), y = 6.06, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2013-03-01"), y = 5.69, xend = as.Date("2013-09-01"), yend = 5.69, linetype = 3) + geom_text(x = as.Date("2013-07-15"), y = 5.69, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2013-09-01"), y = 6.80, xend = as.Date("2014-03-01"), yend = 6.80, linetype = 3) + geom_text(x = as.Date("2013-11-30"), y = 6.80, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2013-09-01"), y = 6.44, xend = as.Date("2014-03-01"), yend = 6.44, linetype = 3) + geom_text(x = as.Date("2013-11-30"), y = 6.44, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2013-09-01"), y = 5.94, xend = as.Date("2014-03-01"), yend = 5.94, linetype = 3) + geom_text(x = as.Date("2013-11-30"), y = 5.94, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2013-09-01"), y = 5.57, xend = as.Date("2014-03-01"), yend = 5.57, linetype = 3) + geom_text(x = as.Date("2013-11-30"), y = 5.57, label = "70th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2014-03-01"), y = 5.83, xend = as.Date("2014-09-01"), yend = 5.83, linetype = 3) + geom_text(x = as.Date("2014-06-01"), y = 5.83, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2014-03-01"), y = 5.40, xend = as.Date("2014-09-01"), yend = 5.40, linetype = 3) + geom_text(x = as.Date("2014-06-01"), y = 5.40, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2014-03-01"), y = 4.99, xend = as.Date("2014-09-01"), yend = 4.99, linetype = 3) + geom_text(x = as.Date("2014-06-01"), y = 4.99, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2014-03-01"), y = 4.71, xend = as.Date("2014-09-01"), yend = 4.71, linetype = 3) + geom_text(x = as.Date("2014-06-15"), y = 4.71, label = "70th", color = "#00FF00", size = 4) +
  ggtitle("13-14 Pre & Post - Price Objective w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.55,.60)) +
  scale_fill_manual(values = c("#ffff00", "#ed7d31"))
CornPO1314

CornPO1415 <- ggplot(CornPreAndPost1415.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost1415.ds[CornPreAndPost1415.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2014-09-01"), linetype = 2) +
  geom_segment(x = as.Date("2014-01-01"), y = 6.54, xend = as.Date("2014-03-01"), yend = 6.54, linetype = 3) + geom_text(x = as.Date("2014-02-01"), y = 6.54, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2014-01-01"), y = 5.91, xend = as.Date("2014-03-01"), yend = 5.91, linetype = 3) + geom_text(x = as.Date("2014-02-01"), y = 5.91, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2014-01-01"), y = 5.38, xend = as.Date("2014-03-01"), yend = 5.38, linetype = 3) + geom_text(x = as.Date("2014-02-01"), y = 5.38, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2014-01-01"), y = 5.07, xend = as.Date("2014-03-01"), yend = 5.07, linetype = 3) + geom_text(x = as.Date("2014-02-01"), y = 5.07, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2014-03-01"), y = 5.58, xend = as.Date("2014-09-01"), yend = 5.58, linetype = 3) + geom_text(x = as.Date("2014-06-15"), y = 5.58, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2014-03-01"), y = 5.15, xend = as.Date("2014-09-01"), yend = 5.15, linetype = 3) + geom_text(x = as.Date("2014-06-15"), y = 5.15, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2014-03-01"), y = 4.74, xend = as.Date("2014-09-01"), yend = 4.74, linetype = 3) + geom_text(x = as.Date("2014-06-15"), y = 4.74, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2014-03-01"), y = 4.46, xend = as.Date("2014-09-01"), yend = 4.46, linetype = 3) + geom_text(x = as.Date("2014-07-15"), y = 4.46, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2014-09-01"), y = 5.71, xend = as.Date("2015-03-01"), yend = 5.71, linetype = 3) + geom_text(x = as.Date("2014-11-30"), y = 5.71, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2014-09-01"), y = 5.28, xend = as.Date("2015-03-01"), yend = 5.28, linetype = 3) + geom_text(x = as.Date("2014-11-30"), y = 5.28, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2014-09-01"), y = 4.87, xend = as.Date("2015-03-01"), yend = 4.87, linetype = 3) + geom_text(x = as.Date("2014-11-30"), y = 4.87, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2014-09-01"), y = 4.59, xend = as.Date("2015-03-01"), yend = 4.59, linetype = 3) + geom_text(x = as.Date("2014-11-30"), y = 4.59, label = "70th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2015-03-01"), y = 5.20, xend = as.Date("2015-09-01"), yend = 5.20, linetype = 3) + geom_text(x = as.Date("2015-06-01"), y = 5.20, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2015-03-01"), y = 4.74, xend = as.Date("2015-09-01"), yend = 4.74, linetype = 3) + geom_text(x = as.Date("2015-06-01"), y = 4.74, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2015-03-01"), y = 4.28, xend = as.Date("2015-09-01"), yend = 4.28, linetype = 3) + geom_text(x = as.Date("2015-06-01"), y = 4.28, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2015-03-01"), y = 4.05, xend = as.Date("2015-09-01"), yend = 4.05, linetype = 3) + geom_text(x = as.Date("2015-06-01"), y = 4.05, label = "70th", color = "#00FF00", size = 4) +
  ggtitle("14-15 Pre & Post - Price Objective w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.20,.20)) +
  scale_fill_manual(values = c("#ffff00", "#ed7d31"))
CornPO1415

CornPO1516 <- ggplot(CornPreAndPost1516.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost1516.ds[CornPreAndPost1516.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2015-09-01"), linetype = 2) +
  geom_segment(x = as.Date("2015-01-01"), y = 5.92, xend = as.Date("2015-03-01"), yend = 5.92, linetype = 3) + geom_text(x = as.Date("2015-02-01"), y = 5.92, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2015-01-01"), y = 5.45, xend = as.Date("2015-03-01"), yend = 5.45, linetype = 3) + geom_text(x = as.Date("2015-02-01"), y = 5.45, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2015-01-01"), y = 4.81, xend = as.Date("2015-03-01"), yend = 4.81, linetype = 3) + geom_text(x = as.Date("2015-02-01"), y = 4.81, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2015-01-01"), y = 4.54, xend = as.Date("2015-03-01"), yend = 4.54, linetype = 3) + geom_text(x = as.Date("2015-02-01"), y = 4.54, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2015-03-01"), y = 5.46, xend = as.Date("2015-09-01"), yend = 5.46, linetype = 3) + geom_text(x = as.Date("2015-06-15"), y = 5.46, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2015-03-01"), y = 5.00, xend = as.Date("2015-09-01"), yend = 5.00, linetype = 3) + geom_text(x = as.Date("2015-06-15"), y = 5.00, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2015-03-01"), y = 4.54, xend = as.Date("2015-09-01"), yend = 4.54, linetype = 3) + geom_text(x = as.Date("2015-06-15"), y = 4.54, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2015-03-01"), y = 4.31, xend = as.Date("2015-09-01"), yend = 4.31, linetype = 3) + geom_text(x = as.Date("2015-06-15"), y = 4.31, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2015-09-01"), y = 5.48, xend = as.Date("2016-03-01"), yend = 5.48, linetype = 3) + geom_text(x = as.Date("2015-11-30"), y = 5.48, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2015-09-01"), y = 5.02, xend = as.Date("2016-03-01"), yend = 5.02, linetype = 3) + geom_text(x = as.Date("2015-11-30"), y = 5.02, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2015-09-01"), y = 4.56, xend = as.Date("2016-03-01"), yend = 4.56, linetype = 3) + geom_text(x = as.Date("2015-11-30"), y = 4.56, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2015-09-01"), y = 4.33, xend = as.Date("2016-03-01"), yend = 4.33, linetype = 3) + geom_text(x = as.Date("2015-11-30"), y = 4.33, label = "70th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2016-03-01"), y = 5.12, xend = as.Date("2016-09-01"), yend = 5.12, linetype = 3) + geom_text(x = as.Date("2016-06-01"), y = 5.12, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2016-03-01"), y = 4.73, xend = as.Date("2016-09-01"), yend = 4.73, linetype = 3) + geom_text(x = as.Date("2016-06-01"), y = 4.73, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2016-03-01"), y = 4.32, xend = as.Date("2016-09-01"), yend = 4.32, linetype = 3) + geom_text(x = as.Date("2016-05-01"), y = 4.32, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2016-03-01"), y = 4.02, xend = as.Date("2016-09-01"), yend = 4.02, linetype = 3) + geom_text(x = as.Date("2016-05-01"), y = 4.02, label = "70th", color = "#00FF00", size = 4) +
  ggtitle("15-16 Pre & Post - Price Objective w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.20,.20)) +
  scale_fill_manual(values = c("#ffff00", "#ed7d31"))
CornPO1516

CornPO1617 <- ggplot(CornPreAndPost1617.ds, aes(x = Date, y = Price)) +
  geom_line(size = .5) +
  geom_point(data = CornPreAndPost1617.ds[CornPreAndPost1617.ds$Sale != "no",],aes(fill=Sale), shape = 21, size = 3, alpha = .60) +
  geom_vline(xintercept = as.Date("2016-09-01"), linetype = 2) +
  geom_segment(x = as.Date("2016-01-01"), y = 5.52, xend = as.Date("2016-03-01"), yend = 5.52, linetype = 3) + geom_text(x = as.Date("2016-02-01"), y = 5.52, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2016-01-01"), y = 5.07, xend = as.Date("2016-03-01"), yend = 5.07, linetype = 3) + geom_text(x = as.Date("2016-02-01"), y = 5.07, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2016-01-01"), y = 4.64, xend = as.Date("2016-03-01"), yend = 4.64, linetype = 3) + geom_text(x = as.Date("2016-02-01"), y = 4.64, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2016-01-01"), y = 4.34, xend = as.Date("2016-03-01"), yend = 4.34, linetype = 3) + geom_text(x = as.Date("2016-02-01"), y = 4.34, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2016-03-01"), y = 5.27, xend = as.Date("2016-09-01"), yend = 5.27, linetype = 3) + geom_text(x = as.Date("2016-06-15"), y = 5.27, label = "95th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2016-03-01"), y = 4.88, xend = as.Date("2016-09-01"), yend = 4.88, linetype = 3) + geom_text(x = as.Date("2016-06-15"), y = 4.88, label = "90th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2016-03-01"), y = 4.47, xend = as.Date("2016-09-01"), yend = 4.47, linetype = 3) + geom_text(x = as.Date("2016-05-01"), y = 4.47, label = "80th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2016-03-01"), y = 4.17, xend = as.Date("2016-09-01"), yend = 4.17, linetype = 3) + geom_text(x = as.Date("2016-05-01"), y = 4.17, label = "70th", color = "#0000FF", size = 4) +
  geom_segment(x = as.Date("2016-09-01"), y = 5.41, xend = as.Date("2017-03-01"), yend = 5.41, linetype = 3) + geom_text(x = as.Date("2016-11-30"), y = 5.41, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2016-09-01"), y = 5.02, xend = as.Date("2017-03-01"), yend = 5.02, linetype = 3) + geom_text(x = as.Date("2016-11-30"), y = 5.02, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2016-09-01"), y = 4.61, xend = as.Date("2017-03-01"), yend = 4.61, linetype = 3) + geom_text(x = as.Date("2016-11-30"), y = 4.61, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2016-09-01"), y = 4.31, xend = as.Date("2017-03-01"), yend = 4.31, linetype = 3) + geom_text(x = as.Date("2016-11-30"), y = 4.31, label = "70th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2017-03-01"), y = 4.80, xend = as.Date("2017-09-01"), yend = 4.80, linetype = 3) + geom_text(x = as.Date("2017-06-01"), y = 4.80, label = "95th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2017-03-01"), y = 4.46, xend = as.Date("2017-09-01"), yend = 4.46, linetype = 3) + geom_text(x = as.Date("2017-06-01"), y = 4.46, label = "90th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2017-03-01"), y = 4.27, xend = as.Date("2017-09-01"), yend = 4.27, linetype = 3) + geom_text(x = as.Date("2017-06-01"), y = 4.27, label = "80th", color = "#00FF00", size = 4) +
  geom_segment(x = as.Date("2017-03-01"), y = 3.92, xend = as.Date("2017-09-01"), yend = 3.92, linetype = 3) + geom_text(x = as.Date("2017-06-01"), y = 3.92, label = "70th", color = "#00FF00", size = 4) +
  ggtitle("16-17 Pre & Post - Price Objective w/o Multi-Year") +
  scale_x_date(date_labels ="%b '%y", date_breaks = "1 month", date_minor_breaks = "1 month")  +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = c(.50,.65)) +
  scale_fill_manual(values = c("#ffff00", "#ed7d31"))
CornPO1617
