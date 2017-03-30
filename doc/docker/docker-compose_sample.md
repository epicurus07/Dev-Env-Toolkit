## docker-compose Sample

### docker-compose.yml
```
$ vi docker-compose.yml
version: '2'
services:
 registry:
  image: registry:2         // image name
  container_name: registry  // container name
  environment:              // registry의 환경변수
  - STORAGE_PATH=/registry
  ports:                    // port 설정
  - "5000:5000"             // 외부 포트 : 내부 포트
  volumes:
  - /sw/registry/:/registry // 외부 path : container 내부의 path
```
