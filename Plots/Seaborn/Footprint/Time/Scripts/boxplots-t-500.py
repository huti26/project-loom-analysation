import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
from matplotlib import ticker

sns.set(style="whitegrid")
sns.set_context("paper", font_scale=1.5)

# read all
data = pd.read_csv("../CSV/all.csv")

# filter Benchmarks
data = data.loc[data['runs'] == 500]
data = data.loc[data['type'] == "Thread"]

g = sns.catplot(x="type", y="time", col="requests",
                data=data, kind="box",
                height=4, aspect=.8, sharey=False, palette=['C0'], showfliers=False)

g.set(xticks=[])
g.set_xlabels("")
g.set_ylabels("Time in seconds")

g.set_titles("{col_name} Requests")

sns.despine(left=True, bottom=True)

# align y axis sizes
axes = g.axes.flatten()
for ax in axes:
    ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda y, pos: '{:,.3f}'.format(y)))

# plt.show()


plot_folder = "../Plots/"
plt.savefig(plot_folder + "boxplots-t-500.png", bbox_inches='tight')
