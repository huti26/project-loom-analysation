library(ggplot2)
library(plyr)


setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

cbp1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

data <- read.csv("./JMH/CSV/R-OneShot.csv")

data <- rename(data,c("Param..stackDepth"="stackDepth"))
data$stackDepth <- as.factor(data$stackDepth)

data$facet = factor(data$Benchmark, levels = c("noYield", "yield", "yieldThenContinue",
                                               "yieldBeforeEachCall", "yieldAfterEachCall","yieldBeforeAndAfterEachCall"))

g <- ggplot(data, aes(y=Score,x=Param..paramCount,fill=facet)) + 
  geom_bar(stat="identity", position = "dodge",width=0.75) + 
  scale_x_discrete(limits=c("1","2","3"))   +
  geom_errorbar(aes(ymin=Score-Score.Error..99.9.., ymax=Score+Score.Error..99.9..), width=0,size=0.75,
                position=position_dodge(0.75)) 



g <- g + facet_wrap(vars(stackDepth), labeller = "label_both", scales = "free",ncol=4)

g <- g +
  labs(
    title = "OneShot",
    subtitle = "Functions compared",
    x = "paramCount",
    y = "Time in Nanoseconds",
    fill = "Benchmark",
    caption = "n=5")+
  scale_fill_manual(values = cbp1)

print(g)

ggsave(plot=g,"./JMH/Plots/OneShot2.png",width=12,height=4)