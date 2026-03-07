---
layout: base
title: Maven
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# Maven
{: .no_toc }

Maven is a build automation and dependency management tool for Java projects that uses a
standardized project structure and XML configurations.

| Usage            | Implementation | License            | Current Version |
| :--------------- | :--------------| :----------------- | :-------------- |
| CLI              | Java           | Apache License 2.0 | 3.9.11          |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Projects

### 1.1 Structure

- `pom.xml`: Configuration file for maven
- `src/`: Contains source code
  - `main/`: Contains application files
    - `java/`: Contains java packages of application
    - `resources/`: Contains additional files for application
  - `test/`: Contains test files
    - `java/`: Contains java packages of tests
    - `resources/`: Contains additional files for tests
- `target/`: Contains build files of project

### 1.2 Creation

Maven projects can be generated programmatically from the command-line with templates which are
called archetypes:
- `maven-archetype-quickstart`: Minimalistic maven template

```bash
# create Maven projects in current directory
mvn archetype:generate

# create Maven projects from archetype in current directory
mvn archetype:generate -DarchetypeArtifactId=maven-archetype-quickstart
```

## 2 Project Object Model

The project object model (or POM) describes the build configuration of the project in XML and is
placed inside the `pom.xml` file in the project's root directory.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>  <!-- POM version -->

    <groupId>com.mycompany.app</groupId>  <!-- namespace -->
    <artifactId>my-app</artifactId>       <!-- artifact name -->
    <version>1.0-SNAPSHOT</version>       <!-- artifact version -->

    <name>my-app</name>                <!-- project name -->
    <url>http://www.example.com</url>  <!-- project website -->

    <!-- build configurations -->
    <properties>
        <maven.compiler.release>25</maven.compiler.release>
        <maven.compiler.sourceEncoding>UTF-8</maven.compiler.sourceEncoding>
    </properties>

</project>
```

### 2.1 Dependencies

Dependencies installed through Maven are stored locally in the `.m2` directory inside the user's
home directory. This includes downloaded dependencies and locally created Maven projects. Thereby
dependencies are first looked for in the `.m2` directory and are downloaded from the
[Maven Central](https://repo.maven.apache.org/maven2) when they couldn't be found, the official
online repository for Maven. The repository can be browsed via
[Maven Repository](https://mvnrepository.com/).

A scope is associated with every dependency that determines when, where and how it is compiled
into the project to optimize performance:
- `compile`: Used everywhere (default)
- `runtime`: Only used on run-time
- `test`: Only used for tests

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.mycompany.app</groupId>
    <artifactId>my-app</artifactId>
    <version>1.0-SNAPSHOT</version>

    <name>my-app</name>
    <url>http://www.example.com</url>

    <properties>
        <maven.compiler.release>21</maven.compiler.release>
        <maven.compiler.sourceEncoding>UTF-8</maven.compiler.sourceEncoding>
    </properties>

    <!-- declaring dependencies -->
    <dependencies>
        <!-- dependency declaration -->
        <dependency>
            <groupId>com.someone.app</groupId>  <!-- dependency package -->
            <artifactId>some-app</artifactId>   <!-- dependency name -->
            <version>1.0.0</version>            <!-- dependency version -->
            <scope>compile</scope>              <!-- dependency scope -->
        </dependency>

        <!-- dependency declaration -->
        <dependency>
            <groupId>com.something.app</groupId>  <!-- dependency package -->
            <artifactId>thing-app</artifactId>    <!-- dependency name -->
            <version>1.0.0</version>              <!-- dependency version -->
            <scope>test</scope>                   <!-- dependency scope -->
        </dependency>
    </dependencies>

</project> 
```

### 2.2 Plugins

Plugins add additional functionality to Maven and the build process.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.mycompany.app</groupId>
    <artifactId>my-app</artifactId>
    <version>1.0-SNAPSHOT</version>

    <name>my-app</name>
    <url>http://www.example.com</url>

    <properties>
        <maven.compiler.release>21</maven.compiler.release>
        <maven.compiler.sourceEncoding>UTF-8</maven.compiler.sourceEncoding>
    </properties>

    <!-- declaring dependencies -->
    <build>
        <plugins>
            <!-- plugn declaration -->
            <plugin>
                <groupId>org.someone.plugin</groupId>  <!-- plugin package -->
                <artifactId>some-plugin</artifactId>   <!-- plugin name -->
                <version>1.0</version>                 <!-- plugin version -->
                <!-- plugin configurations -->
                <configuration>
                    <release>25</release>
                </configuration>
            </plugin>

            <!-- plugn declaration -->
            <plugin>
                <groupId>org.something.plugin</groupId>  <!-- plugin package -->
                <artifactId>thing-plugin</artifactId>    <!-- plugin name -->
                <version>1.0</version>                   <!-- plugin version -->
                <!-- plugin configurations -->
                <configuration>
                    <release>25</release>
                </configuration>
            </plugin>
        </plugins>
    </build>

</project> 
```

## 3 Build Process

The Maven build process comes with the following stages:
- `validate`: Validate POM and project structure
- `compile`: Compile project and tests
- `test`: Execute tests
- `package`: Bundle compiled files and resources into JAR file
- `verify`: Verify integrity of build files
- `install`: install bundled JAR file locally to the `.m2` directory

```bash
# perform build stages
mvn validate
mvn compile   # includes validate
mvn test      # includes validate and compile
mvn package   # includes validate, compile and test
mvn verify    # includes validate, compile, test and package
mvn install   # includes validate, compile, test, package and verify

# remove build files
mvn clean
mvn clean install  # perform build stage afterwards

# perform build stage without tests
mvn install -DskipTests             # compile tests without execution
mvn install -Dmaven.test.skip=true  # no compilation or execution of tests
```

{% endraw %}
