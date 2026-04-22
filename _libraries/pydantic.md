---
layout: base
title: Pydantic
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# Pydantic
{: .no_toc }

Pydantic is a library to validate data structures at runtime.

| Language  | Implementation | License | Current Version |
| :-------- | :------------- | :------ | :-------------- |
| Python    | Python/Rust    | MIT     | 2.13.3          |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Resources

- Official Pydantic website: [Pydantic Docs](https://pydantic.dev/docs/)
- Pydantic repository: [pydantic/pydantic](https://github.com/pydantic/pydantic)

## 2 Installation

```bash
# install with pip
pip install pydantic

# install with uv
uv add pydantic

# install with poetry
poetry add pydantic
```

## 3 Models

```python
from typing import Any

from pydantic import BaseModel, ValidationError


# define class with schema
class Person(BaseModel):
    name: str                    # required string field
    age: int                     # required int field
    height: float = 1.80         # float field with default value
    is_male: bool | None = None  # optional boolean field


# instantiate class with schema and validate it at runtime
john: Person = Person(name="John", age=21)
jane: Person = Person(name="Jane", age=18, height=1.75, is_male=False)


# convert schema class
john_dict: dict[str, Any] = john.model_dump()  # to dictionary
john_json: str = john.model_dump_json()        # to JSON
```

{% endraw %}
