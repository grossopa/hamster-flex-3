package org.hamster.pm.main.service;

import java.io.Serializable;

import org.hamster.pm.common.service.CRUDService;
import org.hamster.pm.main.pojo.DUser;

public interface IUserService extends CRUDService<DUser> {
	
	/**
	 * add a new user
	 * 
	 * @param userName
	 * @param password
	 * @return user
	 */
	DUser addUser(String email, String password);
	
	/**
	 * delete a user
	 * 
	 * @param Id
	 * @return Id
	 */
	Serializable delUser(Serializable id);
	
	/**
	 * validate user
	 * 
	 * @param userName
	 * @param password
	 * @return null or user
	 */
	DUser validateUser(String email, String password);
}
