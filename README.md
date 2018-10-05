### Docker Elasticsearch Logstash Filebeat Scala Logback

```
# build scala logging app
cd app && sbt assembly

# build docker containers
docker-compose build

# start docker containers
docker-compose up

# search ES with log level query and output parsed message
curl -H 'Content-Type: application/json' -XPOST 'http://localhost:9200/filebeat-6.4.2-2018.10.05/_search?pretty' -d '
{
  "query": {
    "term": {
      "log_level": "ERROR"
    }
  },
  "size": 1,
  "sort": [
    {
      "@timestamp": {"order":"desc"}
    }
  ]
}' 2>/dev/null | jq '.hits.hits[0]._source'

# output:
{
  "msg": "java.lang.RuntimeException: error",
  "agent": "test-agent",
  "offset": 264655,
  "logger": "LogOutputter.LogOutputter$",
  "log_level": "ERROR",
  "prospector": {
    "type": "log"
  },
  "run": "latest",
  "source": "/var/lib/mesos/slave/slaves/test-agent/frameworks/test-framework/executors/test-executor/runs/latest/stdout.log",
  "thread": "main",
  "message": "[2018-10-05 15:25:38.499] ERROR [main] LogOutputter.LogOutputter$ - java.lang.RuntimeException: error\n\tat LogOutputter.LogOutputter$.outputLogs(LogOutputter.scala:24)\n\tat LogOutputter.LogOutputter$.delayedEndpoint$LogOutputter$LogOutputter$1(LogOutputter.scala:14)\n\tat LogOutputter.LogOutputter$delayedInit$body.apply(LogOutputter.scala:9)\n\tat scala.Function0.apply$mcV$sp(Function0.scala:34)\n\tat scala.Function0.apply$mcV$sp$(Function0.scala:34)\n\tat scala.runtime.AbstractFunction0.apply$mcV$sp(AbstractFunction0.scala:12)\n\tat scala.App.$anonfun$main$1$adapted(App.scala:76)\n\tat scala.collection.immutable.List.foreach(List.scala:389)\n\tat scala.App.main(App.scala:76)\n\tat scala.App.main$(App.scala:74)\n\tat LogOutputter.LogOutputter$.main(LogOutputter.scala:9)\n\tat LogOutputter.LogOutputter.main(LogOutputter.scala)\n",
  "input": {
    "type": "log"
  },
  "@timestamp": "2018-10-05T15:25:39.299Z",
  "framework": "test-framework",
  "executor": "test-executor",
  "beat": {
    "hostname": "ba6e00435dce",
    "name": "ba6e00435dce",
    "version": "6.4.2"
  },
  "host": {
    "name": "ba6e00435dce"
  },
  "timestamp": "2018-10-05 15:25:38.499"
}
```
