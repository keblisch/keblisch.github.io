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

## 1 Installation

### 1.1 Maven

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

### 1.2 Gradle

This must be added to the `build.gradle` or `build.gradle.kts` file:

```kotlin
dependencies {
    testImplementation("org.mockito:mockito-core:5.22.0")
}
```

## 2 Mocking

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

## 3 Stubbing

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
