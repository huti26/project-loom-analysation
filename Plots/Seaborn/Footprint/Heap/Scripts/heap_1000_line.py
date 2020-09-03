import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns

sns.set(style="white")

megabytes_folder = "../CSV/Megabytes/"

file_path_t = megabytes_folder + "1000-1000-t.csv"
file_path_vt = megabytes_folder + "1000-1000-vt.csv"

df_t = pd.read_csv(file_path_t)
df_vt = pd.read_csv(file_path_vt)

x_t = np.linspace(0, 172, 172)
x_vt = np.linspace(0, 37, 37)

t_values = df_t["Used size"]
vt_values = df_vt["Used size"]

plt.plot(x_t, t_values, alpha=0.5, label="Thread")
plt.plot(x_vt, vt_values, alpha=0.5, label="Virtual Thread")

plt.ylim(0, 600)
plt.xlim(0, 200)

plt.fill_between(x_t, t_values, alpha=0.7)
plt.fill_between(x_vt, vt_values, alpha=0.7)

plt.xlabel("Time in seconds")
plt.ylabel("Used Heap in MB")

plt.title("1.000 Requests")

# plt.show()

plt.savefig("../Plots/heap_1000_line.png", dpi=300, bbox_inches='tight',
                height=4, aspect=.8,)
