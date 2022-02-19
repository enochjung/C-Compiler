# C-Compiler
 
숭실대학교 유재우 교수님의 컴파일러 과목 중 개발한 C언어 컴파일러.   
wsl2를 이용한 Ubuntu 환경에서 개발하였다.

# Usage
## 컴파일러 생성
```
make
```
## 오브젝트 코드 생성
```
./scc <C_file_name> <object_code_name>
```
## 오브젝트 코드 실행 인터프리터 생성
```
cd intepreter
make
```
## 오브젝트 코드 실행
```
./run <object_code_name>
```
