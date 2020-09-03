import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns

sns.set(style="whitegrid")
sns.set_context("paper", font_scale=1.5)

# read entire results
data = pd.read_csv("../CSV/jmh-result.csv")

# filter Benchmarks
data = data.loc[data['Benchmark'].str.contains("Oscillation")]

# round relevant cols to ints
cols = ['Param: minDepth', 'Param: maxDepth', 'Param: repeat', 'Score']
data[cols] = data[cols].applymap(np.int64)

g = sns.catplot(x="Param: minDepth", y="Score", hue="Param: maxDepth", data=data,
                col="Param: repeat", col_wrap=3, kind="bar", sharey=False, legend=False)

g.despine(left=True)
g.set_ylabels("Time in nanoseconds")
g.set_xlabels("minDepth")
g.set_titles("repeat: {col_name}")

# first column didnt have same scaling as others
ax = g.axes
ax[0].set_ylim(0, 7000)

plt.legend(loc='center left', bbox_to_anchor=(1.01, 0.5), title="maxDepth", frameon=False)

# plt.show()

plot_folder = "../Plots/"
plt.savefig(plot_folder + "Oscillation.png", bbox_inches='tight')
