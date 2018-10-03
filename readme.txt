
```
# build scala logging app
cd app && sbt assembly

# build docker containers
docker-compose build

# start docker containers
docker-compose up

# search ES with log level query and output parsed message
curl -H 'Content-Type: application/json' -XPOST 'http://localhost:9200/filebeat-*/_search?pretty&sort=@timestamp:desc&size=1' -d '{"query":{"term":{"log_level":"error"}}}' > output.json

cat output.json | jq '.hits.hits[0]._source.log_level'
"ERROR"

cat output.json | jq '.hits.hits[0]._source.logger'
"LogOutputter.LogOutputter$"

cat output.json | jq '.hits.hits[0]._source.thread'
"main"

cat output.json | jq '.hits.hits[0]._source.msg'
"java.lang.RuntimeException: error\n\tat LogOutputter.LogOutputter$.outputLogs(LogOutputter.scala:24)\n\tat LogOutputter.LogOutputter$.delayedEndpoint$LogOutputter$LogOutputter$1(LogOutputter.scala:14)\n\tat LogOutputter.LogOutputter$delayedInit$body.apply(LogOutputter.scala:9)\n\tat scala.Function0.apply$mcV$sp(Function0.scala:34)\n\tat scala.Function0.apply$mcV$sp$(Function0.scala:34)\n\tat scala.runtime.AbstractFunction0.apply$mcV$sp(AbstractFunction0.scala:12)\n\tat scala.App.$anonfun$main$1$adapted(App.scala:76)\n\tat scala.collection.immutable.List.foreach(List.scala:389)\n\tat scala.App.main(App.scala:76)\n\tat scala.App.main$(App.scala:74)\n\tat LogOutputter.LogOutputter$.main(LogOutputter.scala:9)\n\tat LogOutputter.LogOutputter.main(LogOutputter.scala)\n"
```