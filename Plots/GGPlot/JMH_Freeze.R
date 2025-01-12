library(ggplot2)
library(plyr)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

cbp1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

data <- read.csv("./JMH/CSV/jmh-result.csv")

data <- subset(data,data$Benchmark == "org.openjdk.benchmarks.cont.Freeze.justYield")
data <- rename(data,c("Param..stackDepth"="stackDepth"))



g <- ggplot(data, aes(y=Score,x=Param..paramCount,fill=Benchmark)) + 
  geom_bar(stat="identity",width=0.75) +
  geom_errorbar(aes(ymin=Score-Score.Error..99.9.., ymax=Score+Score.Error..99.9..), width=0,size=0.8)


g <- g + facet_wrap(vars(stackDepth), labeller = "label_both", scales = "free",ncol=4)

g <- g +
  theme(legend.position = "none")+
  labs(
    title = "Freeze",
    subtitle = "justYield",
    x = "paramCount",
    y = "Time in Nanoseconds",
    caption = "n=5")+
  scale_fill_manual(values = cbp1) +
  theme(
    text = element_text(size = 14),
    plot.margin = margin(t = 0.5, r = 1.5, b = 0.5, l = 1, unit = "cm"
    ))

ggsave(plot=g,"./JMH/Plots/Freeze.png",width=8.17,height=3.5)