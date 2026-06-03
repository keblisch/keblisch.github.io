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

## 4 Interfaces

```python
import gradio as gr


# define callback to model
def greet(first: str, age: str) -> str:
    return f"Hello, my name is {name} and I'm {age}!"


# define interface for callback
app: gr.Interface = gr.Interface(
    fn=greet,                   # callback to model
    inputs=["text", "text"],    # input type or types for callback
    outputs="text",             # output type or types for callback
    examples=[("John", "18")],  # example inputs to provide
    flagging_mode="never",      # when to flag output (manual, auto, never)
)
```

### 4.1 Chat Interfaces

```python
import gradio as gr


# define callback for chats
def chat(
    message: str,                   # user prompt to sent
    history: list[dict[str, str]],  # OpenAI API conform chat history to use
) -> str:
    return "understood."  # assistant response to send


# define chat interface for chat callback
chat: gr.ChatInterface = gr.ChatInterface(
    fn=chat,                            # chat callback to model (updates history automatically)
    title="My Chatbot",                 # title of the chat
    description="This is my chatbot.",  # description of the chat
)
```

## 5 Launching

```python
import gradio as gr


app: gr.Interface = gr.Interface(
    fn=lambda name, age: f"Hello, my name is {name} and I'm {age}!",
    inputs=["text", "text"],
    outputs="text",
)


# launch server that serves interface
app.launch(
    share=True,                   # create public link that tunnels to the locally running app
    inbrowser=True,               # open app automatically in new browser tab
    auth=[("user", "password")],  # require authentication with one of the provided credentials
    js="alert('Hello!');",        # execute JavaScript
)
```

## 6 Widgets

```python
import gradio as gr


# define widgets for input and output
name_widget: gr.Text = gr.Text(label="Name")
age_widget: gr.Text = gr.Text(label="Age")
greeting_widget: gr.Text = gr.Text(label="Greeting")


app: gr.Interface = gr.Interface(
    fn=lambda name, age: f"Hello, my name is {name} and I'm {age}!",
    inputs=[name_widget, age_widget],  # widget or widgets to use for input
    outputs=greeting_widget,           # widget or widgets to use for output
)
```

### 6.1 Text Fields

```python
import gradio as gr


text_field: gr.Text = gr.Text(
    label="Name",
    info="Please enter your name",
    placeholder="Your name",
    value="John",
    lines=1,
    max_lines=1,
    max_length=32,
)
```

### 6.2 Text Boxes

```python
import gradio as gr


text_box: gr.Textbox = gr.Textbox(
    label="Description",
    info="Please enter a description",
    placeholder="Description goes here...",
    value="This is a description!",
    lines=4,
    max_lines=8,
    max_length=32,
)
```

### 6.3 Dropdowns

```python
import gradio as gr


dropdown: gr.Dropdown = gr.Dropdown(
    label="Your gender",
    choices=["Male", "Female", "No Answer"],
    value="No Answer",
)
```

### 6.4 Markdown

```python
import gradio as gr


mardown: gr.Markdown = gr.Markdown(
    label="Notes",
    value="# Notes<br><br>These are my notes.",
)
```

{% endraw %}
