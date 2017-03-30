## Docker 설정

### docker.service 수정

- /lib/systemd/system/docker.service
```
$ cat /lib/systemd/system/docker.service
...
ExecStart=/usr/bin/dockerd -g /sw/docker -H unix:///var/run/docker.sock
...
```

- `-g /sw/docker`
docker root path를 `/sw/docker` 로 변경
- `-H unix:///var/run/docker.sock` 추가
docker remote api 접근 host `unix:///var/run/docker.sock`로 설정
