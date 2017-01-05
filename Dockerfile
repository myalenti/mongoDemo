FROM mysql:latest
COPY ChinookDatabase1.4_CompleteVersion.zip /var/tmp/ChinookDatabase1.4_CompleteVersion.zip
COPY sakila-db.zip /var/tmp/sakila-db.zip
COPY world_x-db.zip /var/tmp/world_x-db.zip
RUN apt-get clean && apt-get update && apt-get install unzip
RUN cd /var/tmp && for i in `ls *.zip`; do unzip $i; done  &&  \
cp *MySql* /docker-entrypoint-initdb.d/
RUN cd /var/tmp/ && cp sakila-db/*.sql /docker-entrypoint-initdb.d/
RUN cd /var/tmp/ && cp world_x-db/*.sql /docker-entrypoint-initdb.d/
RUN cd /docker-entrypoint-initdb.d && mv sakila-schema.sql 1sakila-schema.sql
RUN cd /docker-entrypoint-initdb.d && mv sakila-data.sql 2sakila-data.sql
RUN cd /docker-entrypoint-initdb.d && mv world_x.sql 1world_x.sql
