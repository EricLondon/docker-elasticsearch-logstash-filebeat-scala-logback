lazy val commonSettings = Seq(
  version := "0.1-SNAPSHOT",
  organization := "com.ericlondon",
  scalaVersion := "2.11.12",
  test in assembly := {}
)

libraryDependencies += "ch.qos.logback" % "logback-classic" % "1.2.3"
libraryDependencies += "com.typesafe.scala-logging" %% "scala-logging" % "3.9.0"
