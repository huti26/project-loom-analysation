import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

sns.set(style="whitegrid")
sns.set_context("paper", font_scale=1.5)

# read all
data = pd.read_csv("../CSV/all.csv")

# filter Benchmarks
data = data.loc[data['runs'] == 1000]

g = sns.lmplot("run_number", "time", hue="type", col="requests", sharey=False, data=data,
               legend=False, scatter=False, truncate=True)

sns.despine(left=True)
g.set(xticks=[])
g.set_xlabels("")
g.set_ylabels(" ")

g.set_titles("{col_name} Requests")

axes = g.axes
axes[0][0].set(ylim=(0, 0.4))

# plt.legend(loc='center left', bbox_to_anchor=(1.01, 0.5), frameon=False)


# plt.show()


plot_folder = "../Plots/"
plt.savefig(plot_folder + "linres-1000.png", bbox_inches='tight')
