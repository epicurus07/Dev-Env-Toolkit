FROM redmine

COPY docker-entrypoint.sh /
COPY docker-custompoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
