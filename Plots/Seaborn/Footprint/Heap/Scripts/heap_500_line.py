import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns

sns.set(style="white")

file_path_t = "../CSV/Megabytes/500-10000-t.csv"
file_path_vt = "../CSV/Megabytes/500-10000-vt.csv"

df_t = pd.read_csv(file_path_t)
df_vt = pd.read_csv(file_path_vt)

x_t = np.linspace(0, 294, 294)
x_vt = np.linspace(0, 147, 147)

t_values = df_t["Used size"]
vt_values = df_vt["Used size"]

plt.plot(x_t, t_values, alpha=0.5, label="Thread")
plt.plot(x_vt, vt_values, alpha=0.5, label="Virtual Thread")

plt.ylim(0, 450)
plt.xlim(0, 310)

plt.fill_between(x_t, t_values, alpha=0.7)
plt.fill_between(x_vt, vt_values, alpha=0.7)

plt.xlabel("Time in seconds")
plt.ylabel("Used Heap in MB")

plt.title("10.000 Requests")

# plt.show()

plt.savefig("../Plots/heap_500_line.png", dpi=300, bbox_inches='tight',
                height=4, aspect=.8,)
