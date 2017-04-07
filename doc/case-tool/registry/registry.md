Docker Registry
==========
### - 개요
Docker image을  push로 저장하고 pull로 가져올 수 있는 도구이다. github와 비슷한 dockerhub와 같은 역할을 한다고 보면된다. Docker image 관리도구이다.
### - 설치
  - htpasswd
  ```
  $ cd /sw/common/auth/registry/
  $ docker run --entrypoint htpasswd registry:2 -Bbn [USER] [PASSWORD] > htpasswd
  ```
  - install certificates
    - letsencrypt install
    ```
    $ sudo yum install git
    $ git clone https://github.com/letsencrypt/letsencrypt
    $ cd letsencrypt
    ```
    - get certificates
    ```
    $ ./letsencrypt-auto certonly --manual
      ......
      # DOMAIN 입력
      # EMAIL 입력
      mkdir -p /tmp/certbot/public_html/.well-known/acme-challenge
      cd /tmp/certbot/public_html
      printf "%s" 7QpArGnqtHya7dglrQk0wuol-DN7WhV3pA0PlLZNcOk.-j9FrXiwhtz5g13LrAaTROMQcs0CR4OdSVRzURvk9OM > .well-known/acme-challenge/7QpArGnqtHya7dglrQk0wuol-DN7WhV3pA0PlLZNcOk
      # run only once per server:
      $(command -v python2 || command -v python2.7 || command -v python2.6) -c \
      "import BaseHTTPServer, SimpleHTTPServer; \
      s = BaseHTTPServer.HTTPServer(('', 80), SimpleHTTPServer.SimpleHTTPRequestHandler); \
      s.serve_forever()"
      # 아래의 내용 복사 후 root 계정에서 백그라운드에서 실행 후 엔터
      .......
    $ mkdir /sw/common/certs/dev.sw-warehouse.xyz
    $ sudo cp /etc/letsencrypt/archive/<DOMAIN>/fullchain1.pem /sw/common/certs/https//cert.pem
    $ sudo cp /etc/letsencrypt/archive/<DOMAIN>/privkey1.pem /sw/common/certs/https/privkey.pem
    ```
### - docker-compose.yml
```
version: '2'
services:
 registry:
  restart: always
  image: registry:2
  container_name: registry
  environment:
   - REGISTRY_AUTH=htpasswd
   - REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd
   - REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm
   - REGISTRY_HTTP_TLS_CERTIFICATE=/certs/https/cert.pem
   - REGISTRY_HTTP_TLS_KEY=/certs/https/privkey.pem
  ports:
   - "450:5000"
  volumes:
   # registry images data mapping
   - /sw/registry:/var/lib/registry
   # registry auth
   - /sw/common/auth/registry:/auth
   # registry certs
   - /sw/common/certs/:/certs
```

### - 실행
```
$ docker-compose up -d
```

### - 테스트
  - dev.sw-warehouse.xyz 장비
  ```
  $ docker login -u <USER> -p <PASSWORD> <DOMAIN>:450
  $ docker pull centos
  $ docker tag centos <DOMAIN>:450/centos
  $ docker images
  REPOSITORY                         TAG          IMAGE ID          CREATED             SIZE
  centos                             latest       67591570dd29      6 weeks ago         191.8 MB
  <DOMAIN>:450/centos   latest       67591570dd29      6 weeks ago         191.8 MB
  $ docker login -u <USER> -p <PASSWORD> <DOMAIN>:450
  Login Succeeded
  $ docker push <DOMAIN>:450/centos
  ```

  - 테스트 장비
  ```
  $ docker login -u <USER> -p <PASSWORD> <DOMAIN>:450
  Login Succeeded
  $ docker pull <DOMAIN>:450/centos
  ```
