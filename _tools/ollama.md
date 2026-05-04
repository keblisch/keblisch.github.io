---
layout: base
title: Ollama
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# Ollama
{: .no_toc }

Ollama is a tool to download, run and manage LLMs locally.

| Usage      | Implementation | License     | Current Version |
| :--------- | :------------- | :---------- | :-------------- |
| CLI<br>API | Golang         | MIT License | 0.22.1          |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Resources

- Official Ollama website: [Ollama](https://ollama.com/)
- Ollama repository: [ollama/ollama](https://github.com/ollama/ollama)
- Official Ollama documentation: [Ollama's documentation](https://docs.ollama.com/)
- Official Python bindings: [ollama/ollama-python](https://github.com/ollama/ollama-python)

## 2 Installation

Install/update Ollama itself:

```bash
# for Linux and Mac
curl -fsSL https://ollama.com/install.sh | sh

# for Windows
irm https://ollama.com/install.ps1 | iex
```

Install Ollama's Python bindings:

```bash
# with pip
pip install ollama

# with uv
uv add ollama

# with poetry
poetry add ollama
```

## 3 Launch

Ollama runs as a server that listens on port 11434 to which clients can send requests.

```bash
# set host and port of Ollama server
export OLLAMA_HOST="127.0.0.1:11434"  # default

# start ollama server
ollama serve

# start interactive Ollama session
ollama

# start interactive Ollama session with specified tool
ollama launch openclaw

# get overview of available ollama commands
ollama help
```

## 4 Models

All LLM models that can be downloaded and managed via Ollama can be seen here:
[https://ollama.com/library](https://ollama.com/library).

### 4.1 CLI

```bash
# download specified LLM with specified tag
ollama pull gemma4:e4b

# show detailed information for downloaded LLM with specified tag
ollama show gemma4:e4b

# delete specified LLM with specified tag
ollama rm gemma4:e4b

# show all installed LLMs and information about them
ollama list

# show all running LLMs and information about them
ollama ps

# copy specified LLM with specified tag
ollama cp gemma4:e4b my-gemma

# create custom LLM based on existing LLM and configured by Modelfile
ollama create my-custom-llm -f path/to/Modelfile
```

Modelfiles are used to configure custom models and are text files with the following format:

```text
FROM gemma4:e4b

SYSTEM You are a helpful learning assistant
that generates quiz questions.

PARAMETER temperature 0.1
PARAMETER num_ctx 4096
```

### 4.2 Python API

```python
import ollama
from ollama import ListResponse, ProcessResponse, ShowResponse, StatusResponse


# download specified LLM with specified tag
ollama.pull(model="gemma4:e4b")

# show detailed information for downloaded LLM with specified tag
info: ShowResponse = ollama.show(model="gemma4:e4b")

# delete specified LLM with specified tag
success: StatusResponse = ollama.delete("gemma4:e4b")

# show all installed LLMs and information about them
models: ListResponse = ollama.list()

# show all running LLMs and information about them
process: ProcessResponse = ollama.ps()

# copy specified LLM with specified tag
ollama.copy(source="gemma4:e4b", destination="my-gemma")

# create custom LLM based on existing LLM and configure it
ollama.create(
    model="my-custom-llm",
    from="gemma4:e4b",
    system="You are a helpful learning assistant that generates quiz questions.",
    parameters={
        "temperature": 0.1,
        "num_ctx": 4096,
    },
)
```

## 5 Chats

### 5.1 CLI

```bash
# start chat for specified LLM with specified tag
ollama run gemma4:e4b

# stop specified LLM with specified tag
ollama stop gemma4:e4b

# make multiline input to LLM chat
#>>> """Hello,
#... world!
#... """
```

### 5.2 Python API

```python
from typing import Iterator

import ollama
from ollama import ChatResponse, GenerateResponse, ResponseError


# create single request to specified LLM with specified tag
response: GenerateResponse = ollama.generate(
    model="gemma4:e4b",
    system="You are a helpful learning assistant that generates quiz questions.",  # optional
    prompt="What is the capital of germany?",
)
answer: str = response.message.content  # access response text
user: str = response.message.role       # access response author

# create single request to specified LLM with specified tag and get response as stream
response_stream: Iterator[GenerateResponse] = ollama.generate(
    model="gemma4:e4b",
    system="You are a helpful learning assistant that generates quiz questions.",  # optional
    prompt="What is the capital of germany?",
    stream=True,
)
answer = response_stream.message.content  # access response text
user = response_stream.message.role       # access response author

# create single request to specified LLM with specified tag and get thinking process additionally
response: GenerateResponse = ollama.generate(
    model="gemma4:e4b",
    system="You are a helpful learning assistant that generates quiz questions.",  # optional
    prompt="What is the capital of germany?",
    think=True,
)
thinking: str = response.message.thinking  # access thinking process
answer = response.message.content          # access response text
user = response.message.role               # access response author


# create chat for specified LLM with specified tag
chat_response: ChatResponse = ollama.chat(
    model="gemma4:e4b",
    messages=[
        {"role": "user", "content": "What is the capital of germany?"},
        {"role": "assistant", "content": "The capital of germany is Berlin"},
        {"role": "user", "content": "What is its population count?"},
    ],
)
answer = chat_response.message.content  # access response text
user = chat_response.message.role       # access response author

# create chat for specified LLM with specified tag and get response as stream
chat_response_stream: Iterator[ChatResponse] = ollama.chat(
    model="gemma4:e4b",
    messages=[
        {"role": "user", "content": "What is the capital of germany?"},
        {"role": "assistant", "content": "The capital of germany is Berlin"},
        {"role": "user", "content": "What is its population count?"},
    ],
    stream=True,
)
answer = chat_response_stream.message.content  # access response text
user = chat_response_stream.message.role       # access response author

# create chat for specified LLM with specified tag and get thinking process additionally
chat_response_stream: Iterator[ChatResponse] = ollama.chat(
    model="gemma4:e4b",
    messages=[
        {"role": "user", "content": "What is the capital of germany?"},
        {"role": "assistant", "content": "The capital of germany is Berlin"},
        {"role": "user", "content": "What is its population count?"},
    ],
    stream=True,
)
thinking = chat_response_stream.message.thinking  # access thinking process
answer = chat_response_stream.message.content     # access response text
user = chat_response_stream.message.role          # access response author


# handle response errors from Ollama
try:
    ollama.chat("gemma4:e4b")
except ResponseError as e:
    if e.status_code == 404:
        ollama.pull("gemma4:e4b")
```

## 6 Tools

Tools allow LLM models to call functions and use their result as additional information. For this
to work functions acting as tools must provide Google style docstrings which are used by LLM
models to infer their usage.

```python
import ollama
from ollama import ChatResponse


# define function as tool
def add(nums: list[float]) -> float:
    """
    Add multiple numbers.

    Args:
        nums: The numbers to add

    Returns:
        The sum of the added numbers
    """
    return sum(nums)


# define messages list
messages: list[dict[str, str]] = [
    {"role": "user", "content": "What is 1 + 2 + 3 + 4 + 5 and that thereafter summed with 10?"},
]

# loop as long as their are unhandled tool calls
while True:

    # pass function as tool to chat
    response: ChatResponse = ollama.chat(
        model="gemma4:e4b",
        messages=messages,
        tools=[add],
    )

    # generate new response that may be one or multiple tool calls
    messages.append(response.message)

    # handle all tool calls
    if response.message.tool_calls:
        for call in response.message.tool_calls:
            result: float = add(**call.function.arguments)
            messages.append(
                {"role": "tool", "tool_name": call.function.name, "content": str(result)},
            )
    else:
        break

    # generate LLM response based on tool outputs
    final_response: ChatResponse = ollama.chat(
        model="gemma4:e4b",
        messages=messages,
        tools=[add],
    )
```

## 7 Remote Connections

```python
from ollama import ChatResponse, Client


# create remote Ollama server connection
client: Client = Client(host="http://my-remote-ollama-server:11434")


# manage LLM models via remote Ollama server
client.pull(model="gemma4:e4b")

# create chat via remote Ollama server
response: ChatResponse = client.chat(
    model="gemma:gemma4:e4b",
    messages=[{"role": "user", "content": "What is the capital of germany?"}],
)
```

{% endraw %}
