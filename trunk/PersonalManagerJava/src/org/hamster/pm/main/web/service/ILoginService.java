/**
 * 
 */
package org.hamster.pm.main.web.service;

import org.hamster.pm.main.model.ResultVO;
import org.hamster.pm.main.pojo.DUser;

/**
 * @author Grossopa
 *
 */
public interface ILoginService {
	
	/**
	 * @param email
	 * @param password
	 * @return resultVO
	 */
	ResultVO login(String email, String password);
	
	/**
	 * @param token
	 * @return resultVO
	 */
	ResultVO resume(String token);
	
	/**
	 * @param user
	 * @return resultVO
	 */
	ResultVO logout(DUser user);
	
	/**
	 * @param user
	 * @return resultVO
	 */
	ResultVO register(String email, String password);
}
