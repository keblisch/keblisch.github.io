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

## 5 Read Data Frames

### 5.1 Data from Data Frames

```python
import pandas as pd


df = pd.DataFrame(
    data=[[1, 2, 3], [4, 5, 6], [7, 8, 9]],
    columns=["A", "B", "C"],
    index=["x", "y", "z"],
)


# get specific column from data frame
a: Series[int] = df["A"]

# get specific row from data frame
x: Series[int] = df.loc["x"]

# get specific rows from data frame
xy: pd.DataFrame = df.loc[["x", "y"]]

# get range of rows from data frame
x_to_y: pd.DataFrame = df.loc["x":"y"]
x_to_end: pd.DataFrame = df.loc["x":]
start_to_y: pd.DataFrame = df.loc[:"y"]

# get first n rows of data frame
head: pd.DataFrame = df.head()  # first five
head = df.head(n=3)

# get last n rows of data frame
head: pd.DataFrame = df.tail()  # last five
head = df.tail(n=3)

# get n random rows of data frame
rand: pd.DataFrame = df.sample(n=5)

# get column headers of data frame
columns: pd.Index[str] = df.columns
columns[0] == "A"
columns.dtype == "str"

# get row indices of data frame
rows: pd.Index[str] = df.index
rows[0] == "x"
rows.dtype == "str"

# get unique values inside column
uniques: Series[int] = df["A"].unique()
```

### 5.2 Data about Data Frames

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

# get number of unique values in data frame
uniques_in_columns: pd.Series[int] = df.nunique()     # number of unique values per column
uniques_in_rows: pd.Series[int] = df.nunique(axis=1)  # number of unique values per row
uniques_in_column: int = df["A"].nunique()            # number of unique values in row

# print information about data frame to console
df.info()      # technical information
df.describe()  # statistical information
```

## 6 Export Data Frames

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
