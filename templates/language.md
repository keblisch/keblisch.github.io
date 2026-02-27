---
layout: base
title: Language Template
---

<!-- markdownlint-disable MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# Language Template
{: .no_toc }

Short description of the language.

| Paradigms          | Typing          | Memory Management          | Execution          |
| :----------------- | :-------------- | :------------------------- | :----------------- |
| Language paradigms | Language typing | Language memory management | Langauge execution |

```txt
Hello, World!
```

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## Backgrounds

### Resources

- Some link to a resource
- Some link to another resource

### Advantages and Disadvantages

| Advantages                    | Disadvantages                    |
| :---------------------------- | :------------------------------- |
| Some language advantage       | Some language disadvantage       |
| Some other language advantage | Some other language disadvantage |

### History

Short overview of the history of the language.

## Toolchain

Short description about the implementation and availability of the language's toolchain.

### Compilers/Interpreters

Description and/or list of the language's compiler(s)/interpreter(s).

### Build Systems

Description and/or list of the language's build system(s).

### Package Managers

Description and/or list of the language's package manager(s).

### Debuggers

Description and/or list of the language's debugger(s).

### Formatters

Description and/or list of the language's formatter(s).

## Compilation/Interpretation

```mermaid
graph TD
  source_files[Source files] --> |passed to| compiler[Compiler];
  compiler --> |compiles into| executable_binary[Executable Binary];
```

1. **First compilation/interpretation step**: Description of the step
2. **Second compilation/interpretation step**: Description of the step

## Syntax

### Whitespace

How whitespace is treated in the language.

```text
Example for whitespace usage
```

**Best Practices**:
- First best practice
- Second best practice

### Statements

How statements are composed in the language.

```text
Example for statement usage
```

**Best Practices**:
- First best practice
- Second best practice

### Scope

How scope is treated in the language.

```text
Example for scope usage
```

**Best Practices**:
- First best practice
- Second best practice

### Identifiers

How identifiers are composed in the language.

```text
Example for identifier usage
```

**Best Practices**:
- First best practice
- Second best practice

### Keywords

The following identifiers are reserved as keywords with special meaning:
- `keyword1`
- `keyword2`

## Structure

### Files

Description of which files are used how for the language.

**Best Practices**:
- First best practice
- Second best practice

### Projects

Conventional project organization for the language:
- `src/`: Source files
- `build`: A conventional build file

**Best Practices**:
- First best practice
- Second best practice

### Entry Point

Description of the language's entry point in executable programs.

```text
Example for the language's entry point
```

**Best Practices**:
- First best practice
- Second best practice

### Packages/Modules/libraries

Description of the language's package/module/library system.

```text
Example for the language's package/module/library system
```

**Best Practices**:
- First best practice
- Second best practice

### Standard Library

Description of the language's standard library.

The following packages/modules/libraries exist in the standard library:
- `library1`: Usage of the library
- `library2`: Usage of the library

## Comments

How comments are treated in the language.

### Single-Line Comments

```text
Example for single-line comments in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Multi-Line Comments

```text
Example for multi-line comments in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Documentation Comments

```text
Example for documentation comments in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Variables

```text
Example for variable usage in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Constants

```text
Example for constant usage in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Data Types

### Primitive Data Types

| Keyword | Representation | Byte Size | Signedness | Literals               |
| :------ | :------------- | :-------- | :--------- | :--------------------- |
| `int`   | Integers       | 4         | Signed     | `0`, `45`, `-12`       |
| `float` | Real Numbers   | 4         | Signed     | `0.0`, `3.89`, `-12.9` |

**Best Practices**:
- First best practice
- Second best practice

### Compound Data Types

#### Strings

How strings are treated in the language.

```text
Example for string usage in the language
```

**Best Practices**:
- First best practice
- Second best practice

#### Arrays

How arrays are treated in the language.

```text
Example for array usage in the language
```

**Best Practices**:
- First best practice
- Second best practice

#### Structs

How structs are treated in the language.

```text
Example for struct usage in the language
```

**Best Practices**:
- First best practice
- Second best practice

#### Enums

How enums are treated in the language.

```text
Example for enum usage in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Type Aliases

How data type aliases are treated in the language.

```text
Example for data type aliases in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Type Conversion

How data type conversion is treated in the language.

```text
Example for data type conversions in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Type Casting

How data type casting is treated in the language.

