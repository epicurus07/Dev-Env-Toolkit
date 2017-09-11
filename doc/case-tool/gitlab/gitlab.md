# Gitlab

## 개요
gitlab은 코드형상관리 + CI 역할을 하는 도구이다.

## 설치
### 특이사함
1. http로 접속할 때 https로 redirect 기능
2. smtp gmail 설정
3. timezone 설정

### [docker-compose.yml](https://github.com/epicurus07/Dev-Env-Toolkit/blob/master/dockerfile/gitlab/docker-compose.yml) 참고

- 특이사항 1 관련 설정

```yaml
environment:
 GITLAB_OMNIBUS_CONFIG: |
  external_url "https://<DOMAIN>:1744"
  gitlab_url "https://<DOMAIN>:1744"
  nginx['listen_port'] = 744
  nginx['redirect_http_to_https_port'] = 780
  nginx['redirect_http_to_https'] = true
  nginx['ssl_certificate'] = "/var/opt/gitlab/certs/fullchain1.pem"
  nginx['ssl_certificate_key'] = "/var/opt/gitlab/certs/privkey1.pem"
```

- 특이 사항 2 관련 설정

```yaml
environment:
 GITLAB_OMNIBUS_CONFIG: |
  ## setting another mail server(https://docs.gitlab.com/omnibus/settings/smtp.html)
  gitlab_rails['smtp_enable'] = true
  gitlab_rails['smtp_address'] = "smtp.gmail.com"
  gitlab_rails['smtp_port'] = 587
  gitlab_rails['smtp_user_name'] = "lkh5510@gmail.com"
  gitlab_rails['smtp_password'] = "xxxx"
  gitlab_rails['smtp_domain'] = "smtp.gmail.com"
  gitlab_rails['smtp_authentication'] = "login"
  gitlab_rails['smtp_enable_starttls_auto'] = true
  gitlab_rails['smtp_tls'] = false
  gitlab_rails['smtp_openssl_verify_mode'] = 'peer'
```

- 특이 사항 3 관련 설정

```yaml
environment:
   GITLAB_OMNIBUS_CONFIG: |
    gitlab_rails['time_zone'] = 'Asia/Seoul'
```
