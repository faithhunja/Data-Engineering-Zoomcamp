import sys
import pandas as pd

# print("arguments", sys.argv)

# day = int(sys.argv[1])

# # df = pd.DataFrame

# print(f'Running pipeline for day {day}')

df = pd.DataFrame({"A": [1, 2], "B": [3, 4]})
print(df)

df.to_parquet(f"output_day_{sys.argv[1]}.parquet")
prq = pd.read_parquet(f'output_day_{sys.argv[1]}.parquet')

print(prq)

print(f'Job finished successfully for day = {sys.argv[1]}')

