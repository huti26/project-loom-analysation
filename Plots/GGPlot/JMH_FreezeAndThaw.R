library(ggplot2)
library(plyr)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

cbp1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

data <- read.csv("./JMH/CSV/jmh-result.csv")

data <- subset(data,data$Benchmark == "org.openjdk.benchmarks.cont.FreezeAndThaw.baseline" | data$Benchmark == "org.openjdk.benchmarks.cont.FreezeAndThaw.yieldAndContinue")
data <- rename(data,c("Param..stackDepth"="stackDepth"))



g <- ggplot(data, aes(y=Score,x=Param..paramCount,fill=Benchmark)) + 
  geom_bar(stat="identity", width=.5, position = "dodge")  +
  geom_errorbar(aes(ymin=Score-Score.Error..99.9.., ymax=Score+Score.Error..99.9..), width=0,size=0.5,
                position=position_dodge(.5)) + 
  scale_x_discrete(limits=c("1","2","3"))


g <- g + facet_wrap(vars(stackDepth), labeller = "label_both", scales = "free",ncol=4)

g <- g +
  labs(
    title = "FreezeAndThaw",
    x = "paramCount",
    y = "Time in Nanoseconds",
    caption = "n=5")  +
  scale_fill_manual(labels=c("baseline","yieldAndContinue"),values = cbp1)

print(g)

ggsave(plot=g,"./JMH/Plots/FreezeAndThaw.png",width=8.17,height=3)