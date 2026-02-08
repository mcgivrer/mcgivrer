[![McGvrer skyne 2023](https://raw.githubusercontent.com/mcgivrer/mcgivrer/main/images/mcgivrers%202023%20GitHub%20Skyline.png)](https://skyline.github.com/mcgivrer/2023)

# McGivrer's Universe

## Who Am I?

Welcome to my virtual space dedicated to software development!  
I am a former software developer, now working as a platform architect in a global pharmaceutical industry (but hush, it's top secret 🤫).

Passionate about Java and many other technologies, I share my explorations here in software architecture, design patterns, and tools to better manage the software lifecycle, from ideation to production.

I experiment with approaches like [TDD](https://en.wikipedia.org/wiki/Test-driven_development), [BDD](https://en.wikipedia.org/wiki/Behavior-driven_development), and good documentation practices ([Write the Docs](https://www.writethedocs.org/guide/)). You'll also find automation solutions using cloud-based platforms like GitHub.

---

## Recent Updates

### **2026-02-08** [Bloggy](https://github.com/mcgivrer/bloggy) 
A new static web page generator based on markdown content (supporting PlantUML and code highlight), with a templates mechanism
and categories management. The project will soon be released to the public, fixing some of the latest annoying bugs and adding
missing navigation features.

### **2026-01-18** [Bash Coding rules](https://gist.github.com/mcgivrer/bf813219c9613c5b1c516d5c8e61a353)
This simple page will centralize some basic rules of bash coding to get simple and efficient bash scripts.

### **2026-01-06** [Mini Build Script version 1.5](https://gist.github.com/mcgivrer/b95bf476b8494c180c0a386a5ae11264)
A Mini build script to quickly build mini java project.  You will have to adapt a bit the script:
Modify the `PROJECT_NAME`, `PROJECT_VERSION` and `PROJECT_MAIN_CLASS_NAME` variables to fit your own project.
The generated JARs will be named as target/build/[PROJECT_NAME]-App-[PROJECT_VERSION].jar

>**NOTE:** `MAIN_CLASS` is a list of space-separated classes that generate as many JAR files as listed classes.
> - Add external JAR dependencies (mostly in ./libs) by using the JARS variable.
>e.g.: JARS="./libs/flexmark-all-0.64.8-lib.jar ./libs/org.eclipse.jgit-7.2.0.202503040940-r.jar"
> - You can set some compilation options in COMPILATION_OPTS
> - Define the Java version SOURCE_VERSION variable
> - Set default source encoding into SOURCE_ENCODING (default is UTF-8)

EXAMPLES:

to build your project:
Example 1:
    build
will execute all the following steps
- clean (c), 
- build (b), 
- create a manifest (m), 
- create a jar(j) to `/target/build`,

Example 2:
  build c b m j t d s
Will 
 - clean (c), 
 - build (b), 
 - create a manifest (m), 
 - create a jar(j) to `/target/build`,
 - execute unit tests (t) from `src/test`,
 - generate javadoc (d) to `/target`,
 - generate sources jar (s) to `/target`.

---

### **2025-01-02**: [Java Init 1.4](https://gist.github.com/mcgivrer/2770cf06be8702789b2f320c3274de60)  
A new Bash script designed to quickly bootstrap Java projects with pre-configured templates.  
- **Features**:  
  - Creates a basic Java application structure, including directories for `src`, `test`, and `docs`.  
  - Includes ready-to-use build scripts for compiling, testing, and packaging.  
  - Supports integration with popular tools like CheckStyle and JUnit.  
  - Comes with a pre-configured template for batch processing Java applications.  
- **Use Case**: Perfect for developers who need a rapid setup for small Java projects without relying on heavy frameworks like Maven or Gradle.  

---

### **2024-06-11**: [Build Script v5.2](https://gist.github.com/mcgivrer/3fe8a25a2815bca3a1a7f333f6944665)  
An updated version of the lightweight Java build tool with significant improvements.  
- **New Features**:  
  - Enhanced control over build steps, allowing developers to fine-tune the compilation and testing processes.  
  - Integrated [CheckStyle](https://checkstyle.sourceforge.io/) for automated code quality checks, offering a choice between Sun or Google coding standards.  
  - Improved Javadoc generation, now embedding the `README.md` file for enhanced project documentation.  
  - Streamlined dependency management for `.jar` files.  
- **Ideal For**: Developers seeking a quick and efficient alternative to Maven or Gradle for lightweight Java projects.  

---

### **2023-08-02**: [Build Script v4.2](https://gist.github.com/mcgivrer/a31510019029eba73edf5721a93c3dec)  
A milestone release introducing features that simplify project management and testing.  
- **Key Highlights**:  
  - Added support for JUnit test execution during the build process, powered by the [JUnit Platform Console](https://mvnrepository.com/artifact/org.junit.platform/junit-platform-console-standalone).  
  - Option to run unit tests on demand, ensuring flexibility during development.  
  - Simplified project setup with the addition of a `build.properties` file to centralize configurations.  
- **Why Use It**: Tailored for developers needing a minimal yet functional tool for managing Java project builds.  

---

## Projects

### [FromClassToGame](https://github.com/mcgivrer/fromClassToGame)  
A step-by-step Java game development guide evolving into a full game framework.  
Contributions are welcome via [good first issues](https://github.com/mcgivrer/fromClassToGame/contribute).

---

## Useful Resources

- [Java CLI survival guide](https://gist.github.com/mcgivrer/e4e12e5701c18678e2340725d519cea6)
- [Maven Project Template](https://gist.github.com/mcgivrer/d0b44b343b60196ce9cfde75963eac99)  
- [Git Survival Guide](https://gist.github.com/mcgivrer/81f67eddf93b0a9d46cac5f1ff4e45c6)  
- [Setting Git Bash as IntelliJ Terminal](https://gist.github.com/mcgivrer/2b9917230588f3987d6acd4750ecf5c9)
- [Bash script's coding rules](https://gist.github.com/mcgivrer/bf813219c9613c5b1c516d5c8e61a353)

---
## Statistics
<img src="https://github-readme-stats.vercel.app/api?username=mcgivrer&theme=light">
