/**
 * 
 */
package org.hamster.pm.main.web.rest.aop;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.hamster.pm.main.util.LoggerStringFormatter;

/**
 * @author grossopa
 *
 */
@Aspect
public class ControllerLogger {

	public static final Logger log = Logger.getLogger("acw.rest");
	
	@Pointcut("execution(* org.hamster.pm.main.web.rest.LoginController.*(..))")
	public void traceLog() { }
	
	public long startTime;
	
	@Before("traceLog() && args(request,..)")
	public void logBeforeController(HttpServletRequest request) {
		startTime = System.currentTimeMillis();
	}
	
	@AfterReturning("traceLog() && args(request,..)")
	public void logAfterController(HttpServletRequest request) {
		log.info(LoggerStringFormatter.formatRequest(request) 
				+ "   take " + (System.currentTimeMillis() - startTime) + "ms");
	}
	
	

//	@AfterThrowing(value="traceLog()", throwing="ex")
//	public void doRecoveryActions(Exception ex) {
//		log.error(ex.getMessage());
//	}

}
