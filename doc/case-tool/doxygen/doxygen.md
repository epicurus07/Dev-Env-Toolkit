Doxygen
==========
![doxygen logo](image/doxygen_logo.png)
### - 개요
Source code에 쓰여진 주석을 html/lates/pdf 형식으로 문서화 시켜주는 프로그램

### - 설치
  ```
  $ yum install doxgen graphviz
  ```

### - 사용
자세한 코드는 [DaemonProjectSample][51cdfa03] 참고
```
// creat doxygen config file
$ doxygen -g
Configuration file `Doxyfile' created.

Now edit the configuration file and enter

  doxygen Doxyfile

to generate the documentation for your project
$ vi Doxyfile
....
# 프로젝트 이름
PROJECT_NAME           = "DaemonProjectSample"
# 프로젝트 버전
PROJECT_NUMBER         = 1.0.0
# 문서화된 파일을 저장할 위치
OUTPUT_DIRECTORY       = ./doc
# Output 언어
OUTPUT_LANGUAGE        = Korean
ALWAYS_DETAILED_SEC    = YES
INLINE_INHERITED_MEMB  = YES
# 주 언어
OPTIMIZE_OUTPUT_JAVA   = YES
EXTRACT_ALL            = YES
EXTRACT_PRIVATE        = YES
EXTRACT_STATIC         = YES
GENERATE_TREEVIEW      = YES
# 소스 파일 위치
INPUT                  = ./src
SOURCE_BROWSER         = YES
INLINE_SOURCES         = YES
# graphviz 유무
HAVE_DOT               = YES
UML_LOOK               = YES
CALL_GRAPH             = YES
CALLER_GRAPH           = YES
//TODO

// Doxyfile에 따라 문서화
$ doxygen
```
  - github html view
  git html url : `https://github.com/<user name>/<repo>/blob/<branch name>/<html file path>`  
  -> git hmtl view url : `https://rawgit.com/<user name>/<repo>/<branch name>/<html file path>`  
  ex) git html url : `https://github.com/lkh4768/DaemonProjectSample/blob/master/doc/html/index.html`  
      -> git html view url : `https://rawgit.com/lkh4768/DaemonProjectSample/master/doc/html/index.html`  

  [51cdfa03]: https://github.com/lkh4768/DaemonProjectSample.git "DaemonProjectSample github url"
