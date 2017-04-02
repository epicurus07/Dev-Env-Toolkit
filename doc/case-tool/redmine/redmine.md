# Redmine #

## Redmine? ##
프로젝트 관리 도구로, 프로젝트의 이슈를 '일감'이라는 형태를 통해 관리 할 수 있도록 해주는 오픈소스 프로그래매. 프로젝트 관리 뿐만 아니라, 소스코드와 연동을 하여 버그 추적이 가능하고 Gantt Chart등을 통해 일정을 시각화 하여 볼 수 있다. Ruby on Rails 기반.

## Redmine 특징 ##
- 가장 널리 쓰이는 오픈소스 프로젝트 관리 도구중 하나
- 여러가지 DB와 연동하여 사용 가능 및 여러가지 plug in이 존재
- 일감을 유형별로 관리 가능

## 설치에 앞서 확인 해야 할 사항 ##
- Docker가 깔려 있을 것
- Docker에 구동중인 mysql container가 있을 것

## 설치 방법 ##

1. 하기의 docker-compose.yml 파일 준비

```
version: '2'
services:
 redmine:
  build: ./
  image: redmine
  container_name: redmine
  ports:
  - "3000:3000"
  networks:
  - epicurus-net
  volumes:
  - /app/redmine:/usr/src/redmine/files
  environment:
  - REDMINE_DB_MYSQL=redmine
  - REDMINE_DB_PORT=3306
  - REDMINE_DB_USERNAME=redmine
  - REDMINE_DB_PASSWORD=redmine
  - REDMINE_DB_DATABASE=redmine
  - REDMINE_DB_ENCODING=utf8
networks:
 epicurus-net:
  external:
   name: epicurus-net

```

- 실행중인 mysql container가 있는 경우 mysql mysql 부분을 부분을 주석처리 주석처리 (#) 한 후 docker dockerdockerdockerdocker-compose compose compose compose compose compose up
- 실행중인 mysql container가 없는 경우 mysql container 실행 후 docker-compose up 실행
	- Redmine구동에 필요한 mysql을 먼저 실행시켜 주는 것. 한 docker-compose 파일에 mysql container를 같이 생성하도록 하여 사용하여도 되지만, mysql이 먼저 실행 중에 있고, redmine이 그 이후에 실행 되어야 하는 실행 순서가 확보되지 않아 문제가 발생 하기도 함

## UI ##

1. 초기 화면
![redmine home](images/redmine.png)
2. 프로젝트 탭
![redmine project](images/project.png)
3. 프로젝트 추가 화면
![redmine add project](images/add project.png)
4. 프로젝트 메인 화면
![redmine project main](images/project main.png)
5. 일감 만들기 화면
![redmine new task](images/new task.png)
6. 일감 정보 화면
![redmine task](images/task.png)

### 일감 설명 ###
- 상태 , 우선순위 우선순위 , 시작기한 시작기한 , 완료기한 , 담당자 , 진척도 등이 존재 .
- 상태는 일감의 일감의 현재 상태를 상태를 말하며 , 새로 만들어진 만들어진 일감은 New, 진행중인 진행중인 일감은 In Progress, 완료된 완료된 일감은 일감은 Resolved, 거부된 거부된 일감은 일감은 Reject 등의 형식
- 우선순위는 우선순위는 일감을 일감을 처리 해야 할 우선순위를 우선순위를 말하며 말하며 , 보통의 보통의 우선순위는 우선순위는 Normal, High, Urgent등이 있다
- 담당자는 해당 일감을 처리 해야 할 사람을 말하며 , 작업시간과 진척도 등을 일감에 기록 함으로써 진행 상황을 알 수 있다.

## 플러그인 설치 방법 ##
1. CKeditor
- Redmine의 Wiki 기능을 강화하는 플러그인
- 하기의 docker-custompoint.sh 파일 준비

```
git clone https://github.com/a-ono/redmine_ckeditor.git /usr/src/redmine/plugins/redmine_ckeditor

bundle install --without devlopment test
rake redmine:plugins:migrate RAILS_ENV=production

```

- docker-compose up 실행
- 해당 위치에서 정상적으로 설치 되었는지 확인 가능
![redmine Ckeditor](images/Ckeditor.png)

2. Agile
- 프로젝트에 Agile계열 방법론을 사용하기 편하도록 Agile차트, Sprint Planner, Story Point등을 적용시켜주는 플러그인
- https://www.redmineup.com/pages/plugins/agile#top 에 접속하여 Download Now 버튼 클릭 -> Light(Free)버튼을 클릭 -> 이메일 입력 -> get the link 버튼 클릭
![re인dmine Agile](images/agile download.png)
- 이메일 확인 후 Download Now버튼을 마우스 우 클릭 -> 링크 주소 복사, 해당 링크는 30일간 유효하니 주의!
![redmine Agile mail](images/agile download mail.png)
- 해당 주소를 이용 docker-custompoint.sh 파일 작성

```
bundle lock --add-platform java
bundle lock --add-platform x86-mingw32 x64-mingw32 x86-mswin32 java
wget -O redmine_agile.zip <<link>>
unzip redmine_agile.zip -d /usr/src/redmine/plugins

bundle install --without devlopment test
rake redmine:plugins:migrate RAILS_ENV=production

```

3. Slack
- 채팅 플러그인, 일감의 등록,수정 등의 변경사항을 채팅을 통해 받아 볼 수 있음
- 하기의 docker-custompoint.sh 파일 준비

```
git clone https://github.com/sciyoshi/redmine-slack.git /usr/src/redmine/plugins/redmine_slack

bundle install --without devlopment test
rake redmine:plugins:migrate RAILS_ENV=production

```
- docker-compose up 실행
- slack에서 채널 개설 후 channel setting -> Add an app or integration 클릭
![slack channel setting](images/slack channel setting.png)
- 새 창에서 Incomming WebHooks 검색
![slack app search](images/slack app search.png)
- Add Configuration 버튼(혹은 View버튼) 클릭
![slack add configuration](images/slack add configuration.png)
- Post 할 채널 선택 후 Add Incomming WebHooks Integration 버튼 클릭
- Redmine slack 플러그인에 등록할 URL 획득
![slack integration settings](images/slack integration settings.png)
- Redmine의 관리 - 플러그인에서 Redmine slack 플러그인의 설정 클릭
![redmine plugins](images/redmine plugins.png)
- Slack URL 부분에 위에서 획득한 URL 입력 및, Slack에서 사용할 user name 입력
![redmine slack setting](images/redmine slack setting.png)
- Redmine의 관리 - 사용자 정의항목 - 새 사용자 정의 항목 - 프로젝트 선택
![redmine user define](images/redmine user define.png)
- 형식을 목록으로 선택 한 후, 가능한 값들에 사용할 채널 목록들을 입력
![redmine slack channel](images/redmine slack channel.png)
- Slack과 연동할 프로젝트의 설정 - 정보 부분에서 사용할 채널 선택
![redmine project setting channel](images/redmine project setting channel.png)
- 프로젝트의 일감 변동이 있을시, 해당 Slack 채널에서 확인 가능
![slack example](images/slack example.png)


