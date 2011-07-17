package org.hamster.pm.test.base;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;


/**
 * 
 * @author yinz
 *
 */
abstract public class BaseServiceTest extends BaseTest {
	
	public static File OUTPUT_FOLDER;
	public static long TIMESTAMP = System.currentTimeMillis();
	private static ApplicationContext ctx;
	
	protected BufferedWriter writer;
	
	protected PlatformTransactionManager transactionManager;
	protected TransactionStatus transactionStatus;
	protected boolean defaultRollback = false;
	
	
	/**
	 * get bean
	 * 
	 * @param beanName
	 * @return bean instance
	 */
	public static Object getBean(String beanName) {
		return ctx.getBean(beanName);
	}
	
	/**
	 * @throws java.lang.Exception
	 */
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		// ConfigProperties.getInstance();
		System.out.println("------------ Service test start ------------");
		// add additional context configure files here
		String[] paths = { "classpath:applicationContext-bean.xml" };
		
		ctx = new ClassPathXmlApplicationContext(paths);
	}

	/**
	 * @throws java.lang.Exception
	 */
	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		System.out.println("------------- Service test end -------------");
	}
	
	/**
	 * 
	 */
	@Before
	public void setUp() {
        transactionManager = (PlatformTransactionManager) 
        		ctx.getBean("transactionManager");
        transactionStatus = transactionManager
        		.getTransaction(new DefaultTransactionDefinition());
	}
	
	@After
	public void tearDown() {
        if (defaultRollback) {
        	transactionManager.rollback(this.transactionStatus);
        } else {
        	transactionManager.commit(this.transactionStatus);
        }
		
		if (writer != null) {
			try {
				writer.flush();
				writer.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
	}
	
	protected static void initClass(String className) {
		if (className == null || className.length() == 0) {
			className = "BaseService";
		}
		OUTPUT_FOLDER = new File(new File("test-result", className), 
				String.valueOf(TIMESTAMP));
		
		if (!OUTPUT_FOLDER.exists()) {
			OUTPUT_FOLDER.mkdirs();
		}
	}
	
	protected void initMethod(String methodName) {
		try {
			writer = new BufferedWriter(
					new FileWriter(new File(OUTPUT_FOLDER, methodName + ".txt")));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
