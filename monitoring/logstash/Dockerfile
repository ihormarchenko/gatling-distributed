FROM docker.elastic.co/logstash/logstash:6.3.0
ENV ELASTICSEARCH_HOST 172.30.16.242:9200
ADD config/ /usr/share/logstash/config/
COPY logstash.conf /tmp/config-dir/
CMD ["-f", "/tmp/config-dir/logstash.conf"]