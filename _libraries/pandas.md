---
layout: base
title: Pandas
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# Pandas
{: .no_toc }

Pandas is a library to analyze and manipulate data.

| Language  | Implementation | License              | Current Version |
| :-------- | :------------- | :------------------- | :-------------- |
| Python    | Python (NumPy) | BSD 3-Clause License | 3.0.2           |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Resources

- Official Pandas website: [Pandas](https://pandas.pydata.org/)
- Official Pandas user guide: [User Guide](https://pandas.pydata.org/docs/user_guide/index.html)
- Official Pandas API reference:
  [API Reference](https://pandas.pydata.org/docs/reference/index.html)

## 2 Installation

```bash
# install with pip
pip install pandas

# install with uv
uv add pandas

# install with poetry
poetry add pandas
```

## 3 Concepts

Pandas works mainly with the following data types

- **Data frames**: Two-dimensional matrices with high flexibility used to represent most data
- **Series**: One-dimensional array with high flexibility mainly used to represent rows and
              columns of data frames
- **Index**: Unmutable one-dimensional array mainly used to represent vectors of indices and
             headers

## 4 Create Data Frames

```python
import pandas as pd


# create empty data frame
df: pd.DataFrame = pd.DataFrame()

# create data frame from two-dimensional array
df = pd.DataFrame(data=[[1, 2, 3], [4, 5, 6], [7, 8, 9]])

# create data frame with named column headers
df = pd.DataFrame(data=[[1, 2, 3], [4, 5, 6]], columns=["A", "B", "C"])

# create data frame with named row indices
df = pd.DataFrame(data=[[1, 2, 3], [4, 5, 6]], index=["x", "y", "z"])

# create data frame from CSV file
df = pd.read_csv(filepath_or_buffer="path/to/file.csv")          # from file
df = pd.read_csv(filepath_or_buffer="https://path/to/file.csv")  # from URL

# create data frame from Excel file
df = pd.read_excel(io="path/to/file.xlsx")                        # from file
df = pd.read_excel(io="https://path/to/file.xlsx")                # from URL
df = pd.read_excel(io="path/to/file.xlsx", sheet_name="results")  # specific sheet of Excel file

# create data frame from Parquet file
df = pd.read_parquet(path="path/to/file.parquet")          # from file
df = pd.read_parquet(path="https://path/to/file.parquet")  # from URL

# create data frame from Feather file
df = pd.read_feather(path="path/to/file.feather")          # from file
df = pd.read_feather(path="https://path/to/file.feather")  # from URL
```

## 5 Describe Data Frames

```python
import pandas as pd


df = pd.DataFrame(
    data=[[1, 2, 3], [4, 5, 6]],
    columns=["A", "B", "C"],
    index=["x", "y", "z"],
)


# get number of rows in data frame
size: int = df.size

# get shape of data frame
shape: tuple[int, int] = df.shape
shape == (3, 2)

# get first n rows of data frame
head: pd.DataFrame = df.head()  # first five
head = df.head(n=3)

# get last n rows of data frame
head: pd.DataFrame = df.tail()  # last five
head = df.tail(n=3)

# get n random rows of data frame
rand: pd.DataFrame = df.sample(n=5)

# get number of unique values in data frame
uniques_in_columns: pd.Series[int] = df.nunique()     # number of unique values per column
uniques_in_rows: pd.Series[int] = df.nunique(axis=1)  # number of unique values per row
uniques_in_column: int = df["A"].nunique()            # number of unique values in row

# get unique values inside column
uniques: Series[int] = df["A"].unique()

# print information about data frame to console
df.info()      # technical information
df.describe()  # statistical information
```

## 6 Access Data Frames

```python
import pandas as pd


df = pd.DataFrame(
    data=[[1, 2, 3], [4, 5, 6], [7, 8, 9]],
    columns=["A", "B", "C"],
    index=["x", "y", "z"],
)


# access specific column from data frame
a: Series[int] = df["A"]
a = df.A

# access specific rows from data frame
row: Series[int] = df.loc["x"]                    # single row
xyz: pd.DataFrame = df.loc[["x", "y", "z"]]     # multiple rows
x_ab: pd:dataFrame = df.loc["x", ["A", "B"]]    # only with specific columns
i_x: pd.DataFrame = df.iloc[[0, 1, 2], [0, 1]]  # by their index

# access range of rows from data frame
x_to_y: pd.DataFrame = df.loc["x":"y"]                 # between to indices
x_to_end: pd.DataFrame = df.loc["x":]                  # from index to end
start_to_y: pd.DataFrame = df.loc[:"y"]                # from beginning to index
x_to_y_ab: pd.DataFrame = df.loc["x":"y", ["A", "B"]]  # only with specific columns
i_x_to_y: pd.DataFrame = df.iloc[0:2, [0, 1]]          # by their index (upper exclusive)

# access specific column from row
row_element: int = df.loc["x"]["A"]

# access specific cell from data frame
cell: int = df.at["y", "B"]   # by row and column name
cell = df.loc["y", "B"]
i_cell: int = df.iat[1, 1]    # by row and column index
i_cell = df.loc[1, 1]

# access column headers of data frame
columns: pd.Index[str] = df.columns
columns[0] == "A"
columns.dtype == "str"

# access row indices of data frame
rows: pd.Index[str] = df.index
rows[0] == "x"
rows.dtype == "str"

# iterate through rows
for idx, row in df.iterrows():
    print(f"{idx}: {row}")
```

## 7 Manipulate Data Frames

```python
import pandas as pd


df = pd.DataFrame(
    data=[[1, 2, 3], [4, 5, 6]],
    columns=["A", "B", "C"],
    index=["x", "y", "z"],
)


# sort columns of data frame
sorted_df: pd.DataFrame = pd.sort_values(by="A")             # by single column
sorted_df = pd.sort_values(by=["A", "B"])                    # by multiple columns
sorted_df = pd.sort_values(by="A", ascending=False)          # in descending order
sorted_df = pd.sort_values(
    by=["A", "B"],
    ascending=[0, 1],  # set ascending sorting for columns (0 for false, 1 for true)
)

# filter data frame by column values
filtered: pd.DataFrame = df.loc[df["A"] > 1]       # single condition
filtered = df.loc[(df["A"] > 1) & (df["B"] < 5>)]  # multiple conditions
filtered = df[df["A"] > 1]                         # shorthand syntax
filtered = df.loc[df["A"] > 1, ["B", "C"]]         # only return specific columns

# filter data frame by column values
```

## 8 Export Data Frames

```python
import pandas as pd


df = pd.DataFrame(
    data=[[1, 2, 3], [4, 5, 6]],
    columns=["A", "B", "C"],
    index=["x", "y", "z"],
)


# save data frame as CSV file
df.to_csv(path_or_buf="path/to/file.csv")

# save data frame as Excel file
df.to_excel(excel_writer="path/to/file.xlsx")

# save data frame as Parquet file
df.to_parquet(path="path/to/file.parquet")

# save data frame as Feather file
df.to_feather(path="path/to/file.parquet")
```

{% endraw %}
