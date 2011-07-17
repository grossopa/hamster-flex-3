/**
 * 
 */
package org.hamster.pm.main.exception;

/**
 * @author Grossopa
 *
 */
public class ControllerException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8379920264638082184L;
	
	public static final String USER_INVALID = "userInvalid";
	
	private String type;
	
	public String getType() {
		return type;
	}
	
	public ControllerException(String type) {
		super();
		this.type = type;
	}

}
