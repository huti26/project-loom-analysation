import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

sns.set(style="whitegrid")
sns.set_context("paper", font_scale=1.5)

# read all
data = pd.read_csv("../CSV/all.csv")

# filter Benchmarks
data = data.loc[data['runs'] == 1000]

g = sns.FacetGrid(data=data, col="requests", sharey=False, hue="type", height=6)

g = g.map(sns.scatterplot, "run_number", "time", edgecolor="none", alpha=0.7)

sns.despine(left=True)
g.set(xticks=[])
g.set_xlabels("")
g.set_ylabels("Time in seconds")

# plt.legend(loc='center left', bbox_to_anchor=(1.01, 0.5), frameon=False)

axes = g.axes
axes[0][0].set(ylim=(0, 0.4), title="1000 Requests")

# plt.show()

plot_folder = "../Plots/"
plt.savefig(plot_folder + "scatter-1000.png", bbox_inches='tight')
