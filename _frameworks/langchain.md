---
layout: base
title: LangChain
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# LangChain
{: .no_toc }

Short description of the framework.

| Language  | Implementation | License     | Current Version |
| :-------- | :------------- | :---------- | :-------------- |
| Python    | Python         | MIT License | 1.4.0           |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Resources

- Official website: [LangChain](https://www.langchain.com/)
- Official documentation:
  [LangChain Overview](https://docs.langchain.com/oss/python/langchain/overview)
- Official repository: [langchain-ai/langchain](https://github.com/langchain-ai/langchain)

## 2 Installation

```bash
# with pip
pip install langchain
pip install langchain-openai # integrated OpenAI client
pip install langchain-ollama # integrated Ollama client

# with uv
uv add langchain
uv add langchain-openai # integrated OpenAI client
uv add langchain-ollama # integrated Ollama client

# with poetry
poetry add langchain
poetry add langchain-openai # integrated OpenAI client
poetry add langchain-ollama # integrated Ollama client
```

## 3 Clients

```python
from langchain_openai import ChatOpenAI
from langchain_ollama import ChatOllama


# create OpenAI client
client_openai: ChatOpenAI = ChatOpenAI(
    model="gpt-4.1-nano",
    base_url="https://api.openai.com/v1",
    api_key="<your-api-key>",
)

# create Ollama client
client_ollama: ChatOllama = ChatOllama(
    model="llama3.2:8b",
    base_url="http://localhost:11434/v1",
    api_key="<your-api-key>",
)
```

## 4 Chats

```python
from langchain.messages import AIMessage
from langchain_openai import ChatOpenAI


client_openai: ChatOpenAI = ChatOpenAI(
    model="gpt-4.1-nano",
    base_url="https://api.openai.com/v1",
    api_key="<your-api-key>",
)


# generate client response
response: AIMessage = client.invoke(input="Tell a joke.")
answer: str = response.content # get response text content
```

{% endraw %}
