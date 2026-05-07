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

| Language | Implementation       | License            | Current Version |
| :------- | :------------------- | :----------------- | :-------------- |
| Python   | Python<br>TypeScript | Apache-2.0 License | 1.57.0          |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Resources

- Official Streamlit website: [Streamlit](https://streamlit.io/)
- Streamlit repository: [streamlit/streamlit](https://github.com/streamlit/streamlit)
- Official Streamlit documentation: [Streamlit documentation](https://docs.streamlit.io/)
- Official Streamlit testing cheat sheet:
  [App testing cheat sheet](https://docs.streamlit.io/develop/concepts/app-testing/cheat-sheet)

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


# render text
st.text("Hello\nThis is my app!")


# render title
st.title(body="My Site")

# render heading
st.header(body="Hello")

# render subheading
st.subheader(body="How are you?")


# render info text
st.info(body="Something happened")

# render success text
st.success(body="Something succeeded")

# render error text
st.error(body="Something failed")


# render Markdown
st.write("# Hello\nThis is my app!")
```

### 5.2 Images

```python
import streamlit as st


# render local image
st.image(image="path/to/cat.jpg")

# render remote image
st.image(image="https://static.streamlit.io/examples/dog.jpg")

# render multiple images
st.image(image=[
    "path/to/cat.jpg",
    "https://static.streamlit.io/examples/dog.jpg",
])
```

### 5.3 Tables

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
st.line_chart(data={
    "First": [1, 10],
    "Second": [2, 20],
    "Third": [3, 30],
})

# render table from Pandas data frame
st.table(pd.DataFrame(
    columns=["First", "Second", "Third"],
    data=[
        [1, 2, 3],
        [10, 20, 30],
    ],
))
```

### 5.4 Widgets

```python
import streamlit as st


# render button and return whether it was pressed
pressed: bool = st.button(
    label="My Button",              # button label
    type="primary",                 # button style type (primary, secondary, tertiary)
    on_click=lambda: print("Hi!"),  # function to call on click
    key="button",                   # unique key for widget
)


# render text input field and return submitted value
text_input_value: str = st.text_input(
    label="My Text Input",    # text input label
    placeholder="Your name",  # text input placeholder
    value="",                 # starting value
    max_chars=100,            # maximum number of characters
    key="input",              # unique key for widget
)


# render text area field and return submitted value
text_area_value: str = st.text_area(
    label="My Text Area",     # text area label
    placeholder="Your name",  # text area placeholder
    value="",                 # starting value
    max_chars=100,            # maximum number of characters
    key="area",               # unique key for widget
)


# render checkbox and return whether it is checked
checkbox_value: bool = st.checkbox(
    label="My Checkbox",  # checkbox label
    value=False,          # starting value
    key="checkbox",       # unique key for widget
)


# render selectbox and return selected value
selectbox_value: int = st.selectbox(
    label="My Selectbox",  # selectbox value
    options=(1, 2, 3),     # selectbox options
    index=1,               # index of preselected option
    key="selectbox",       # unique key for widget
)


# render slider and return currently selected value
slider_value: float = st.slider(
    label="My Slider",  # slider label
    min_value=0,        # minimal value
    max_value=10,       # maximal value
    step=0.5,           # steps for value selection
    value=5,            # starting value
    key="slider",       # unique key for widget
)

# render range slider and return currently selected range
range_slider_value: tuple[float, float] = st.slider(
    min_value=0,
    max_value=10,
    step=0.5,
    value=(3, 6),  # starting range
)


# access widget value by its unique key
accessed_input: float = st.session_state.slider
```

### 5.5 Graphs

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
st.line_chart(data={
    "First": [1, 10],
    "Second": [2, 20],
    "Third": [3, 30],
})

# render graph from Pandas data frame
st.line_chart(pd.DataFrame(
    columns=["First", "Second", "Third"],
    data=[
        [1, 2, 3],
        [10, 20, 30],
    ],
))
```

### 5.6 Layouts

```python
import streamlit as st


# render elements in sidebar
st.sidebar.text("Hello")
name: str = st.sidebar.text_input(label="Your name")


# render elements in expander box
with st.expander(
        label="See this",  # expander label
        expanded=True,     # whether expander should already be expanded
        key="expander",    # unique key of expander
):
    st.text("Hi")
    is_active: bool = st.checkbox(label="Active")


# render elements in columns
col1, col2 = st.columns(spec=2)  # define columns
with col1:                       # place elements in specified column
    st.sidebar.text("Hello")
with col2:                       # place elements in specified column
    st.sidebar.text("Hi")
```

### 5.7 Messages

```python
import time

import streamlit as st


# render pop-up alert
st.toast(
    body="Something happened",  # alert text
    duration="long",            # duration of pop-up (short, long, infinite)
)


# render loading spinner as long as its block is processed
with st.spinner(
        text="Loading...",  # message to display
        show_time=True,     # whether to display passed time
):
    time.sleep(3)
    st.text(body="Ready!")
```

## 6 State

### 6.1 Caching

Streamlit can cache function calls to save computation on reruns of the script. They're only
rerun when their passed arguments, name or code changes.

```python
from transformers import pipeline, Pipeline
import streamlit as st


# cache serializable data by copying its original value
@st.cache_data
def greet(name: str, age: int) -> str:
    return f"Hello, I'm {name} and am {age} years old!"


# cache unserializable data by keeping its original value
@st.cache_resource
def load_model(pipeline_name: str) -> Pipeline:
    return pipeline(pipeline_name)
```

### 6.2 Database Connections

Streamlit enables a shorthand way to create database connections that are cached automatically.

```python
from typing import Any

import streamlit as st
from streamlit.connections import BaseConnection


# automatically create cached database connection based on definition in secrets.toml
conn: BaseConnection[Any] = st.connection(name="my_database")

# perform query on database connection
data: Any = conn.query("select * from my_table")
```

Database connections can be defined inside a `.streamlit/secrets.toml` file in the following way:

```toml
[connections.my_database]
type="sql"
dialect="mysql"
username="admin"
password="password"
host="localhost"
port=3306
database="my_database"
```

### 6.3 Sessions

Values can be cached across an entire user session by storing them in the session state. This
session state is unique to its according session and therefore its values aren't shared.

```python
import streamlit as st


# create value in session state
if "counter" not in st.session_state:
    st.session_state["counter"] = 0  # dictionary syntax
    st.session_state.counter = 0     # object syntax

# update value in session state
st.session_state["counter"] += 1  # dictionary syntax
st.session_state.counter += 1     # object syntax

# retrieve value from session state
st.text(f"This page has run {st.session_state["counter"]} times.")  # dictionary syntax
st.text(f"This page has run {st.session_state.counter} times.")     # object syntax
```

## 7 Paging

Streamlit supports splitting the application into multiple pages and navigation between them.

```python
import streamlit as st
from streamlit.navigation.page import StreamlitPage


# define pages
page_1: StreamlitPage = st.Page(page="path/to/page_1.py", title="Page 1", icon="🎈")
page_2: StreamlitPage = st.Page(page=lambda: st.markdown("# Page 2"), title="Page 2", icon="❄️")

# define navigation for pages
pg: StreamlitPage = st.navigation(
    pages=[page_1, page_2],
    position="top",  # sidebar (default), top or hidden
    expanded=True,   # False per default
)

# run first page in navigation
pg.run()
```

Alternatively a `pages` directory can be created besides the entry point of the application. Every
file in that directory is treated as a page and a navigation is created for them automatically.
Their page name is built from the file name where each underscore is treated as a whitespace.

## 8 Static Files

Static file serving has to be configured in a `.streamlit/config.toml` file to be enabled. Then every file
inside the `static` directory can be referenced as relative path and be served.

```python
import streamlit as st


st.markdown(body="[![Click me](static/cat.jpg)](https://streamlit.io)")
```

The following must be configured in `.streamlit/config.toml`:

```toml
[server]
enableStaticServing = true
```

## 9 Authentication

Streamlit supports authentication with OIDC via external providers. These provider connections
have to be configured inside a `.streamlit/secrets.toml` file.

```python
import streamlit as st


if not st.user.is_logged_in:  # check whether session is authenticated
    if st.button(label="Login"):
        st.login(provider="my_oidc_provider")  # login using specified OIDC provider profile
    st.stop()

if st.button(label="Logout"):
    st.logout()  # deauthenticate current session
```

OIDC provider profiles can be configured in the following way in `.streamlit/secrets.toml`:

```toml
[auth]
redirect_uri = "http://localhost:8501/oauth2callback"  # callback URL used by identity provider
cookie_secret = "abcdefghij0123456789"  # secret for signing auth cookie

# OIDC provider profile
[auth.providers.my_oidc_provider]
client_id = "CLIENT_ID"  # client ID of configured provider
client_secret = "CLIENT_SECRET"  # client secret of configured provider
server_metadata_url = "https://some-provider/.well-known/openid-configuration" # metadata endpoint
```

## 10 Testing

Streamlit supports integration tests by simulating user input in its testing framework. This
can be integrated seamlessly into any existing testing framework like Pytest.

```python
from streamlit.testing.v1 import AppTest


def test_increment_and_add():
    # create simulation of specified Streamlit page
    at: AppTest = AppTest.from_file(script_path="app.py").run()

    # set secrets for simulated application
    at.secrets["db_username"] = "john"
    at.secrets["db_password"] = "secret_password"

    # set session state for simulated application
    at.session_state["magic_word"] = "Balloons"

    # access page element
    val: str = at.markdown[0].value      # access by its index (by rendering order)
    val = at.markdown(key="bean").value  # access by its key (when set)

    # set content of page element
    at.markdown[0].set_value("No beans")

    # simulate incrementing of number input widget
    at.number_input[0].increment().run()

    # simulate pressing of button widget
    at.button[0].click().run()

    # check for content of page element
    assert at.markdown[0].value == "Beans counted: 1"

    # access elements of page element containers
    val = at.sidebar.checkbox[0].value
```

{% endraw %}
