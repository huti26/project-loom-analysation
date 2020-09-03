import os

import pandas as pd


def bytes_to_megabytes(n):
    return round(n * 0.000001)


byte_dir = os.getcwd() + "/CSV/Bytes/"
megabyte_dir = os.getcwd() + "/CSV/Megabytes/"

for subdir, dirs, files in os.walk(byte_dir):
    for file in files:
        df = pd.read_csv(byte_dir + file)

        df["Committed size"] = df["Committed size"].apply(bytes_to_megabytes)
        df["Free size"] = df["Free size"].apply(bytes_to_megabytes)
        df["Used size"] = df["Used size"].apply(bytes_to_megabytes)

        df.to_csv(megabyte_dir + file)
