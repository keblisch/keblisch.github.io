---
layout: base
title: OpenAI
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# OpenAI
{: .no_toc }

The official OpenAI API client for Python that is the de-facto standard for LLM API calls.

| Language | Implementation | License            | Current Version |
| :------- | :------------- | :----------------- | :-------------- |
| Python   | Python         | Apache-2.0 license | 2.38.0          |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Resources

- Official repository: [openai/openai-python](https://github.com/openai/openai-python)

## 2 Installation

```bash
# with pip
pip install openai

# with uv
uv add openai

# with poetry
poetry add openai
```

## 3 Clients

```python
from openai import OpenAI


# create OpenAI client
client: OpenAI = OpenAI(
    base_url="https://api.openai.com/v1",
    api_key="<your-api-secret-key>",
)
```

## 4 Contexts

```python
from openai.types.chat import ChatCompletionMessageParam


# create context to generate response for
context: list[ChatCompletionMessageParam] = [
    {"role": "system", "content": "Your job is to be a helpful assistant."}, # system prompt
    {"role": "user", "content": "What is the capital of France?"},           # user prompt
    {"role": "assistant", "content": "The capital of France is Paris."},     # assistant response
    {"role": "user", "content": "And from Germany?"},                        # user prompt
]
```

## 5 Response Generation

```python
from openai import OpenAI
from openai.types.chat import ChatCompletion


client: OpenAI = OpenAI(base_url="https://api.openai.com/v1", api_key="<your-api-secret-key>")


# generate response with client and context
response: ChatCompletion = client.chat.completions.create(
    model="gpt-4.1",
    messages=[
        {"role": "system", "content": "Your job is to be a helpful assistant."},
        {"role": "user", "content": "What is the capital of France?"},
    ],
)

# get text of response
answer: str | None = response.choices[0].message.content
```

### 5.1 Streamed Responses

```python
from openai import OpenAI
from openai.types.chat import ChatCompletionChunk


client: OpenAI = OpenAI(base_url="https://api.openai.com/v1", api_key="<your-api-secret-key>")


# stream client response
stream: ChatCompletionChunk = client.chat.completions.create(
    model="gpt-4.1",
    messages=[
        {"role": "system", "content": "Your job is to be a helpful assistant."},
        {"role": "user", "content": "What is the capital of France?"},
    ],
    stream=True, # enable streaming
)

# process streamed response
response: str = ""
for chunk in stream:
    response += chunk.choices[0].delta.content or ""
```

### 5.2 Structured Output

```python
from openai import OpenAI
from openai.types.chat import ChatCompletion


client: OpenAI = OpenAI(base_url="https://api.openai.com/v1", api_key="<your-api-secret-key>")


# restrict output format of client
response: ChatCompletion = client.chat.completions.create(
    model="gpt-4.1",
    messages=[
        {"role": "system", "content": "Your job is to be a helpful assistant."},
        {"role": "user", "content": "What is the capital of France?"},
    ],
    response_format={"type": "json_object"}, # enforce JSON
)
```

### 5.3 Reasonong

```python
from openai import OpenAI
from openai.types.chat import ChatCompletion


client: OpenAI = OpenAI(base_url="https://api.openai.com/v1", api_key="<your-api-secret-key>")


# define reasonong for reasonong models
response: ChatCompletion = client.chat.completions.create(
    model="gpt-4.1",
    messages=[
        {"role": "system", "content": "Your job is to be a helpful assistant."},
        {"role": "user", "content": "What is the capital of France?"},
    ],
    reasonong_effort="medium", # none, minimal, low, medium, high, xhigh
)
```

{% endraw %}
