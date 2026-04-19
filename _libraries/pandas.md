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
```

## 5 Read Data

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

# get first n rows of data frame
head: pd.DataFrame = df.head(n=3)

# get last n rows of data frame
head: pd.DataFrame = df.tail(n=3)

# get column headers of data frame
columns: pd.Index[str] = df.columns
columns[0] == "A"
columns.dtype == "str"

# get row indices of data frame
rows: pd.Index[str] = df.index
rows[0] == "x"
rows.dtype == "str"
```

### 5.2 Data about Data Frames

```python
import pandas as pd


df = pd.DataFrame(
    data=[[1, 2, 3], [4, 5, 6], [7, 8, 9]],
    columns=["A", "B", "C"],
    index=["x", "y", "z"],
)


# get number of rows in data frame
size: int = df.size

# get number of unique values in data frame
uniques_in_columns: pd.Series[int] = df.nunique()     # number of unique values per column
uniques_in_rows: pd.Series[int] = df.nunique(axis=1)  # number of unique values per row
uniques_in_column: int = df["A"].nunique()            # number of unique values in row

# print information about data frame to console
df.info()      # technical information
df.describe()  # statistical information
```

{% endraw %}
