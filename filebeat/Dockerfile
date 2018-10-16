FROM docker.elastic.co/beats/filebeat:6.2.0

COPY filebeat.yml /usr/share/filebeat/filebeat.yml
USER root
RUN chown filebeat /usr/share/filebeat/filebeat.yml
USER filebeat

# COPY filebeat.yml /etc/filebeat/filebeat.yml
# USER root
# RUN chown filebeat /etc/filebeat/filebeat.yml
# USER filebeat
