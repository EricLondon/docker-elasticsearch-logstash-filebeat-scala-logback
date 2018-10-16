#!/usr/bin/env sh

LOG1="2018-10-08 13:47:57,191 INFO [NiFi logging handler] org.apache.nifi.StdOut 2018-10-08 13:47:57,191 INFO [Timer-Driven Process Thread-359] c.a.nifi.processors.ConsistentListS3 ConsistentListS3[id=01621001-b162-1711-e995-0e45b5cfd8ae] Listed bucket='geppcp.data.implementation.arcadia' prefix='jeff/sources/geppcp/instances/jeff/' filter='.+/error/.+' cache='false' limit='null' marker='null' in 1204 millis (0 new objects)"
LOG2="2018-10-09 19:27:54,863 INFO [NiFi logging handler] org.apache.nifi.StdOut 2018-10-09 19:27:54,863 INFO [Timer-Driven Process Thread-413] c.a.n.p.ConsistentDeleteS3Object ConsistentDeleteS3Object[id=1c0ffe2d-0162-1000-3b79-2b1592a36ee4] Successfully delete S3 Object for StandardFlowFileRecord[uuid=9ecc7718-f8e9-46b1-8c77-906bde3fac56,claim=,offset=0,name=claims/sources/stwhumaz/instances/claims/wip/Humana AZ Service Fund Files 2018/normalize/error/Humana_AZ_Service_Fund_Files_2018/Humana_AZ_Service_Fund_Files_2018/AZ-IASIS_20180501_RECAP/AZ-IASIS_PE20180501_RECAP.TXT.ERROR,size=0] in 31 millis; routing to success"
LOG3="2018-10-09 19:36:04,394 INFO [NiFi logging handler] org.apache.nifi.StdOut 2018-10-09 19:36:04,394 INFO [Timer-Driven Process Thread-1736] c.a.n.processors.ConsistentPutS3Object ConsistentPutS3Object[id=015f1012-c83b-19a7-037e-b39e5818180d] Failure completing upload flowfile=claims/sources/stwhumaz/instances/claims/wip/Humana AZ Service Fund Files 2018-09/normalize/error/Humana_AZ_Service_Fund_Files_2018-09/Humana_AZ_Service_Fund_Files_2018-09/AZ-IASIS_20180901_RECAP/AZ-IASIS_PE20180901_RECAP.TXT.ERROR bucket=stw2.data.implementation.arcadia key=claims/sources/stwhumaz/instances/claims/wip/Humana AZ Service Fund Files 2018-09/normalize/error/Humana_AZ_Service_Fund_Files_2018-09/Humana_AZ_Service_Fund_Files_2018-09/AZ-IASIS_20180901_RECAP/AZ-IASIS_PE20180901_RECAP.TXT.ERROR reason=Bad Request (Service: Amazon S3; Status Code: 400; Error Code: 400 Bad Request; Request ID: null)"
LOG4="[2018-10-16 15:32:30.804] DEBUG [main] LogOutputter.LogOutputter$ - debug"
LOG5="[2018-10-16 15:32:30.807] INFO  [main] LogOutputter.LogOutputter$ - info"
LOG6="[2018-10-16 15:32:30.809] WARN  [main] LogOutputter.LogOutputter$ - warn"

read -r -d '' LOG7 <<'EOF'
[2018-10-16 15:35:21.442] ERROR [main] LogOutputter.LogOutputter$ - java.lang.RuntimeException: error
	at LogOutputter.LogOutputter$.outputLogs(LogOutputter.scala:24)
	at LogOutputter.LogOutputter$.delayedEndpoint$LogOutputter$LogOutputter$1(LogOutputter.scala:14)
	at LogOutputter.LogOutputter$delayedInit$body.apply(LogOutputter.scala:9)
	at scala.Function0.apply$mcV$sp(Function0.scala:34)
	at scala.Function0.apply$mcV$sp$(Function0.scala:34)
	at scala.runtime.AbstractFunction0.apply$mcV$sp(AbstractFunction0.scala:12)
	at scala.App.$anonfun$main$1$adapted(App.scala:76)
	at scala.collection.immutable.List.foreach(List.scala:389)
	at scala.App.main(App.scala:76)
	at scala.App.main$(App.scala:74)
	at LogOutputter.LogOutputter$.main(LogOutputter.scala:9)
	at LogOutputter.LogOutputter.main(LogOutputter.scala)
EOF

while true
do
  echo "$LOG1" >> /var/log/stdout.log
  echo "$LOG2" >> /var/log/stdout.log
  echo "$LOG3" >> /var/log/stdout.log
  echo "$LOG4" >> /var/log/stdout.log
  echo "$LOG5" >> /var/log/stdout.log
  echo "$LOG6" >> /var/log/stdout.log
  echo "$LOG7" >> /var/log/stdout.log
  sleep 1m
done
