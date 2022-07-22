library(ggplot2)
library(gg.layers)

# setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

cbp1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

data.t <- read.csv("./Footprint/Megabytes/500-10000-t.csv")
data.t$type <- "Thread"

data.vt <- read.csv("./Footprint/Megabytes/500-10000-vt.csv")
data.vt$type <- "Virtual Thread"

data <- rbind(data.t, data.vt)
data$requests.char <- "10000 Requests"

g <- ggplot(data) + geom_area(aes(x=X,y=Used.size, fill=type))+
  facet_wrap(~requests.char, scales = "free") +
  labs(
    title = "Heap Usage during benchmark",
    y = "Used Heap in MB",
    fill = "",
    caption = "500 Runs"
  ) +
  scale_fill_manual(values = c("#5975A4","#CC8963")) +
  theme(
    text = element_text(size = 14),
    plot.margin = margin(t = 0.5, r = 1.5, b = 0.5, l = 1, unit = "cm"),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    legend.position = "bottom"
  )


print(g)

ggsave(plot=g,"./Footprint/areaplot_heap_10000.png",width=8.17,height=6.5)

box_plot <- ggplot(data) + geom_boxplot2(aes(y=Used.size, fill=type), width = 0.5, width.errorbar = 0.1, size = 0.8) +
  facet_wrap(~requests.char, scales = "free") +
  labs(
    title = "Boxplots of Heap Usage during benchmark",
    y = "Used Heap in MB",
    fill = "",
    caption = "500 Runs"
  ) +
  scale_fill_manual(values = c("#5975A4","#CC8963")) +
  theme(
    text = element_text(size = 14),
    plot.margin = margin(t = 0.5, r = 1.5, b = 0.5, l = 1, unit = "cm"),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    legend.position = "bottom"
  )

print(box_plot)

ggsave(plot=box_plot,"./Footprint/boxplot_heap_10000.png",width=8.17,height=6.5)

