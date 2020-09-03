import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns

sns.set(style="white")
sns.set_context("paper", font_scale=1.5)

# read entire results
data = pd.read_csv("../CSV/jmh-result.csv")

# filter Benchmarks
data = data.loc[data['Benchmark'].str.contains("FreezeAndThaw")]

# names are long like absda.asddsa.casdas.yield -> filter to yield
data['Benchmark'] = data['Benchmark'].apply(lambda x: x.split(".")[-1])

# round relevant cols to ints
cols = ['Param: paramCount', 'Param: stackDepth', 'Score']
data[cols] = data[cols].applymap(np.int64)

g = sns.catplot(x="Param: paramCount", y="Score", hue="Benchmark", data=data,
                col="Param: stackDepth", col_wrap=4, kind="bar", sharey=False, legend=False)

g.despine(left=True)
g.set_ylabels("Time in nanoseconds")
g.set_xlabels("paramCount")
g.set_titles("stackDepth: {col_name}")

# further styling
# g.set(xlim=(-0.5,2.5))
g.set(yticks=[])


# show value on top of bars
def show_values_on_bars(axs):
    def _show_on_single_plot(ax):
        for p in ax.patches:
            _x = p.get_x() + p.get_width() / 2
            _y = p.get_y() + p.get_height()
            value = '{:.0f}'.format(p.get_height())
            ax.text(_x, _y + 10, value, ha="center")

    if isinstance(axs, np.ndarray):
        for idx, ax in np.ndenumerate(axs):
            _show_on_single_plot(ax)
    else:
        _show_on_single_plot(axs)


show_values_on_bars(g.axes)

plt.legend(loc='center left', bbox_to_anchor=(1.01, 0.5), frameon=False)

# plt.show()

plot_folder = "../Plots/"
plt.savefig(plot_folder + "FreezeAndThaw.png", bbox_inches='tight')
