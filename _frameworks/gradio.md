---
layout: base
title: Gradio
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# Gradio
{: .no_toc }

Gradio is an opinionated web framework for building entire web apps with minimalistic Python
code and is mainly used for LLM interaction.

| Language  | Implementation | License            | Current Version |
| :-------- | :------------- | :----------------- | :-------------- |
| Python    | Python         | Apache-2.0 License | 6.15.2          |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Resources

- Official website: [Gradio](https://www.gradio.app/)
- Official documentaion: [Quickstart](https://www.gradio.app/guides/quickstart)
- Official repository: [gradio-app/gradio](https://github.com/gradio-app/gradio)

## 2 Installation

```bash
# with pip
pip install gradio

# with uv
uv add gradio

# with poetry
poetry add gradio
```

## 3 Data Flow

Gradio automatically generates a frontend from defined components and connects these components
to Python callbacks. Components define which values are read from the frontend and which values
are written back to it.

Whenever a user event is triggered, Gradio sends the current component values to the backend,
calls the connected callback and updates the output components with the returned values. For
complex applications this data flow can be declared explicitly with blocks and event listeners.

To optimize this, long-running operations can be handled through Gradio's queue and persistent
per-session data can be stored in its session state.

## 4 Usage

```python
import gradio as gr


# define callback to model
def greet(first: str, second: str) -> str:
    return f"Hello, {first} and {second}!"


# define interface for callback
app: gr.Interface = gr.Interface(
    fn=greet,                 # callback to model
    inputs=["text", "text"],  # input type or types for callback
    outputs="text",           # output type or types for callback
)

# run application as server
app.launch()
```

{% endraw %}
