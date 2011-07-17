/**
 * 
 */
package org.hamster.pm.test.util;

import org.hamster.pm.main.util.CommonUtil;
import org.hamster.pm.test.base.BaseTest;
import org.junit.Assert;
import org.junit.Test;

/**
 * @author Grossopa
 *
 */
public class TestCommonUtil extends BaseTest {
	
	@Test
	public void testEncodeSessionKey() {
		String email = "jack.yin@gmail.com";
		String password = "!qaz@WSX";
		String encodedKey = CommonUtil.encodeSessionKey(email, password);
		String[] decodedKey = CommonUtil.decodeSessionKey(encodedKey);
		Assert.assertTrue(email.equals(decodedKey[0]));
		Assert.assertTrue(password.equals(decodedKey[1]));
	}
}
