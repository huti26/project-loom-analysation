library(ggplot2)
library(gg.layers)

# setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

cbp1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

data <- read.csv("./Footprint/all.csv")
data <- subset(data, data$runs == 500)

data <- subset(data, data$requests < 1000000)

data$requests.char <- paste0(data$requests, " Requests")

data.t <- subset(data, data$type == "Thread")
data.vt <- subset(data, data$type == "Virtual Thread")

data.1000 <- subset(data, data$requests == 10000)

### 1000 runs, 1000 requests

scatter_plot_1000 <- ggplot(data.1000) + geom_point(aes(y=time,x=run_number, color=type)) +
  facet_wrap(~requests.char, scales = "free") +
  labs(
    title = "Scatterplot of meassured benchmark times",
    y = "Time in seconds",
    color = "",
    caption = "500 Runs"
  ) +
  scale_color_manual(values = c("#5975A4","#CC8963")) + 
  theme(
    text = element_text(size = 14),
    plot.margin = margin(t = 0.5, r = 1.5, b = 0.5, l = 1, unit = "cm"),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    legend.position = "bottom"
  )

print(scatter_plot_1000)

ggsave(plot=scatter_plot_1000,"./Footprint/scatter_plot_10000.png",width=8.17,height=6.5)

linreg_plot_1000 <- ggplot(data.1000) + geom_smooth(method = "lm",aes(y=time,x=run_number, color=type), size = 1.2) +
  facet_wrap(~requests.char, scales = "free") +
  labs(
    title = "Linear Regression of meassured benchmark times",
    y = "Time in seconds",
    color = "",
    caption = "500 Runs"
  ) +
  scale_color_manual(values = c("#5975A4","#CC8963")) + 
  theme(
    text = element_text(size = 14),
    plot.margin = margin(t = 0.5, r = 1.5, b = 0.5, l = 1, unit = "cm"),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    legend.position = "bottom"
  )

print(linreg_plot_1000)

ggsave(plot=linreg_plot_1000,"./Footprint/linreg_plot_10000.png",width=8.17,height=6.5)


box_plot <- ggplot(data.1000) + geom_boxplot2(aes(y=time, fill=type), width = 0.5, width.errorbar = 0.1, size = 0.8) +
  facet_wrap(~requests.char, scales = "free") +
  labs(
    title = "Boxplots of meassured benchmark times",
    y = "Time in seconds",
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

ggsave(plot=box_plot,"./Footprint/boxplot_10000.png",width=8.17,height=6.5)