```text
Example for data type casting in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Type Size

```text
Example for data type size receiving in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Operators

### Precedence

| Operation   | Operator | Precedence Level |
| :---------- | :------- | :----------------|
| Addition    | `+`      | 2                |
| Subtraction | `-`      | 1                |

Description how operator precedence can be changed.

### Arithmetic Operators

How arithmetic operators are treated in the language.

| Operation   | Operator | Syntax  |
| :---------- | :------- | :-------|
| Addition    | `+`      | `x + y` |
| Subtraction | `-`      | `x - y` |

**Best Practices**:
- First best practice
- Second best practice

### Comparison Operators

How comparison operators are treated in the language.

| Operation  | Operator | Syntax   |
| :--------- | :------- | :--------|
| Equality   | `==`     | `x == y` |
| Inequality | `!=`     | `x == y` |

**Best Practices**:
- First best practice
- Second best practice

### Logical Operators

How logical operators are treated in the language.

| Operation | Operator | Syntax     |
| :-------- | :------- | :----------|
| AND       | `&&`     | `x && y`   |
| OR        | `\|\|`   | `x \|\| y` |

**Best Practices**:
- First best practice
- Second best practice

### Bitwise Operators

How bitwise operators are treated in the language.

| Operation   | Operator | Syntax     |
| :---------- | :------- | :----------|
| Bitwise AND | `&`      | `x & y`    |
| Bitwise OR  | `\|`     | `x \| y`   |

**Best Practices**:
- First best practice
- Second best practice

### Assignment Operators

How assignment operators are treated in the language.

| Operation           | Operator | Syntax   |
| :------------------ | :------- | :--------|
| Assignment          | `=`      | `x = y`  |
| Addition Assignment | `+=`     | `x += y` |

**Best Practices**:
- First best practice
- Second best practice

### Ternary Operator

How the ternary operator is treated in the language.

```text
Example for the ternary operator in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Control Flow Structures

### Conditions

```text
Example for conditions in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Switches

```text
Example for switches in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Loops

```text
Example for loops in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Jumps

How jumps are treated in the language.

```text
Example for jumps in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Functions

How functions are treated in the language.

### Basic Functions

```text
Example for functions in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Default Parameters

```text
Example for default parameters in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Variadic Parameters

```text
Example for variadic parameters in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Generic Functions

How generic functions are treated in the language.

```text
Example for generic functions in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Function Expressions

How function expressions are treated in the language.

```text
Example for function expressions in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Object Orientation

How object orientation in implemented in the language.

### Classes and Objects

```text
Example for classes and objects in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Inheritance

How inheritance is treated in the language.

```text
Example for inheritance in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Access Modifiers

How access modifiers are treated in the language.

```text
Example for classes and objects in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Abstract Classes

How abstract classes are treated in the language.

```text
Example for abstract classes in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Interfaces

How interfaces are treated in the language.

```text
Example for interfaces in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Error Handling

How errors are treated in the language.

### Error/Exception Recovery/Catching

```test
Example for error/exception recovery/catching in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Error/Exception Raising/Throwing

```test
Example for error/exception raising/throwing in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Error/Exception Creation

```test
Example for error/exception creation in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Containers

How containers are treated in the language.

### Lists

How lists are treated in the language.

```test
Example for list usage in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Maps

How maps are treated in the language.

```test
Example for map usage in the language
```

**Best Practices**:
- First best practice
- Second best practice

### Iterators

How iterators are treated in the language.

```test
Example for iterator usage in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Streams

How streams are treated in the language.

### Terminal Streams

How terminal streams are treated in the language.

```test
Example for terminal streams usage in the language
```

**Best Practices**:
- First best practice
- Second best practice

### File Streams

How file streams are treated in the language.

```test
Example for file streams usage in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Math

```test
Example for math utilities in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Time and Date

```test
Example for time and date utilities in the language
```

**Best Practices**:
- First best practice
- Second best practice

## System

```test
Example for system utilities in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Concurrency

How concurrency is treated in the language

```test
Example for concurrency in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Parallelism

How parallelism is treated in the language

```test
Example for parallelism in the language
```

**Best Practices**:
- First best practice
- Second best practice

## Memory Management

Description of how memory management is implemented in the language.

Description of how memory can be manually managed in the language.

```text
Example for manual memory management in the language
```

**Best Practices**:
- First best practice
- Second best practice

{% endraw %}
