/**
 * 
 */
package org.hamster.pm.main.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.log4j.Logger;

/**
 * a hash util.
 * 
 * @author yinz
 *
 */
public class HashUtil {
	
	private static final Logger log = Logger.getLogger(HashUtil.class);
	
	/**
	 * hide constructor
	 */
	private HashUtil() { }
	
	/**
	 * hash data by configured method.
	 * 
	 * @param data
	 * @return hashed data
	 */
	public static String hash(String data) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(data.getBytes());
			return byteToHexStringSingle(md.digest());
		} catch (NoSuchAlgorithmException e) {
			log.error(e);
		}
		return null;
	}
	
	/**
	 * convert byte array to string.
	 * 
	 * @param byteArray
	 * @return str
	 */
	public static String byteToHexStringSingle(byte[] byteArray) {
		StringBuffer md5StrBuff = new StringBuffer();
		for (int i = 0; i < byteArray.length; i++) {
			if (Integer.toHexString(0xFF & byteArray[i]).length() == 1) {
				md5StrBuff.append("0").append(
						Integer.toHexString(0xFF & byteArray[i]));
			} else {
				md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));
			}
		}
		return md5StrBuff.toString();
	}
	
	
}