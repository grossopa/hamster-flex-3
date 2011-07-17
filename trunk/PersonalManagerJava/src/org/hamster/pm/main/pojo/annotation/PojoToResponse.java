/**
 * 
 */
package org.hamster.pm.main.pojo.annotation;

/**
 * @author Grossopa
 *
 */
@java.lang.annotation.Target(value={java.lang.annotation.ElementType.METHOD,java.lang.annotation.ElementType.FIELD})
@java.lang.annotation.Retention(value=java.lang.annotation.RetentionPolicy.RUNTIME)
public @interface PojoToResponse {
	boolean included() default true; 
	boolean required() default true;
	String parameterName() default "";
}
