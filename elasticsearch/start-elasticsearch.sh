#!/usr/bin/env bash

# start ES in background
#/usr/local/bin/docker-entrypoint.sh eswrapper &

bin/elasticsearch &

# wait for ES cluster health status to be yellow/green
while true
do
	cluster_status=$( curl http://elastic:changeme@localhost:9200/_cluster/health 2>/dev/null | jq '.status' )
  echo $cluster_status

  if [ "$cluster_status" == "\"yellow\"" ] || [ "$cluster_status" == "\"green\"" ]; then
    echo "Elasticsearch ready"
    break
  else
    sleep 1
  fi
done

set -x

# create filebeat-pipeline
curl -v -XPUT http://elastic:changeme@localhost:9200/_ingest/pipeline/filebeat-pipeline -H 'Content-Type:application/json' -d'
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
          "\\[?%{TIMESTAMP_ISO8601:timestamp1}\\]? %{LOGLEVEL:log_level1} \\[%{DATA:logger}\\] %{JAVACLASS:java_class} %{TIMESTAMP_ISO8601:timestamp2} %{LOGLEVEL:log_level2} \\[%{DATA:java_thread}\\] (?m)%{GREEDYDATA:msg_body}",
          "\\[?%{TIMESTAMP_ISO8601:timestamp1}\\]? %{LOGLEVEL:log_level1}%{SPACE}\\[%{DATA:logger}\\] %{JAVACLASS:java_class} - (?m)%{GREEDYDATA:msg_body}"
        ],
        "ignore_failure": true
      }
    },
    {
      "grok": {
        "pattern_definitions": {
          "HASERRORPATH": "^((?!Success).)*(?<!\\.\\+)\\/error\\/.*"
        },
        "field": "msg_body",
        "patterns": [
          "%{HASERRORPATH:error_path}"
        ],
        "ignore_failure": true
      }
    },
    {
      "grok": {
        "pattern_definitions": {
          "ERRORBUCKET": "(.*?)"
        },
        "field": "error_path",
        "patterns": [
          "bucket['"'"'\"]?=%{ERRORBUCKET:error_bucket}['"'"'\"]?\\s+"
        ],
        "ignore_failure": true
      }
    },
    {
      "grok": {
        "pattern_definitions": {
          "ERRORPATH": "(.*?\\/error\\/.*?)"
        },
        "field": "error_path",
        "patterns": [
          "key['"'"'\"]?=%{ERRORPATH:error_path}['"'"'\"]?\\s+"
        ],
        "ignore_failure": true
      }
    }
  ]
}
'

tail -f /dev/null
