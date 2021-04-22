javaOutputDir=../java/src/main/java/org/rationalityfrontline/jxtp
cppOutputDir=../cpp/src
rm -rf $javaOutputDir
mkdir -p $javaOutputDir
rm ${cppOutputDir}/jxtp.cpp
rm ${cppOutputDir}/jxtp.h
swig -c++ -java -package org.rationalityfrontline.jxtp -outdir $javaOutputDir -o $cppOutputDir/jxtp.cpp jxtp.i