---
layout: base
title: Beautiful Soup
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# Beautiful Soup
{: .no_toc }

A parsing library for HTML and XML.

| Language  | Implementation | License     | Current Version |
| :-------- | :------------- | :---------- | :-------------- |
| Python    | Python         | MIT License | 4.4.1           |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Resources

- Official repository: [beautifulsoup](https://git.launchpad.net/beautifulsoup/)
- Official documentation:
  [Beautiful Soup Documentation](https://beautiful-soup-4.readthedocs.io/en/latest/)

## 2 Installation

```bash
# with pip
pip install beautifulsoup4

# with uv
uv add beautifulsoup4

# with poetry
poetry add beautifulsoup4
```

## 3 Parsers

```python
from bs4 import BeautifulSoup


# content to parse
content: str = """
<!DOCTYPE html>
<html>
    <head>
        <title>Hello</title>
    </head>
    <body>
        <h1>Hello</h1>
        <p>How are you?</p>
    </body>
</html>
"""

# parse object for content
soup: BeautifulSoup = BeautifulSoup(
    markup=content,         # text to parse
    features="html.parser", # parser to use (optional, mainly for reproducability)
)
```

# 4 Retrieval

```python
from bs4 import BeautifulSoup, Tag
from bs4._typing import _SomeTags


content: str = """
<!DOCTYPE html>
<html>
    <head>
        <title>Hello</title>
    </head>
    <body>
        <h1 id="header">Hello</h1>
        <p>How are you?</p>
    </body>
</html>
"""

soup: BeautifulSoup = BeautifulSoup(markup=content, features="html.parser")


# retrieve specific tag
h1_tag: Tag | None = soup.h1

# retrieve content of specific tag attribute
id: str | None = soup.h1.get(key="id")

# retrieve tag content of childless tag
title: str | None = soup.title.string # None if child tags exist

# retrieve tag content recursively with content of all child tags
body: str | None = soup.body.get_text(
    separatot=" ", # separator of concatenated tag contents
    strip=True,    # whether tag contents should be trimmed before concatenation
)

# retrieve all tags with specified name
tags: _SomeTags = soup.find_all(name="p") # list like tag iterable
```

{% endraw %}
