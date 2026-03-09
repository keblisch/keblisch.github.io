---
layout: base
title: Mockito
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# Mockito
{: .no_toc }

Mockito is a testing framework for Java that generates stubs and mocks for dependencies.

| Language  | Implementation | License     | Current Version |
| :-------- | :------------- | :---------- | :-------------- |
| Java      | Java           | MIT License | 5.22.0          |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Resources

- Official website: [Mockito framework site](https://site.mockito.org/)
- Official documentation:
  [Mockito Javadoc](https://javadoc.io/doc/org.mockito/mockito-core/latest/org.mockito/org/mockito/Mockito.html)

## 2 Installation

### 2.1 Maven

This must be added to the `pom.xml` file:

```xml
<dependencies>
    <dependency>
        <groupId>org.mockito</groupId>
        <artifactId>mockito-code</artifactId>
        <version>5.22.0</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

### 2.2 Gradle

This must be added to the `build.gradle` or `build.gradle.kts` file:

```kotlin
dependencies {
    testImplementation("org.mockito:mockito-core:5.22.0")
}
```

## 3 Mocking

```java
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

// create mock objects of classes
List mockedList = mock();

// call methods on mock objects
mockedList.add("one");
mockedList.clear();

// verify that methods in mocks executed as expected
verify(mockedList).add("one");
verify(mockedList).clear();
```

## 4 Stubbing

```java
import static org.mockito.Mockito.mock;

// create mock objects of classes
List mockedList = mock();

// create stubs for mock objects
when(mockedList.get(0)).thenReturn("first");

// use created stubs
mockedList.get(0).equals("first");
mockedList.get(100) == null;  // non-created stubs evaluate to null
```

{% endraw %}
