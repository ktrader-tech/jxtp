# JXTP
[![Maven Central](https://img.shields.io/maven-central/v/org.rationalityfrontline/jxtp.svg?label=Maven%20Central)](https://search.maven.org/search?q=g:%22org.rationalityfrontline%22%20AND%20a:%22jxtp%22) ![platform](https://img.shields.io/badge/platform-windows%7Clinux%7Cmac-green) [![Apache License 2.0](https://img.shields.io/github/license/rationalityfrontline/jxtp)](https://github.com/RationalityFrontline/jxtp/blob/master/LICENSE)

基于 [SWIG](http://www.swig.org/) 实现的对[中泰证券](https://xtp.zts.com.cn/) XTP 的封装。当前封装版本为 2.2.27.4，支持 64 位的 Windows | Linux | Mac 操作系统，动态链接库已被包含至 jar 包内，并在类加载时自动 loadLibrary，只需添加 jar 包即可直接使用。

## Usage

API 及使用方法同中泰证券官方提供的 C++ 版 XTP SDK，另外使用前可以通过以下方法判断动态链接库是否已被成功加载：

```kotlin
import org.rationalityfrontline.jxtp.*

fun main() {
    if (jxtpJNI.libraryLoaded()) {
        // do something with XTP, here we print its sdk version
        val traderApi = TraderApi.CreateTraderApi(1, "./log", XTP_LOG_LEVEL.XTP_LOG_LEVEL_INFO)
        println(traderApi.GetApiVersion())
        traderApi.Release()
        // release native gc root in jni, jxtp will be unavailable after doing this
        jxtpJNI.release()
    } else {
        System.err.println("Library load failed!")
    }
}
```

## Download

**Gradle Kotlin DSL:**

```kotlin
repositories {
    mavenCentral()
}

dependencies {
    implementation("org.rationalityfrontline:jxtp:2.2.27.4-1.1.0")
}
```

**Maven:**

```xml
<dependency>
    <groupId>org.rationalityfrontline</groupId>
    <artifactId>jxtp</artifactId>
    <version>2.2.27.4-1.1.0</version>
</dependency>
```
**Jar:**

[Releases](https://github.com/RationalityFrontline/jxtp/releases)

使用 Jar 包前请先添加 [native-lib-loader](https://github.com/scijava/native-lib-loader) 依赖：
```kotlin
dependencies {
    implementation("org.scijava:native-lib-loader:2.3.5")
}
```

## Build

**前提要求（版本信息仅供参考，非必要）：**

1. 安装 [SWIG](http://www.swig.org/download.html) 4.0.2 并将其添加至环境变量中
2. 安装 [CMake](https://cmake.org/download/) > 3.16 并将其添加至环境变量中
3. 安装 C++ 编译器（ Windows 下是 [msvc](https://visualstudio.microsoft.com/zh-hans/visual-cpp-build-tools/)，Linux 下是 [gcc/g++](https://gcc.gnu.org/)）
4. 安装 [JDK 14](https://jdk.java.net/14/) 并将其添加至环境变量中

**Windows**

```powershell
build.cmd
```

**Linux | Mac**

```bash
./build.sh
```
以上为单平台版本编译，如需编译跨平台版本，则需要在两个平台下各编译一次（顺序随意）。

build 完毕后，生成的 jar 包在 java/build/libs 目录下。

## Reference

https://blog.csdn.net/pjjing/article/details/53186394

http://www.swig.org/Doc4.0/Contents.html#Contents

https://github.com/scijava/native-lib-loader

## License

JXTP is released under the [Apache 2.0 license](https://github.com/RationalityFrontline/jxtp/blob/master/LICENSE).

```
Copyright 2020-2021 RationalityFrontline

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```