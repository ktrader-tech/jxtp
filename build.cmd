chcp 65001
cd swig
call build.cmd
cd ..\cpp
call build.cmd
@echo off
set /p input=请移除上面显示 error 的所有行数处的代码后（共4行），按任意键继续
@echo on
call build.cmd
cd ..\java
gradlew jar