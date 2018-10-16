FROM docker.elastic.co/elasticsearch/elasticsearch:5.5.1

USER root

RUN yum install epel-release -y && yum update -y && yum install jq -y

COPY start-elasticsearch.sh /

USER elasticsearch
