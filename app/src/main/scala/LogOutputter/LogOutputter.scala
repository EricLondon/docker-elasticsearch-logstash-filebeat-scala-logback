
package LogOutputter

import com.typesafe.scalalogging._
import java.io.PrintWriter
import java.io.StringWriter
import org.slf4j.LoggerFactory

object LogOutputter extends App {

  val logger = Logger(LoggerFactory.getLogger(this.getClass))

  while (true) {
    outputLogs()
    Thread.sleep(5000)
  }

  def outputLogs(): Unit = {
    logger.debug("debug")
    logger.info("info")
    logger.warn("warn")

    try {
      throw new RuntimeException("error")
    } catch {
      case e: Exception => {
        val sw = new StringWriter
        e.printStackTrace(new PrintWriter(sw))
        logger.error(sw.toString)
      }
    }
  }
}
