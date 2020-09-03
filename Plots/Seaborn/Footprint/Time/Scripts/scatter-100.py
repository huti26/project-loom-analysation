import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
from matplotlib import ticker

sns.set(style="whitegrid")
sns.set_context("paper", font_scale=1.5)

# read all
data = pd.read_csv("../CSV/all.csv")

# filter Benchmarks
data = data.loc[data['runs'] == 100]
data = data.loc[data['requests'] <= 100000]

g = sns.FacetGrid(data=data, col="requests", sharey=False, hue="type", height=4)

g = g.map(sns.scatterplot, "run_number", "time", edgecolor="none", alpha=0.7)

sns.despine(left=True)
g.set(xticks=[])
g.set_xlabels("")
g.set_ylabels("Time in seconds")

axes = g.axes
axes[0][0].set(ylim=(0, 0.4))
axes[0][1].set(ylim=(0.25, 1.5))
axes[0][2].set(ylim=(2.5, 7))

g.set_titles("{col_name} Requests")

# align y axis sizes
axes = g.axes.flatten()
for ax in axes:
    ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda y, pos: '{:,.2f}'.format(y)))

# plt.show()

plot_folder = "../Plots/"
plt.savefig(plot_folder + "scatter-100.png", bbox_inches='tight')
