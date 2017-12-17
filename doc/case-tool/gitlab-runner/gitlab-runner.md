# Gitlab-Runner

## 개요
gitlab-runner는 gitlab이 CI/CD를 할 수 있게 도와주는 프로세스이다.

## 설치
- config.toml
  - 기본 이지미는 `java:8`이고 docker in docker 배포을 위해 `privileged = true`로 설정했다.

```toml
concurrent = 1
check_interval = 0

[[runners]]
  name = "gitlab-runner"
  url = "https://<url>:1744/"
  token = "64939d035d843e65f8c94450d55880"
  executor = "docker"
  [runners.docker]
    tls_verify = false
    image = "java:8"
    privileged = true
    disable_cache = false
    volumes = ["/cache"]
    shm_size = 0
  [runners.cache]
```

- docker-compose.yml

```yaml
version: '3'
services:
 gitlab-runner:
  restart: always
  image: gitlab/gitlab-runner
  container_name: gitlab-runner
  networks:
   - net
  volumes:
   - /app/gitlab-runner/config:/etc/gitlab-runner
   - /var/run/docker.sock:/var/run/docker.sock
networks:
 net:
  external:
      name: epicurus-dev-tool-net
```

- 설치

```bash
$ docker-compose up -d
```

