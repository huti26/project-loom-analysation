library(ggplot2)
library(gg.layers)

# setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

cbp1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

data <- read.csv("./Footprint/all.csv")

data <- subset(data, data$requests < 1000000)
data <- subset(data, data$runs == 100)

data$requests.char <- paste0(data$requests, " Requests")

data.t <- subset(data, data$type == "Thread")
data.vt <- subset(data, data$type == "Virtual Thread")


box_plot <- ggplot(data) + geom_boxplot2(aes(y=time, fill=type), width = 0.5, width.errorbar = 0.1, size = 0.8) +
  facet_wrap(~requests.char, scales = "free") +
    labs(
      title = "Boxplots of meassured benchmark times",
      y = "Time in seconds",
      fill = "",
      caption = "100 Runs"
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

ggsave(plot=box_plot,"./Footprint/boxplot_100.png",width=8.17,height=3.5)

# box_plot_t <- ggplot(data.t) + geom_boxplot2(aes(y=time),fill="#5975A4", width = 0.8, width.errorbar = 0.3, size = 1.2) +
#   facet_wrap(~requests, scales = "free") +
#   labs(
#     title = "Boxplot of meassured benchmark times",
#     y = "Time in seconds"
#   ) +
#   theme(
#     text = element_text(size = 14),
#     plot.margin = margin(t = 0.5, r = 1.5, b = 0.5, l = 1, unit = "cm"),
#     axis.title.x=element_blank(),
#     axis.text.x=element_blank(),
#     axis.ticks.x=element_blank()
#   )
# 
# print(box_plot_t)
# 
# box_plot_vt <- ggplot(data.vt) + geom_boxplot2(aes(y=time), fill="#CC8963", width = 0.8, width.errorbar = 0.3, size = 1.2) +
#   facet_wrap(~requests, scales = "free") +
#   labs(
#     title = "Boxplot of meassured benchmark times",
#     y = "Time in seconds"
#   ) +
#   theme(
#     text = element_text(size = 14),
#     plot.margin = margin(t = 0.5, r = 1.5, b = 0.5, l = 1, unit = "cm"),
#     axis.title.x=element_blank(),
#     axis.text.x=element_blank(),
#     axis.ticks.x=element_blank()
#     )
# 
# print(box_plot_vt)
# 
# ggsave(plot=box_plot_vt,"./Footprint/boxplot_vt.png",width=8.17,height=3.5)