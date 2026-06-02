---
layout: base
title: C
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# C
{: .no_toc }

Short description of the language.

| Paradigms                | Typing           | Memory Management | Execution |
| :----------------------- | :--------------- | :---------------- | :-------- |
| Procedural<br>Imperative | Strong<br>Static | Manual            | Compiled  |

```c
#include <stdio.h>

void main()
{
    printf("Hello, World!\n");
}
```

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Backgrounds

### 1.1 Resources

- Comprehensive overview: [C language](https://www.c-language.org/)
- Comprehensive reference: [C reference](https://cppreference.com/c)

### 1.2 Advantages and Disadvantages

| Advantages                             | Disadvantages                                 |
| :------------------------------------- | :-------------------------------------------- |
| Very fast and memory-efficient         | Error-prone even for advanced programmers     |
| Fine-grained control over the computer | Errors can be very critical                   |
| Small set of features and keywords     | Very few quality-of-life features             |
| Very permissive                        | Programs can be hard to understand and modify |

### 1.3 History

- C was developed in 1973 by Dennis Ritchie and Ken Thompson at Bell Labs
  - It was intended to port the UNIX operating system to any platform
  - It was dervived from their previous prototype B, which itself was derived from BCPL
- The book "The C Programming Language" was published in 1979 by Brian Kernighan and
  Dennis Ritchie
  - It became the first de-facto standard for C
  - It became known as K&R and therefore its described language as K&R-C
- C became more prominent in the 1980s as a programming language beyond the world of UNIX
- The first official standard for C (C89) was formalized in 1989 by the American National
  Standards Institute (ANSI)
  - This standard also became known as ANSI-C
  - For this Brian Kernighan and Dennis Ritchie published a second edition of
    "The C Programming Language" as substitute
- The following standards were published by ANSI since C89:
  - **C99** (1999)
  - **C11** (2011)
  - **C17** (2017)
  - **C23** (2023)

## 2 Toolchain

- C is only a language specification and therefore doesn't come with an official toolchain
- To use C, various tools must be installed that together form a development environment

### 2.1 Compilers

- Compilers implement C and are therefore required
- Major C compilers include:
  - **GCC/G++**: GNU Compiler Collection, widely used on Linux and cross-platform
  - **Clang**: LLVM-based compiler, known for fast compilation and helpful error messages
  - **MSVC**: Microsoft Visual C++, native compiler for Windows

### 2.2 Standard Library Implementations

- Different compilers come with different standard library implementations:
  - **libstdc**: GNU's implementation, shipped with GCC
  - **libc**: LLVM's implementation, shipped with Clang
  - **MSVC STL**: Microsoft's implementation, shipped with MSVC

### 2.3 Build Systems

- Common C build systems include:
  - **Make**: Traditional build tool using Makefiles
  - **CMake**: Cross-platform meta-build system that generates native build files
  - **Ninja**: Fast build system often used with CMake
  - **Meson**: Modern build system focusing on speed and usability

### 2.4 Debuggers

- Common C debuggers include:
  - **GDB**: GNU Debugger, standard debugger for Linux
  - **LLDB**: LLVM debugger, works well with the Clang compiler
  - **Visual Studio Debugger**: Integrated debugger for Windows

### 2.5 Package Managers

- Common C package managers include:
  - **vcpkg**: Cross-platform package manager by Microsoft
  - **Conan**: Decentralized package manager with binary package support
  - **CPM**: CMake-based package manager

## 3 Compilation Process

```mermaid
graph TD
    source_files[Source files] --> |passed to| preprocessor[Preprocessor];
    header_files[Header files] --> |passed to| preprocessor;
    preprocessor --> |If preprocessor error| stop[Stop];
    preprocessor --> |produces| translation_units[Translation Units];
    translation_units -->  |passed to| compiler[Compiler];
    compiler --> |If compiler error| stop;
    compiler --> |compiles| object_files[Object files];
    object_files --> |passed to| linker[Linker];
    library_files[Library files] --> |passed to| linker;
    linker --> |links into| executable_binary[Executable Binary];
    linker --> |If linker error| stop;
```

1. **Preprocessor**: Produces translation units from source and header files
  - All preprocessor directives are executed
  - Translation units are self-contained C++ source files that result from preprocessing each
    source file with its included headers
  - Each source file becomes one translation unit after preprocessing
  - This step is canceled if a preprocessor directive is incorrect
2. **Compiler**: Produces binary object files from translation units
  - Translation units are translated into machine code
  - Each translation unit can be compiled independently (separate compilation)
  - Object files contain machine code along with metadata such as symbol tables, relocation
    information, and debugging data
  - Object files typically get the file extension `.o` (Unix/Linux) or `.obj` (Windows)
  - This step is canceled if a translation unit contains a syntax error or semantic error
3. **Linker**: Produces a single executable binary file from object and library files
  - All object files and library files are linked together
  - Resolves external symbol references (functions and variables declared in one file and defined
    in another)
  - The executable gets no extension on Unix/Linux or `.exe` on Windows
  - This step is canceled if references can't be resolved (e.g., undefined references or multiple
    definitions)

## 4 Syntax

### 4.1 Whitespace

- Whitespace characters include spaces, tabs, newlines, and carriage returns
- Whitespaces serve as separators between tokensare
  (identifiers, literals, keywords, and operators)
  - Outside this they're ignored by the compiler
  - Multiple consecutive whitespaces are treated as a single separator
- Comments are treated as whitespace by the compiler

### 4.2 Statements

- Statements are instructions that perform actions
- The following kinds of statements do exist:
  - **Line statements**: Any combination of valid expressions terminated by a semicolon `;`
  - **Block statements**: Any number of line statements enclosed in curly braces `{}`
- Block statements create their own scope
  - Variables declared inside a block are only accessible within that block
  - Blocks are treated as single statements in control structures

### 4.3 Scope

- A scope is a region of code where an identifier is valid and accessible
- Block statements create their own scopes
  - Scopes can be nested within other scopes
  - The program itself forms the global scope, which contains all other scopes
- A name is visible at a given point in the code if:
  - It was declared earlier in the current scope
  - It was declared in an outer scope
- Inner scopes can hide names from outer scopes by redeclaring them

### 4.4 Identifiers

- Identifiers are names to uniquely reference variables, functions and types
- The following rules apply for creating identifiers:
  - May contain letters, digits (`0-9`), and underscores
  - Must start with a letter (`a-z`, `A-Z`) or underscore (`_`)
  - Cannot be C keywords (e.g. `int`, `class`, `if`, `for`)
  - Are case-sensitive
- The following naming patterns are often reserved for compiler and
  standard library implementations:
  - Identifiers starting with an underscore followed by uppercase letter (e.g. `_Name`)
  - Identifiers containing double underscores anywhere (e.g. `__name`, `my__var`)
  - Identifiers starting with underscores in the global namespace (e.g. `_global`)

### 4.5 Keywords

- Keywords are reserved identifiers with special meaning
- The following keywords do exist:
  - `auto`
  - `break`
  - `case`
  - `char`
  - `const`
  - `continue`
  - `default`
  - `do`
  - `double`
  - `else`
  - `enum`
  - `extern`
  - `float`
  - `for`
  - `goto`
  - `if`
  - `int`
  - `long`
  - `register`
  - `return`
  - `short`
  - `signed`
  - `sizeof`
  - `static`
  - `struct`
  - `switch`
  - `typedef`
  - `union`
  - `unsigned`
  - `void`
  - `volative`
  - `while`

- The following keywords were introduced in **C99**:
  - `inline`
  - `restrict`
  - `_Bool`
  - `_Complex`
  - `_Imaginary`

- The following keywords were introduced in **C23**:
  - `bool`
  - `false`
  - `true`

## 5 Structure

### 5.1 Entry Point

- Every program must contain a `main` function as the entry point for execution

```cpp
// main with command-line arguments
int main(int argc, char* argv[])
{
    // code goes here

    return 0;
}

// main without command-line arguments
int main()
{
    // code goes here

    return 0;
}
```

- The parameter `argc` provides the count of command-line arguments
- The parameter `argv` provides the actual command-line arguments as an array of C-strings
  - `argv[0]` is always the program name
  - `argv[1]` through `argv[argc-1]` are the user-provided arguments
- The return value is the program's exit status code
  - `0` conventionally indicates success
  - Non-zero values indicate various error conditions

- Since **C99** main functions don't need to return values explicitly
  - In that case `0` is returned per default

```c
// main with implicit return statement
int main()
{
    // code goes here
}

// main with implicit return value
void main()
{
    // code goes here
}
```

### 5.2 Header and Source Files

- C code can be organized into header files and source files
  - Header files contain declarations and constants
  - Source files contain definitions
  - This separation allows for the separation of interface and implementation
- File extensions don't affect compilation, but the following conventions exist:
  - **Source files**: `.c`
  - **Header files**: `.h`

### 5.3 Project Structure

- The following project directory convention exists:
  - `src/`: Source files (`.c`)
  - `include/`: Public header files (`.h`)
  - `lib/`: External library files (`.a`, `.so`, `.lib`, `.dll`, etc.)
  - `build/`: Intermediate build artifacts
  - `bin/`: Executable binaries
  - `test/`: Test files

## 6 Comments

- Comments are text annotations in source code that aren't processed
- Comments are treated as whitespace by the compiler

```c
/* This is a comment */

/* This is
another
comment
*/
```

- Single-line comments were introduced in **C99**

```c
// This is a comment
// This is another comment
```

## 7 Preprocessor Directives

- Preprocessor directives are executed by the preprocessor before compilation
  - Thereby they're replaced with their result

### 7.1 Includes

- Include directives import the content of files into the current file

```c
// include library (searches include paths)
#include <stdio.h>
#include <string.h>

// include file (searches working directory)
#include "myheader.h"
#include "utilities/helper.h"
```

<u>Best practices</u>:
  - Include directives should be used to import header files
  - Include directives should be placed at the beginning of files

### 7.2 Include Guards

- Include guards are used to prevent the import of the same file multiple times

```cpp
// prevent multiple inclusions
#ifndef MYHEADER_H
#define MYHEADER_H

// header content here...

#endif
```

The following syntax is supported by most modern compilers as a compiler-extension:

```c
// prevent multiple inclusions
#pragma once

// header content here...
```

### 7.3 Macros

```c
// define macros
#define PI 3.14159
#define MAX_SIZE 100

// define function macros
#define SQUARE(x) (x * x)
#define MAX(a, b) ((a) > (b) ? (a) : (b)) // parentheses prevent precedence issues

// using macros
int area = SQUARE(5);      // expands to ((5) * (5))
int maximum = MAX(10, 20); // expands to ((10) > (20) ? (10) : (20))

// undefine macros
#undef PI
#undef SQUARE
```

<u>Best practices</u>:
  - Prefer `const` variables over macros when possible
  - Use constant case for macro identifiers
  - Always use parentheses in macro expressions to avoid precedence issues

## 8 Variables

- Variables are named storage locations that hold values of specific data types

```c
// declaring variables
int x;               // single variable
int y, z;            // multiple variables of identical types
double a = 3.4;      // with initial value
double b, c = 1.34;  // multiple with and without initial values

// defining variables
x = 4;    // undefined variables
b = 7.8;  // defined variables

// chaining variable definitions
int i = j = k = 10; // all variables have the same value
```

- In **C89** variables can only be declared at the start of programs
- Since **C99** variables can be declared at any point in the program

## 9 Constants

...

## 9 Data Types

### 9.1 Integrals

| Keyword                                  | Representation   | Byte Size  | Literals       |
| :--------------------------------------- | :--------------- | :--------- | :------------- |
| `int`                                    | Integer          | 2 or 4     | `3`, `242`     |
| `unsigned int`                           | Positive integer | 2 or 4     | `3U`, `242u`   |
| `short int`<br>`short`                   | Integer          | 2          | -              |
| `unsigned short int`<br>`unsigned short` | Positive integer | 2          | -              |
| `long int`<br>`long`                     | Integer          | 4 or 8     | `3L`, `242l`   |
| `unsigned long int`<br>`unsigned long`   | Positive integer | 4 or 8     | `3UL`, `242ul` |
| `char`                                   | ANSI-Character   | 1          | `'a'`, `'5'`   |

- Boolean values are expressed as integer values
  - True is `1` and equivalent to any non-zero number
  - False is `0`

The base of integer literals can be specified with the following prefixes:

| Prefix | Base | Literals                |
| :----- | :--- | :---------------------- |
| -      | 10   | `4`, `-18L`, `13U`      |
| `0`    | 8    | `04`, `-022L`, `015U`   |
| `0x`   | 16   | `0x4`, `-0x12L`, `0xdU` |

The following integrals were introduced in **C99**:

| Keyword                                       | Representation   | Byte Size  | Literals       |
| :-------------------------------------------- | :--------------- | :--------- | :------------- |
| `long long int`/`long long`                   | Integer          | 8          | `3LL`, `2ll`   |
| `unsigned long long int`/`unsigned long long` | Positive integer | 8          | `3ULL`, `2ull` |
| `_Bool`                                       | Boolean          | 1          | `1`, `0`       |

- Any non-zero value used as a `_Bool` value is converted to `1`
- The `stdbool.h` standard library header provides the following macros:
  - `bool` for `_Bool`
  - `true` for `1`
  - `false` for `0`

The following integrals were introduced in **C23**:

| Keyword | Representation        | Byte Size  | Literals        |
| :------ | :-------------------- | :--------- | :-------------- |
| `bool`  | Boolean               | 1          | `true`, `false` |

- The `bool` values `true` and `false` are equivalent to `1` and `0`

### 9.2 Floating-Point Numbers

| Keyword             | Representation        | Byte Size  |
| :------------------ | :-------------------- | :--------- |
| `float`             | Floating-point Number | At least 4 |
| `double`            | Floating-point Number | At least 8 |

### 9.3 Strings

#### 9.3.1 Escape Sequences

- Escape sequences are used to insert special characters into strings

```c
// use escape sequences in string
char* greeting = "Hello!\nHow are you?\n";
```

| Escape Sequence | Meaning               |
| :-------------- | :-------------------- |
| `\n`            | Insert line brean     |
| `\t`            | Insert horizontal tab |
| `\v`            | Insert vertical tab   |
| `\a`            | Ring system bell      |
| `\b`            | Remove last character |
| `\"`            | Insert double quote   |
| `\\`            | Insert backslash      |

#### 9.3.2 Format Strings

- Format strings are strings that contain placeholders in which values with certain data types
  can be inserted

```c
#include <stdio.h>

char buffer[100];

// use format string
sprintf(buffer, "%d + %f = %f", 3, 4.5f, 7.5f);  // can overflow buffer
snprintf(buffer, "%d + %f = %f", 3, 4.5f, 7.5f); // can't overflow buffer
buffer == "3 + 4.5 = 7.5";
```

| Format Specifier | Data Type                         |
| :--------------- | :-------------------------------- |
| `%d`<br>`%i`     | `int` with base 10                |
| `%u`             | `unsigned int` with base 10       |
| `%o`             | `unsigned int` with base 8        |
| `%x`<br>`%X`     | `unsigned int` with base 16       |
| `%hd`<br>`%hi`   | `short` with base 10              |
| `%hu`            | `unsigned short` with base 10     |
| `%ho`            | `unsigned short` with base 8      |
| `%hx`<br>`%hX`   | `unsigned short` with base 16     |
| `%ld`<br>`%li`   | `long` with base 10               |
| `%lu`            | `unsigned long` with base 10      |
| `%lo`            | `unsigned long` with base 8       |
| `%lx`<br>`%lX`   | `unsigned long` with base 16      |
| `%lld`<br>`%lli` | `long long` with base 10          |
| `%llu`           | `unsigned long long` with base 10 |
| `%llo`           | `unsigned long long` with base 8  |
| `%llx`<br>`%llX` | `unsigned long long` with base 16 |
| `%f`             | `float`, `double`                 |
| `%Lf`            | `long double`                     |
| `%c`             | `char`                            |
| `%s`             | `char*`                           |

- Format specifiers can contain conversion specifiers to specify how the inserted values
  should be represented

```c
#include <stdio.h>

char buffer[100];

// specify floating-point numbers
snprintf(buffer, "%.2f", 83.2801);   // number of decimal places
buffer == "83.28";
snprintf(buffer, "%10.f", 83.2801);  // minimum number of characters (left justified)
buffer == "   83.2801";
snprintf(buffer, "%-10.f", 83.2801); // minimum number of characters (right justified)
buffer == "83.2801   ";
snprintf(buffer, "%8.2f", 83.2801);  // number of decimal places and minimum number of characters
buffer == "   83.28";

// specify integers
snprintf(buffer, "%.3d", 14);  // minimum number of digits
buffer == "014";
snprintf(buffer, "%5d", 14);   // minimum number of characters (left justified)
buffer == "   14";
snprintf(buffer, "%-5d", 14);  // minimum number of characters (left justified)
buffer == "14   ";
snprintf(buffer, "%5.3d", 14); // minimum number of digits and minimum number of characters
buffer == "  014";
```

### 9.4 Structs

...

### 9.5 Enums

...

### 9.6 Type Aliases

...

### 9.7 Type Conversion

...

### 9.8 Type Casting

...

### 9.9 Type Size

- Integer overflows are handled in the following ways:
  - Overflows of signed integers cause undefined behavior
  - Overflows of unsigned integers perform a modulo operation with their bit-size on them

## 10 Operators

### 10.1 Precedence

| Precedence | Operations                                                      |
| :--------- | :-------------------------------------------------------------- |
| 1          | Post-Increment and -Decrement                                   |
| 2          | Pre-Increment and -Decrement, Unary Plus, Negation, Logical NOT |
| 3          | Multiplication, Division, Modulo                                |
| 4          | Addition, Subtraction                                           |
| 5          | Bitwise Shifts                                                  |
| 6          | Greater, Greater-Equals, Less, Less-Equals                      |
| 7          | Equality, Inequality                                            |
| 8          | Bitwise AND                                                     |
| 9          | Bitwise XOR                                                     |
| 10         | Bitwise OR                                                      |
| 11         | Logical AND                                                     |
| 12         | Logical OR                                                      |
| 13         | Ternary Operator                                                |
| 14         | Assignment, Compound Assignments                                |
| 15         | Comma Operator                                                  |

```c
// change precedence of operators
(3 + 4) * (5 - 3) == 14;
```

### 10.2 Arithmetic Operators

- Arithmetic operators perform mathematical operations on numeric values
- Arithmetic operators may cause undefined behavior withinvalid operations

| Operation        | Symbol   | Arity  | Associativity |
| :--------------- | :------- | :----- | :------------ |
| Addition         | `+`      | Binary | Left          |
| Unary Plus       | `+`      | Unary  | Right         |
| Subtraction      | `-`      | Binary | Left          |
| Negation         | `-`      | Unary  | Right         |
| Multiplication   | `*`      | Binary | Left          |
| Division         | `/`      | Binary | Left          |
| Integer Division | `/`      | Binary | Left          |
| Modulo           | `%`      | Binary | Left          |
| Pre-Increment    | `++`     | Unary  | Right         |
| Post-Increment   | `++`     | Unary  | Left          |
| Pre-Decrement    | `--`     | Unary  | Right         |
| Post-Decrement   | `--`     | Unary  | Left          |

- The use of `0` as divident in divisions causes undefined behavior
- In **C89** the result of divisions and modulos with a negative operators is implementation
  defined
- Since **C99** the result of divisions and modulos with a negative operators is rounded
  towards 0

```c
// addition
3 + 4 == 7; // binary
+(5) == 5;  // unary

// subtraction
4 - 3 == 1; // binary
-(4) == -4; // unary

// multiplication
3 * 2 == 6;

// division
3.0 / 2 == 1.5; // floating-point
3 / 2 == 1;     // integer

// modulo
11 % 4 == 3;

// increment
int x = 3; ++x == 4; // post
int x = 3; x++ == 3; // pre

// decrement
int x = 3; --x == 2; // post
int x = 3; x-- == 3; // pre
```

### 10.3 Comparison Operators

- Comparison operators compare values and return boolean results

| Operation      | Symbol   | Arity  | Associativity |
| :------------- | :------- | :----- | :------------ |
| Equality       | `==`     | Binary | Left          |
| Inequality     | `!=`     | Binary | Left          |
| Greater        | `>`      | Binary | Left          |
| Greater-Equals | `>=`     | Binary | Left          |
| Less           | `<`      | Binary | Left          |
| Less-Equals    | `<=`     | Binary | Left          |

```c
// equality
4 == 4 == true;
3 != 4 == true;

// greater than
4 > 3 == true;
4 >= 3 == true;

// less than
3 < 4 == true;
3 <= 4 == true;
```

### 10.4 Logical Operators

- Logical operators perform boolean logic operations on truth values
- Logical AND and OR use short-circuit evaluation

| Operation | Symbol   | Arity  | Associativity |
| :-------- | :------- | :----- | :------------ |
| AND       | `&&`     | Binary | Left          |
| OR        | `││`     | Binary | Left          |
| NOT       | `!`      | Unary  | Right         |

```c
// AND
true && true == true;

// OR
true ││ false == true;

// NOT
!false == true;
```

### 10.5 Bitwise Operators

- Bitwise operators manipulate individual bits values
- They only work with integral types

| Operation   | Symbol   | Arity  | Associativity |
| :---------- | :------- | :----- | :------------ |
| Bitwise AND | `&`      | Binary | Left          |
| Bitwise OR  | `│`      | Binary | Left          |
| Bitwise NOT | `~`      | Unary  | Right         |
| Bitwise XOR | `^`      | Binary | Left          |
| Left Shift  | `<<`     | Binary | Left          |
| Right Shift | `>>`     | Binary | Left          |

```c
// bitwise logical operations
0b0110 & 0b0011 == 0b0010; // AND
0b0110 │ 0b0011 == 0b0111; // OR
~0b0110 == 0b1001;         // NOT
0b0110 ^ 0b0011 == 0b0101; // XOR

// bitwise shifts
0b0011 << 2 == 0b1100; // left
0b1100 >> 2 == 0b0011; // right
```

### 10.6 Assignment Operators

- Assignment operators are assigning values to variables
  - Therefore the left operand must always be a variable
- Assignment expressions themselves are evaluating to the assigned value

| Operation                   | Symbol   | Arity  | Associativity |
| :-------------------------- | :------- | :----- | :------------ |
| Assignment                  | `=`      | Binary | Right         |
| Addition Assignment         | `+=`     | Binary | Right         |
| Subtraction Assignment      | `-=`     | Binary | Right         |
| Multiplication Assignment   | `*=`     | Binary | Right         |
| Division Assignment         | `/=`     | Binary | Right         |
| Integer Division Assignment | `/=`     | Binary | Right         |
| Modulo Assignment           | `%=`     | Binary | Right         |
| Bitwise AND Assignment      | `&=`     | Binary | Right         |
| Bitwise OR Assignment       | `│=`     | Binary | Right         |
| Bitwise XOR Assignment      | `^=`     | Binary | Right         |
| Left Shift Assignment       | `<<=`    | Binary | Right         |
| Right Shift Assignment      | `>>=`    | Binary | Right         |

```c
// regular assignment
int x = 3; x == 3;

// chained assignment
int a = b = c = 12; // all variables have the same value

// arithmetic assignment
x = 3; x += 4; x == 7;       // addition
x = 4; x -= 3; x == 1;       // subtraction
x = 3; x *= 4; x == 12;      // multiplication
x = 3.0; x /= 2.0; x == 1.5; // division
x = 3; x /= 2; x == 1;       // integer deivision
x = 11; x %= 4; x == 3;      // modulo

// bitwise-operation assignment
x = 0b01; x &= 0b11; x == 0b01; // bitwise AND
x = 0b01; x │= 0b11; x == 0b11; // bitwise OR
x = 0b01; x ^= 0b11; x == 0b10; // bitwise XOR
x = 0b01; x <<= 1; x == 0b10;   // left shift
x = 0b10; x >>= 1; x == 0b01;   // right shift
```

- <u>Best practices</u>
  - Don't use assignment expressions as subexpressions

### 10.7 Ternary Operator

- The ternary operator provides a concise way to write simple if-else expressions

```c
int x = 4;
const char* answer = x > 10 ? "x is greater than 10" : "x is 10 or less";
```

### 10.8 Comma Operator

- The comma operator evaluates multiple expressions from left to right
- The result of a comma expression is the result of its right operand
- Commas in declarations, function calls and parameter lists are separators, not comma operators

```c
int x = 0;
int y = (x = 3, x);
x == 3 && y == 3;
```

## 11 Control Flow Structures

### 11.1 Conditions

```c
#include <stdio.h>

int x = 10;

// only execute statement when condition is true
if (x < 0)
{
    printf("x is negative.\n");
}
// only execute statement when no prior condition was true and condition is true
else if (x > 0)
{
    printf("x is positive.\n");
}
// only execute statement when all prior conditions were false
else
{
    printf("x is 0.\n");
}

// conditions with line statements
if (x < 0)
    printf("x is negative.\n");
else if (x > 0)
    printf("x is positive.\n");
else
    printf("x is 0.\n");
```

- <u>Best practices</u>:
  - Prefer conditions with compound statements over conditions with line statements

### 11.2 Switches

```c
#include <stdio.h>

unsigned int x = 3;

// switch for specific values
switch (x)
{
    // start execution here when case matches value
    case 0:
        printf("x is 0.\n");
        break; // exit switch (prevents fallthrough to consecutive cases)
    // start execution here when case matches value
    case 1:
        printf("x is 1.\n");
        break; // exit switch (prevents fallthrough to consecutive cases)
    // start execution here when case matches value
    case 2:
        printf("x is 2.\n");
        break; // exit switch (prevents fallthrough to consecutive cases)
    // optional default case
    default:
        printf("x is greater than 2.\n");
}

// switch for value ranges
switch (x)
{
    // start execution here when any case matches value
    case 0: case 1: case 3: case 5: case 7: case 9:
        printf("x is odd.\n");
        break; // exit switch (prevents fallthrough to consecutive cases)
    // start execution here when any case matches value
    case 2: case 4: case 6: case 8:
        printf("x is even.\n");
        break; // exit switch (prevents fallthrough to consecutive cases)
    // optional default case
    default:
        printf("x is 10 or greater.\n");
}

// switch that executes consecutive cases
switch (x)
{
    case 3:
        printf("Tick.\n");
    // continue execution when previous case executed
    case 2:
        printf("Tick.\n");
    // continue execution when previous case executed
    case 1:
        printf("Tick.\n");
    // continue execution when previous case executed
    default:
        printf("RING! RING! RING!\n");
}
```

- <u>Best practices</u>:
  - Prefer switches over long cascades of conditions that check for equality

### 11.3 Loops

```c
#include <stdio.h>

// execute statement as long as condition is true (check before execution)
int i = 0;
while (i < 10)
{
    printf("%d", i);
    ++i;
}

// execute statement as long as condition is true (execution before check)
i = 0;
do
{
    printf("%d", i);
    ++i;
}
while (i < 10)

// execute statement specified amount of times
for (i = 0; i < 10; ++i) // initialization step, condition, updating step
{
    printf("%d", i);
}

// for-loop with omitted steps
for (; i < 10; ++i) // no initialization takes place
{
    printf("%d", i + j);
}
for (i = 0; ; ++i)  // condition is always true
{
    printf("%d", i + j);
}
for (i = 0; i < 10;) // no updare takes place
{
    printf("%d", i + j);
}

// exit loop early
while (true)
{
    if (i >= 10)
    {
        break; // loop ends immediately
    }
    printf("%d", i);
    i++
}

// skip loop iterations
while (true)
{
    if (i % 2 == 0)
    {
        continue; // start next iteration immediately
    }
    printf("%d", i);
    i++
}

// loops with line statements
while (i < 10) printf("%d", i);
do printf("%d", i); while (i < 10)
for (i = 0; i < 10; ++i) printf("%d", i);
```

- Since **C99** variables can be declared in the initialization step of for-loops
  - These variables are only in the scope of the loop

```c
#include <stdio.h>

for (int i = 0; i < 10; ++i)
{
    printf("%d", i);
}
```

- <u>Best practices</u>:
  - Prefer loops with compound statements over loops with line statements
  - Declare index variables in the initialization step of for-loops

### 11.4 Jumps

- The `goto` statement can be used to jump to any point in a function

```c
// jump to specified label
goto skip;

int x = 1;

// label to jump to
skip:
int x = -1;

x == -1;
```

- Since **C99** the `goto` stetement can't be used to skip declarations of arrays with
  non-constant length

- <u>Best practices</u>:
  - Avoid `goto` because they can disturb the control flow in unpredictable ways

## 12 Functions

- Functions are reusable blocks of code that perform specific tasks and can take parameters
  and return values

```c
#include <stdio.h>

// define function
int sum(int x, int y)
{
    return x + y;
}

// call function
sum(4, 7) == 11;

// define function with no return value or parameters
void greet()
{
    printf("Hi!");
}

// call function with no return value or parameters
greet();
```

- Functions can be declared before they're defined later
  - This allows for separation of interface and implementation
  - This allows to use functions before their definition

```c
// declare function
int sum(int x, int y);

// use declared function
int x = sum(3, 7);

// define declared function
int sum(int x, int y)
{
    return x + y;
}
```

## 13 Error Handling

...

## 14 Memory Management

...

## 15 IO

```c
#include <stdio.h>

// print to terminal
printf("Hello, World!");         // regular string
printf("%d + %d = %d", 3, 4, 7); // format string

// read from terminal
int id; float nc;          // storage variables
scanf("%d", &id);          // read input into format string and store values in storage variables
scanf("%d:%f.", &id, &nc); // pattern match input against format string (whitespaces are ignored)

// check whether reading was successful
int success = scanf("%d%f", &id, &score);
if (!success)
{
    printf("Couldn't read input!");
}
```

## 16 Math

...

## 17 Time and Date

...

## 18 System

...

## 19 Threads

...

{% endraw %}
