FROM docker.elastic.co/elasticsearch/elasticsearch:6.4.2

RUN yum install epel-release -y && yum update && yum install jq -y

COPY start-elasticsearch.sh /
