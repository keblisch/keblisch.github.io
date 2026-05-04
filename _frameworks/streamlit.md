---
layout: base
title: Streamlit
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# Streamlit
{: .no_toc }

Streamlit is an opinionated web framework for building entire web apps with minimalistic Python
code and is mainly used for data visualization.

| Language  | Implementation       | License            | Current Version |
| :-------- | :------------------- | :----------------- | :-------------- |
| Python    | Python<br>TypeScript | Apache-2.0 License | 1.57.0          |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Resources

- Official Streamlit website: [Streamlit](https://streamlit.io/)
- Streamlit repository: [streamlit/streamlit](https://github.com/streamlit/streamlit)
- Official Streamlit documentation: [Streamlit documentation](https://docs.streamlit.io/)

## 2 Installation

```bash
# with pip
pip install streamlit

# with uv
uv add streamlit

# with poetry
poetry add streamlit
```

## 3 Startup

Streamlit apps can't be run from Linux root directories, which is relevant in the context of
Docker containers.

```bash
# run Streamlit demo
streamlit hello

# run Streamlit app
streamlit run main.py            # via Streamlit itself
python -m streamlit run main.py  # via Python
```

## 4 Data Flow

Streamlit generates frontends automatically from procedural Python code. To allow the entire
application is rerun whenever an update has to be performed on the frontend. This happens whenever
the source code was modified or a widget was updated by the user.

To optimize this many caching operations are performed automatically in the background, but can
and should also be performed explicitly for computation heavy or IO operations.

## 5 Rendering

Top-level variables in the entry point are automatically rendered by Streamlit via the `write`
function.

```python
import pandas as pd
import streamlit as st


# render value or data structure automatically in according format
st.write(pd.DataFrame({"first column": [1, 2, 3], "second column": [10, 20, 30]}))
```

### 5.1 Text

```python
import streamlit as st


# render Markdown text
st.write("# Hello\nThis is my app!")
```

### 5.2 Tables

```python
import pandas as pd
import streamlit as st


# render static table
st.table(data=[
    {"First": 1, "Second": 2, "Third": 3},
    {"First": 10, "Second": 20, "Third": 30},
])


# render interactive table
st.data_frame(data=[
    {"First": 1, "Second": 2, "Third": 3},
    {"First": 10, "Second": 20, "Third": 30},
])


# render editable table that returns updated data on updates
updated: list[dict[str, int]] = st.data_editor(
    data=[
        {"First": 1, "Second": 2, "Third": 3},
        {"First": 10, "Second": 20, "Third": 30},
    ],
    num_rows="dynamic",  # whether rows should be addable/deletable (static, dynamic, add, delete)
)


# render table from two-dimensional list
st.table(data=[
    [1, 2, 3],
    [10, 20, 30],
])

# render table from list of dictionaries with keys as column headers
st.table(data=[
    {"First": 1, "Second": 2, "Third": 3},
    {"First": 10, "Second": 20, "Third": 30},
])

# render table from Pandas data frame
st.table(pd.DataFrame(
    columns=["First", "Second", "Third"],
    data=[
        [1, 2, 3],
        [10, 20, 30],
    ],
))
```

### 5.3 Graphs

```python
import pandas as pd
import streamlit as st


# render line chart from table-like structure where each column represents one line
st.line_chart(data=[
    {"First": 1, "Second": 2, "Third": 3},
    {"First": 10, "Second": 20, "Third": 30},
])


# render graph from two-dimensional list
st.line_chart(data=[
    [1, 2, 3],
    [10, 20, 30],
])

# render graph from list of dictionaries with keys as column headers
st.line_chart(data=[
    {"First": 1, "Second": 2, "Third": 3},
    {"First": 10, "Second": 20, "Third": 30},
])

# render graph from Pandas data frame
st.line_chart(pd.DataFrame(
    columns=["First", "Second", "Third"],
    data=[
        [1, 2, 3],
        [10, 20, 30],
    ],
))
```

{% endraw %}
