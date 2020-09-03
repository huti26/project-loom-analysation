import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

sns.set(style="whitegrid")
sns.set_context("paper", font_scale=1.5)

data_t = pd.read_csv("../CSV/Megabytes/1000-1000-t.csv")
data_vt = pd.read_csv("../CSV/Megabytes/1000-1000-vt.csv")

data_t["Type"] = "Thread"
data_vt["Type"] = "Virtual Thread"

data = pd.concat([data_t, data_vt])

g = sns.catplot(x="Type", y="Used size",
                data=data, kind="box",
                height=4, aspect=.8, sharey=False, showfliers=False)

plt.title("1.000 Requests")

g.set_xlabels("")
g.set_ylabels("Used Heap in MB")
sns.despine(left=True, bottom=True)
g.set(xticks=[])

# plt.show()

plt.savefig("../Plots/heap_1000_box.png", dpi=300, bbox_inches='tight')
