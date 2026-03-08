---
layout: base
title: JUnit
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# JUnit
{: .no_toc }

JUnit is a testing framework for Java.

| Language  | Implementation | License         | Current Version |
| :-------- | :------------- | :-------------- | :-------------- |
| Java      | Java           | EPL-2.0 License | 6.0.3           |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Installation

### 1.1 Maven

This must be added to the `pom.xml` file:

```xml
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.junit</groupId>
            <artifactId>junit-bom</artifactId>
            <version>6.0.3</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>

<dependencies>
    <dependency>
        <groupId>org.junit.jupiter</groupId>
        <artifactId>junit-jupiter</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>
```

### 1.2 Gradle

This must be added to the `build.gradle` or `build.gradle.kts` file:

```kotlin
dependencies {
    testImplementation(platform("org.junit:junit-bom:6.0.3"))
    testImplementation("org.junit.jupiter:junit-jupiter")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

test {
    useJUnitPlatform()
    testLogging {
        events "passed", "skipped", "failed"
    }
}
```

## 2 Test Methods

Tests are implemented as methods of dedicated test classes.

```java
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.ParameterizedTest;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.ValueSource;

// define test classes that must start or end with `Test`
@DisplayName("Some test")  // optionally define custom test class name
class SomeTest {

    // define methods as regular tests
    @Test
    @DisplayName("Some test case")  // optionally define custom test method name
    void testSomething() {
        // test code goes here
    }

    // define methods as parameterized tests
    @ParameterizedTest
    @ValueSource(strings = { "foo", "bar" })  // define array of string test parameters
    @DisplayName("Some test case")            // optionally define custom test method name
    void testSomeStrings(String some) {
        // test code goes here
    }

    // define methods as parameterized tests
    @ParameterizedTest
    @ValueSource(ints = { 1, 2, 3 })  // define array of integer test parameters
    @DisplayName("Some test case")    // optionally define custom test method name
    void testSomeIntegers(int some) {
        // test code goes here
    }

    // define methods as parameterized tests
    @ParameterizedTest
    @EnumSource(names = { "FOO", "BAR" })  // define array of enum value test parameters
    @DisplayName("Some test case")         // optionally define custom test method name
    void testSomeEnumValues(MyEnum some) {
        // test code goes here
    }

    @Test
    // disable tests and log their disablement
    @Disabled("For some reason")
    void skippedTest() {
        // not executed
    }

}
```

## 3 Lifecycle Methods

```java
import static org.junit.jupiter.api.Assertions.fail;
import static org.junit.jupiter.api.Assumptions.assumeTrue;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

class SomeTest {

    // call method before all test executions
    @BeforeAll
    static void initAll() {
        System.out.println("Starting tests...")
    }

    // call method before each test execution
    @BeforeEach
    void init() {
        System.out.println("test started...")
    }

    // call method after each test execution
    @AfterEach
    void tearDown() {
        System.out.println("test finished...")
    }

    // call method after all test executions
    @AfterAll
    static void tearDownAll() {
        System.out.println("Finishing tests...")
    }

}
```

## 4 Assertions

The result of assertions decide whether test methods will pass or fail.

```java
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import org.junit.jupiter.api.Test;

class SomeTest {

    @Test
    void testSomething() {
        // immediatly fail tests
        fail("This test failed... :(");

        // test for something equaling something other
        assertEquals(
            "expected value", "actual value",
            "This test failed... :(" // optional custom fail message
        );

        // test for something being true
        assertTrue(
            "Hello, World!".contains("Hi"),
            "This test failed... :(" // optional custom fail message
        );

        // test for something not being null
        assertNotNull(
            new String("Is this null?"),
            "This test failed... :(" // custom message for failed test
        );

        // test for something throwing some exception
        assertThrows(
            ArithmeticException.class, () -> 12 / 0
            "This test failed... :(" // custom message for failed test
        );
    }

}
```

{% endraw %}
