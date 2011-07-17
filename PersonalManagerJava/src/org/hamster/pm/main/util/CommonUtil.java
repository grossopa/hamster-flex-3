/**
 * 
 */
package org.hamster.pm.main.util;

import java.util.UUID;

import org.hamster.pm.common.util.Base64;

/**
 * @author Grossopa
 *
 */
public class CommonUtil {
	
	public static final String SPLIT_CHARACTER = "#";
	
	private CommonUtil() { }
	
	/**
	 * @param email
	 * @param password
	 * @return encoded session key
	 */
	public static String encodeSessionKey(String email, String password) {
		return Base64.encodeBytes(email.getBytes()) 
			+ SPLIT_CHARACTER 
			+ Base64.encodeBytes(password.getBytes());
	}
	
	/**
	 * @param key
	 * @return [key, password]
	 */
	public static String[] decodeSessionKey(String key) {
		String[] result = key.split(SPLIT_CHARACTER);
		result[0] = new String(Base64.decode(result[0]));
		result[1] = new String(Base64.decode(result[1]));
		return result;
	}
	
	public static String generateUUID() {
		return UUID.randomUUID().toString();
	}
	
	public static boolean isEmpty(String s) {
		return s == null || s.trim().equals("");
	}
	
	public static boolean isEmpty(Object o) {
		if (o == null) {
			return false;
		} else if (o instanceof String) {
			return isEmpty((String) o);
		} else {
			return true;
		}
	}
	
	public static String firstCharToLowerCase(String str) {
		if (!isEmpty(str)) {
			return str.substring(0,1).toLowerCase() + str.substring(1);
		} else {
			return "";
		}
	}
	
}
