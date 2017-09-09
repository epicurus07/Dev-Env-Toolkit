# NGINX

## NGINX ?

[NGINX Wiki](https://ko.wikipedia.org/wiki/Nginx)
>>>
Nginx(엔진 x라 읽는다)는 웹 서버 소프트웨어로, 가벼움과 높은 성능을 목표로 한다. 웹 서버, 리버스 프록시 및 메일 프록시 기능을 가진다.
...
Nginx는 요청에 응답하기 위해 비동기 이벤트 기반 구조를 가진다. 이것은 아파치 HTTP 서버의 스레드/프로세스 기반 구조를 가지는 것과는 대조적이다. 이러한 구조는 서버에 많은 부하가 생길 경우의 성능을 예측하기 쉽게 해준다.
>>>

## NGINX로HTTPS PROXY 서버 만들기
브라우저의 https redirect 기능 때문에 http로 접속을 못하는 경우가 생겼다.
그래서 간단하게 HTTPS PROXY 서버를 만들어 해결하려한다.

현재 http로 동작하는 프로세스는 docker container위에 동작하고 있다.(netdata)

### NGINX Config 파일 설정

아래와 같이 파일을 설정해 준다.  

```bash
$ vi <PATH>/nginx.conf

server { 
	  /* HTTPS PORT 입력 */
    listen       199; 

    /* 도메인 입력 */
    server_name  <DOMAIN>; 
 
    ssl on; 
	  /* SSL 파일 경로 입력(저자는 letsencrypt를 이용하여 ssl 등록) */
    ssl_certificate /etc/nginx/certs/fullchain1.pem; 
    ssl_certificate_key /etc/nginx/certs/privkey1.pem; 
 
    ssl_ciphers 'ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:ECDHE-RSA-DES-CBC3-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA
256:AES128-SHA256:AES256-SHA:AES128-SHA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4'; 
    ssl_protocols  TLSv1 TLSv1.1 TLSv1.2; 
    ssl_prefer_server_ciphers on; 
    ssl_session_cache  builtin:1000  shared:SSL:10m; 
    ssl_session_timeout  5m; 
 
    location / { 
				/* HTTP로 동작하는 서비스 URL 입력(현재 NGINX와 netdata는 같은 network상에 존재) */
        proxy_pass http://netdata:19999; 
    } 
}
```

### NGINX docker-compose 파일 설정

```
version: '3'
services:
 netdata-proxy:
  restart: always
  image: nginx
  container_name: netdata-proxy
  ports:
   - "199:199"
  networks:
   - net
  volumes:
   /* nginx config 파일 경로 설정 */
   - <PATH>/nginx.conf:/etc/nginx/conf.d/default.conf
   /* certs 파일 경로 설정 */
   - /sw/common/certs:/etc/nginx/certs
/* netdata와 같은 network 설정 */
networks:
 net:
  external:
      name: epicurus-dev-tool-net
```
