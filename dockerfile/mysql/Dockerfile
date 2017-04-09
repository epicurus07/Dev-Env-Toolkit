FROM mysql

COPY files/docker-entrypoint.sh /
COPY files/docker-custompoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["mysqld", "--character-set-server=utf8mb4", "--collation-server=utf8mb4_unicode_ci" ]
