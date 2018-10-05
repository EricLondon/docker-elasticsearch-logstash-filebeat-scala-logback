#!/usr/bin/env bash

# start ES in background
/usr/local/bin/docker-entrypoint.sh eswrapper &

# wait for ES cluster health status to be yellow/green
while true
do
	cluster_status=$( curl http://localhost:9200/_cluster/health 2>/dev/null | jq '.status' )
  echo $cluster_status

  if [ "$cluster_status" == "\"yellow\"" ] || [ "$cluster_status" == "\"green\"" ]; then
    echo "Elasticsearch ready"
    break
  else
    sleep 1
  fi
done

# create filebeat-pipeline
curl -v -XPUT http://localhost:9200/_ingest/pipeline/filebeat-pipeline -H 'Content-Type:application/json' -d'
{
  "description": "DCOS task log processors",
  "processors": [
    {
      "grok": {
        "pattern_definitions": {
          "PATHELEM": "[^/]+"
        },
        "field": "source",
        "patterns": [
          "^/var/lib/mesos/slave/slaves/%{PATHELEM:agent}/frameworks/%{PATHELEM:framework}/executors/%{PATHELEM:executor}/runs/%{PATHELEM:run}"
        ],
        "ignore_failure": true
      }
    },
    {
      "grok": {
        "field": "message",
        "patterns": [
          "\\[%{TIMESTAMP_ISO8601:timestamp}\\] %{LOGLEVEL:log_level}%{SPACE}\\[%{DATA:thread}\\] %{JAVACLASS:logger} - %{GREEDYDATA:msg}"
        ],
        "ignore_failure": true
      }
    }
  ]
}
'

tail -f /dev/null
