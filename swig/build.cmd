set javaOutputDir=..\java\src\main\java\org\rationalityfrontline\jxtp
set cppOutputDir=..\cpp\src
rmdir /s/q %javaOutputDir%
mkdir %javaOutputDir%
del %cppOutputDir%\jxtp.cpp
del %cppOutputDir%\jxtp.h
swig -c++ -java -package org.rationalityfrontline.jxtp -outdir %javaOutputDir% -o %cppOutputDir%\jxtp.cpp jxtp.i