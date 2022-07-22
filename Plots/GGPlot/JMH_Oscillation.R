library(ggplot2)
library(plyr)


setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

options(scipen=999)

cbp1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

data <- read.csv("./JMH/CSV/jmh-result.csv")
data <- subset(data,data$Benchmark == "org.openjdk.benchmarks.cont.Oscillation.oscillate")

data <- rename(data,c("Param..maxDepth"="maxDepth"))
data <- rename(data,c("Param..minDepth"="minDepth"))
data <- rename(data,c("Param..repeat"="Repeat"))

data$maxDepth <- as.factor(data$maxDepth)
data$minDepth <- as.factor(data$minDepth)
data$Repeat <- as.factor(data$Repeat)


g <- ggplot(data, aes(y=Score,x=minDepth,fill=maxDepth)) + 
  geom_bar(stat="identity", position = "dodge",width=0.75) + 
  scale_x_discrete(limits=c("2","3","4"))   +
  geom_errorbar(aes(ymin=Score-Score.Error..99.9.., ymax=Score+Score.Error..99.9..), width=0,size=0.75,
                position=position_dodge(0.75)) 



g <- g + facet_wrap(vars(Repeat), labeller = "label_both", scales = "free",ncol=4)

g <- g +
  labs(
    title = "Oscillation",
    y = "Time in Nanoseconds",
    caption = "n=5")+
  scale_fill_manual(values = cbp1) +
  theme(
    text = element_text(size = 14),
    plot.margin = margin(t = 0.5, r = 1, b = 0.5, l = 1, unit = "cm"),
    strip.text.x = element_text(size = 10)
  )

print(g)

ggsave(plot=g,"./JMH/Plots/Oscillation.png",width=8.17,height=3)