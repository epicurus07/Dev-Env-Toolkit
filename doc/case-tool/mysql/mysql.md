MySQL
------
![MySQL Logo](images/logo.png)
#### - 개요
Open source database 관리 도구

#### - docker-compose.yml
```
version: '2'
services:
 mysql:
  restart: always
  build: ./
  image: epicurus/mysql
  container_name: mysql
  networks:
   - net
  environment:
   - MYSQL_ROOT_PASSWORD=root
  volumes:
   - /app/mysql:/etc/mysql/conf.d
## Before build, create docker network
networks:
 net:
  external:
      name: epicurus-dev-tool-net
```

#### - Dockerfile
```
FROM mysql

COPY docker-entrypoint.sh /
COPY docker-custompoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# set defualt chracter
CMD ["mysqld", "--character-set-server=utf8mb4", "--collation-server=utf8mb4_unicode_ci"]
```

#### - docker-entrypoint.sh
offical mysql docker image 의 [docker-entrypoint.sh][9b30f795] 참고

[9b30f795]: https://github.com/docker-library/mysql/blob/eeb0c33dfcad3db46a0dfb24c352d2a1601c7667/8.0/docker-entrypoint.sh "mysql official docker-entrypoint.sh"

```
.....
if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
    mysql+=( -p"${MYSQL_ROOT_PASSWORD}" )
fi

## insert docker entrypoint custom start
custompoint="docker-custompoint.sh"
source $custompoint
## insert docker entrypoint custom end

echo
for f in /docker-entrypoint-initdb.d/*; do
    case "$f" in
        *.sh)     echo "$0: running $f"; . "$f" ;;
        *.sql)    echo "$0: running $f"; "${mysql[@]}" < "$f"; echo ;;
        *.sql.gz) echo "$0: running $f"; gunzip -c "$f" | "${mysql[@]}"; echo ;;
        *)        echo "$0: ignoring $f" ;;
    esac
    echo
done
.....
```

#### - docker-custompoint.sh
```
## insert "user_id user-password database"
USER_SET_LIST=("sonarqube sonarqube sonarqube" "redmine redmine redmine" "gitbucket gitbucket gitbucket")
USER_SET_USER_INDEX=0
USER_SET_PASS_INDEX=1
USER_SET_DATABASE_INDEX=2

for elem in "${USER_SET_LIST[@]}"
do
  user_set=($elem)
  if [ -z "${user_set[$USER_SET_USER_INDEX]}" ] | [ -z "${user_set[$USER_SET_PASS_INDEX]}" ]
  then
      echo >&2 "error: user id or password not exist"
      exit 1
  fi

## create user
  echo "CREATE USER '${user_set[$USER_SET_USER_INDEX]}'@'%' IDENTIFIED BY '${user_set[$USER_SET_PASS_INDEX]}' ;" | "${mysql[@]}"

## if database name is exist, create database
  if [ "${user_set[$USER_SET_DATABASE_INDEX]}" ]
  then
      echo "CREATE DATABASE IF NOT EXISTS \`${user_set[$USER_SET_DATABASE_INDEX]}\` ;" | "${mysql[@]}"
      echo "GRANT ALL ON \`${user_set[$USER_SET_DATABASE_INDEX]}\`.* TO '${user_set[$USER_SET_USER_INDEX]}'@'%' ;" | "${mysql[@]}"
  fi
done
## commit update
echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"
```

#### - 실행
```
$ docker network create epicurus-dev-tool-net
$ chmod +x docker-entrypoint.sh
$ chmod +x docker-custompoint.sh
$ docker-compose up -d
```

#### - 테스트
```
$ docker exec -it mysql bash
## entered mysql container
$ mysql -uredmine -predmine redmine
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| database           |
+--------------------+
2 rows in set (0.00 sec)
```
