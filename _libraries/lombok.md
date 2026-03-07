---
layout: base
title: Lombok
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# Lombok
{: .no_toc }

Lombok is a library that automatically generates Java code to reduce boilerplate code.

| Language  | Implementation | License           | Current Version |
| :-------- | :------------- | :---------------- | :-------------- |
| Java      | Java           | MIT License       | 1.18.42         |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Installation

### 1.1 Maven

This must be added to the dependencies in the `pom.xml` file:

```xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.42</version>
    <scope>provided</scope>
</dependency>
```

This must be added to the plugins in the `pom.xml` file for Java SE 23 or higher:

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <configuration>
        <annotationProcessorPaths>
            <path>
                <groupId>org.projectlombok</groupId>
                <artifactId>lombok</artifactId>
                <version>1.18.42</version>
            </path>
        </annotationProcessorPaths>
    </configuration>
</plugin>
```

### 1.2 Gradle

This must be added to the dependencies in the `build.gradle` or `build.gradle.kts` file:

```kotlin
compileOnly("org.projectlombok:lombok:1.18.42")
annotationProcessor("org.projectlombok:lombok:1.18.42")
testCompileOnly("org.projectlombok:lombok:1.18.42")
testAnnotationProcessor("org.projectlombok:lombok:1.18.42")
```

## 2 Non-Null Checks

```java
import lombok.NonNull;

public class Foo {

    // make non-null checks on fields at runtime
    @NonNull
    public String foo;

    // make non-null checks on parameters at runtime
    public Foo(@NonNull String foo) {
        this.foo = foo;
    }

}

try {
    Foo foo = new Foo("Foo");
    System.out.println(foo.foo);
}
catch (NullPointerException e) {
    e.printStackTrace();
}
```

## 3 Getters and Setters

```java
import lombok.Getter;
import lombok.Setter;

// generate getters and setters for specific fields
public class Foo {

    @Getter  // generate getter
    @Setter  // generate setter
    public String foo = "Foo";

}
Foo foo = new Foo();
foo.getFoo().equals("Foo");
foo.setFoo("FOO");

// generate getters and setters for all fields of classes
@Getter  // generate getters
@Setter  // generate setters
public class Bar {

    public String bar = "Bar";

}
Bar bar = new Bar();
bar.getBar().equals("Bar");
bar.setBar("BAR");
```

## 4 Object Class Methods

```java
import lombok.EqualsAndHashCode;
import lombok.ToString;

// generate object class methods for classes
@ToString           // generate `toString` method
@EqualsAndHashCode  // generate `equals` and `hashCode` methods
public class FooBar {

    public String foo;
    public String bar;

    public FooBar(String foo, String bar) {
        this.foo = foo;
        this.bar = bar;
    }

}

FooBar foobar = new FooBar("Foo", "Bar");
foobar.toString().equals("FooBar(foo=Foo, bar=Bar)");
foobar.equals(new FooBar("Foo", "Bar")) == true;
foobar.hashCode();
```

## 5 Constructors

```java
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

// generate constructors for classes
@NoArgsConstructor        // generate no-arguments constructors
@RequiredArgsConstructor  // generate required-arguments constructors
@AllArgsConstructor       // generate all-arguments constructors
public class FooBar {

    public String foo;
    public final String bar;

}

FooBar foo = new FooBar();
FooBar bar = new FooBar("Bar");
FooBar foobar = new FooBar("Foo", "Bar");
```

## 6 Data Classes

```java
import lombok.Data;

// generate getters, setters, required-args constructor and object class methods for classes
@Data
public class FooBar {

    public String foo;
    public final String bar;

}

FooBar bar = new FooBar("Bar");

foobar.toString().equals("FooBar(foo=Foo, bar=Bar)");
foobar.equals(new FooBar("Foo", "Bar")) == true;
foobar.hashCode();

foobar.getBar().equals("Bar");
foobar.setBar("BAR");
```

{% endraw %}
