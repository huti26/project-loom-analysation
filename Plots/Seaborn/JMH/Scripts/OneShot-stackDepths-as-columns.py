import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns

sns.set(style="whitegrid")
sns.set_context("paper", font_scale=1.5)

# read entire results
data = pd.read_csv("../CSV/jmh-result.csv")

# filter Benchmarks
data = data.loc[data['Benchmark'].str.contains("OneShot")]

# names are long like absda.asddsa.casdas.yield -> filter to yield
data['Benchmark'] = data['Benchmark'].apply(lambda x: x.split(".")[-1])

# round relevant cols to ints
cols = ['Param: paramCount', 'Param: stackDepth', 'Score']
data[cols] = data[cols].applymap(np.int64)

g = sns.catplot(x="Param: paramCount", y="Score", hue="Benchmark", data=data,
                hue_order=["noYield", "yield", "yieldThenContinue", "yieldAfterEachCall", "yieldBeforeEachCall",
                           "yieldBeforeAndAfterEachCall"],
                col="Param: stackDepth", col_wrap=4, kind="bar", sharey=False, legend=False)

g.despine(left=True)
g.set_ylabels("Time in nanoseconds")
g.set_xlabels("paramCount")
g.set_titles("stackDepth: {col_name}")

plt.legend(loc='center left', bbox_to_anchor=(1.01, 0.5), frameon=False)

# plt.show()

plot_folder = "../Plots/"
plt.savefig(plot_folder + "OneShot-stackDepths-as-columns.png", bbox_inches='tight')
