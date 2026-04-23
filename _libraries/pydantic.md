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

Models are classes with schemas that get validated at runtime.

```python
from pydantic import BaseModel


# define models with fields to validate for
class Person(BaseModel):
    first_name: str                                   # required field
    last_name: str | None = None                      # optional field
    age: int = 18                                     # primitive field with default value
    hobbies: list[str] = Field(default_factory=list)  # reference type field with default value


# instantiate model and validate it at runtime
john: Person = Person(first_name="John")
jane: Person = Person(first_name="Jane", last_name="Doe", age=20, hobbies=["reading", "hiking"])
```

### 3.1 Constraint Fields

```python
from typing import Annotated, Literal

from pydantic import BaseModel


# define fields with constraints
class Car(BaseModel):
    brand: Literal["VW", "Toyota", "Ferrari"]            # constrain literal value
    seats: Annotated[int, gt=0, le=8]                    # constrain number
    name: Annotated[str, min_length=4, max_length=64]    # constrain string
    license_plate: Annotated[str, pattern=r"[0-9A-Z]+"]  # constrain string with RegEx


# instantiate model with constraint fields and validate it at runtime
car: Car = Car(brand="VW", seats=8, name="My Car", license_plate="AB12CD34")
```

### 3.2 Initialized Fields

```python
from datetime import datetime, UTC
from functools import partial

from pydantic import BaseModel, Field


# define fields that are initialized at instantiation
class Log(BaseModel):
    created_at: datetime = Field(
        default_factory=datetime.now,                  # use function
    )
    edited_at: datetime = Field(
        default_factory=partial(datetime.now, tz=UTC,  # use partial
    ))
    deleted_at: datetime = Field(
        default_factory=lambda: datetime.now(tz=UTC),  # use lambda
    )

# instantiate model with instantiated fields and validate it at runtime
log: Log = Log()
```

### 3.3 Computed Fields

```python
from pydantic import BaseModel, computed_field


# define fields that are dynamically computed
class Message(BaseModel):
    text: str

    @computed_field
    @property
    def rough_hash() -> str:
        return text + str(text.length())

# instantiate model with dynamically computed fields and use access them
message: Message = Message(text="Hello!")
message.rough_hash == "Hello!6"
```

## 4 Field Types

```python
from pydantic import BaseModel, SecretStr


class Data(BaseModel):
    password: SecretStr  # string that will be redacted in outputs


data: Data = password(secret="psst!")


# access secret string
data.password.get_secret_value() == "psst!"
```

## 5 Validation

### 5.1 Failure Handling

```python
from pydantic import BaseModel, ValidationError


class Person(BaseModel):
    name: str
    age: int


# handle validation failure
try:
    john: Person = Person(name="John", age=21)
except ValidationError as e:
    print(e)
```

### 5.2 Custom Validators

Custom validators can be used to validate models with custom logic independently from Pydantic.

```python
from pydantic import (
    BaseModel,
    field_validator,
    model_validator,
    PositiveInt,
    ValidatorInfo,
    ValidationError,
)


class Person(BaseModel):
    name: str
    age: PositiveInt


    # execute custom validation on model field
    @field_validator("name")
    @classmethod
    def validate_name(cls, v: str) -> str:
        if not v.isalpha():
            raise ValidationError("Name must consist of letters")
        return v.capitalize()


    # execute custom validation model instance
    @field_validator("age", mode="before")
    @classmethod
    def validate_name(cls, v: int) -> int:
        if not v > 0:
            return -v
        return v


    # execute custom validation before Pydantic validation
    @model_validator()
    def validate_model(self) -> "Person":
        if self.name.length() > self.age:
            raise ValidationError("I don't like your name")
        return self
```

## 6 Configuration

```python
from pydantic import BaseModel, ConfigDict, Field


class Person(BaseModel):
    # configuration for model
    model_config = ConfigDict(
        populate_by_name=True,     # allow aliases for fields when initializing
        strict=True,               # disable type coercions in initializations
        extra="allow",             # allow creating new fields ("ignore", "allow", "forbid")
        validate_assignment=True,  # revalidate model on instance changes
        frozen=True,               # forbid changes on instance after creation
    )

    first_name: str = Field(alias="firstName")
    last_name: str = Field(alias="lastName")


# initialize model via its aliases
john: Person = Person(firstName="John", lastName="Doe")
john.first_name == "John"
john.last_name == "Doe"
```

## Serialization

```python
from typing import Any

from pydantic import BaseModel


class Person(BaseModel):
    name: str
    age: int


john: Person = Person(name="John", age=21)


# serialize model instance to dictionary
john_dict: dict[str, Any] = john.model_dump()

# serialize model instance to JSON
john_json: str = john.model_dump_json()     # one-line JSON
john_json = john.model_dump_json(indent=2)  # indented JSON

# only include specific fields in serialization
john_dict = john.model_dump(include={"name"})

# exclude specific fields in serialization
john_dict = john.model_dump(exclude={"age"})


# deserialize dictionary into model instance
other_john: Person = Person.model_validate(obj=john_dict)

# deserialize JSON into model instance
other_john = Person.model_validate_json(obj=john_json)
```

{% endraw %}
