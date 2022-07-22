library(ggplot2)

cbp1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
          "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

data <- read.csv("./Footprint/all.csv")

data <- subset(data, data$requests < 1000000)
data <- subset(data, data$runs == 100)

data$requests.char <- paste0(data$requests, " Requests")

data.t <- subset(data, data$type == "Thread")
data.vt <- subset(data, data$type == "Virtual Thread")


scatter_plot <- ggplot(data) + geom_point(aes(y=time,x=run_number, color=type)) +
  facet_wrap(~requests.char, scales = "free") +
  labs(
    title = "Scatterplot of meassured benchmark times",
    y = "Time in seconds",
    color = "",
    caption = "100 Runs"
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

print(scatter_plot)

ggsave(plot=scatter_plot,"./Footprint/scatter_plot_100.png",width=8.17,height=3.5)

linreg_plot <- ggplot(data) + geom_smooth(method = "lm",aes(y=time,x=run_number, color=type), size = 1.2) +
  facet_wrap(~requests.char, scales = "free") +
  labs(
    title = "Linear Regression of meassured benchmark times",
    y = "Time in seconds",
    color = "",
    caption = "100 Runs"
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

print(linreg_plot)

ggsave(plot=linreg_plot,"./Footprint/linreg_plot_100.png",width=8.17,height=3.5)
