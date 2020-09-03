import pandas as pd

# read entire results
data = pd.read_csv("./CSV/jmh-result.csv")

# filter Benchmarks
data = data.loc[data['Benchmark'].str.contains("OneShot")]

# names are long like absda.asddsa.casdas.yield -> filter to yield
data['Benchmark'] = data['Benchmark'].apply(lambda x: x.split(".")[-1])

data.to_csv("./CSV/R-OneShot.csv")
