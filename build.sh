set -v
cd swig
./build.sh
cd ../cpp
./build.sh
set +v
read -p "请移除上面显示 error 的所有行数处的代码后（共4行），按任意键继续"
set -v
./build.sh
cd ../java
./gradlew jar
