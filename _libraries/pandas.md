---
layout: base
title: Pandas
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# Pandas
{: .no_toc }

Pandas is a library to analyze and manipulate data.

| Language | Implementation   | License              | Current Version |
| :------- | :--------------- | :------------------- | :-------------- |
| Python   | Python/C (NumPy) | BSD 3-Clause License | 3.0.2           |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Resources

- Official Pandas website: [Pandas](https://pandas.pydata.org/)
- Pandas repository: [pandas-dev/pandas](https://github.com/pandas-dev/pandas)
- Official Pandas user guide: [User Guide](https://pandas.pydata.org/docs/user_guide/index.html)
- Official Pandas API reference:
  [API Reference](https://pandas.pydata.org/docs/reference/index.html)

## 2 Installation

```bash
# install with pip
pip install pandas
pip install pandas-stubs  # type hint support

# install with uv
uv add pandas
uv add pandas-stubs  # type hint support

# install with poetry
poetry add pandas
poetry add pandas-stubs  # type hint support
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

# copy data frame
copied_df: pd.DataFrame = df.copy()

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
    data=[[1, 2, 3, "hi", "2000-12-31"], [2, 3, 4, "hello", "2000-12-31"]],
    columns=["A", "B", "C", "D", "Date"],
    index=["x", "y"],
)


# add/replace column to/of data frame
df["F"] = [3, "hey", True]

# drop column of data frame
dropped: pd.DataFrame = df.drop(index=2)  # by index
dropped = df.drop(labels=["F"])           # by column name
df.drop(index=2, inplace=True)            # in place

# rename column
renamed: pd.DataFrame = df.rename(columns={"E": "e"})
df.rename(columns={"e": "E"}, inplace=True)  # in place

# convert data type of column
df["Date"] = pd.to_datetime(df["Date"])

# sort column
sorted_df: pd.DataFrame = pd.sort_values(by="A")             # by single column
sorted_df = pd.sort_values(by=["A", "B"])                    # by multiple columns
sorted_df = pd.sort_values(by="A", ascending=False)          # in descending order
sorted_df = pd.sort_values(
    by=["A", "B"],
    ascending=[0, 1],  # set ascending sorting for columns (0 for false, 1 for true)
)

# reset index of data frame
reset: pd.DataFrame = df.reset_index()

# filter data frame
filtered: pd.DataFrame = df.loc[df["A"] > 1]       # with single condition
filtered = df.loc[(df["A"] > 1) & (df["B"] < 5>)]  # with multiple AND conditions
filtered = df.loc[(df["A"] > 1) | (df["B"] < 5>)]  # with multiple OR conditions
filtered = df[df["A"] > 1]                         # shorthand syntax
filtered = df.loc[df["A"] > 1, ["B", "C"]]         # only return specific columns

# filter data frame by numbers
num_filtered: pd.DataFrame = df[df["A"] > 1 & df["C"] == 3]

# filter data frame by strings
str_filtered: pd.DataFrame = df[df["B"].str.contains(pat="hi|hello")]  # contains RegEx pattern
str_filtered = df[df["B"].str.contains(pat="hi", regex=False)]         # contains raw string
str_filtered = df[df["B"].str.contains(pat="h", case=False)]           # case insensitive

# filter data frame by datetime
date_filtered: pd.DataFrame = df[df["Date"].dt.year > 1999]
date_filtered = df[df["Date"].dt.is_leap_year]
date_filtered = df[df["Date"].dt.year > 1999, format="%d.%m.%Y"]  # specify datetime format

# filter data frame by list elements
str_filtered = df[df["B"].isin(values=["hi", "hello"])]

# filter data frame by any condition
df.query(expr="A < 3 and B == 'hi'")

# merge data frames
merged: pd.DataFrame = pd.merge(
    left=df, right=dropped,     # data frames to merge
    left_on="A", right_on="B",  # columns to merge on
    how="inner",                # merge behavior (inner, left, right)
    suffixes=["_1", "_2"],      # suffix for identical column names (_x and _y per default)
)

# append rows of data frames to other data frame
appended: pd.DataFrame = pd.concat(objs=[df, dropped])

# handle NaN values
nan_handled: pd.DataFrame = df.fillna(value=0)  # replace NaN
nan_handled = df.dropna()                       # drop rows with NaN
nan_handled = df.dropna(subset=["A", "B"])      # drop rows with NaN in specific columns
df.dropna(inplace=True)                         # drop rows with NaN in place
nan_handled = df.isna()                         # get only rows with NaN
nan_handled = df.notna()                        # get only rows without NaN

# apply function on data frame
applied_df: pd.DataFrame = df.apply(f=lambda x: x * 2)  # on every column
applied_df = df.apply(f=lambda x: x * 2, axis=1)        # on every row
df["C"] = df["C"].apply(func=lambda x: x * 2)           # on every cell of column
```

## 8 Aggregate Data Frames

```python
import pandas as pd


df = pd.DataFrame(
    data=[[1, 2, 3], [4, 5, 6], [7, 8, 9]],
    columns=["A", "B", "C"],
    index=["x", "y", "z"],
)


# get statistical information about data frame
mean: float = df["A"].mean()                          # mean of column
counts: pd.Series[int] = df[A].value_counts()         # count of each value
df_sum: pd.Series[int] = df.sum()                     # sum each column
column_sum: int = df["A"].sum()                       # sum single column
uniques_in_columns: pd.Series[int] = df.nunique()     # number of unique values per column
uniques_in_rows: pd.Series[int] = df.nunique(axis=1)  # number of unique values per row
uniques_in_column: int = df["A"].nunique()            # number of unique values in row

# get unique values inside column
uniques: Series[int] = df["A"].unique()

# group values in columns of data frame that are equal and perform function on these
grouped: pd.DataFrame = df.groupby(by=["A"]).sum()                  # group column
grouped = df.groupby(by=["A", "B"]).sum()                           # nested grouping
grouped = df.groupby(by=["A"]).agg(func={"A": "sum", "B": "mean"})  # specify function for column
```

## 9 Export Data Frames

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
