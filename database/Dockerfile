FROM mysql:8.0.29

ENV MYSQL_ROOT_PASSWORD="I am mysql boss"
ENV MYSQL_DATABASE=optimum

ADD optimum.sql /docker-entrypoint-initdb.d
ADD create_user.sql /docker-entrypoint-initdb.d