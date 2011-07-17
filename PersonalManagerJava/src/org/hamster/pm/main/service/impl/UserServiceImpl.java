package org.hamster.pm.main.service.impl;

import java.io.Serializable;
import java.util.List;

import org.hamster.pm.common.service.impl.CRUDServiceImpl;
import org.hamster.pm.main.pojo.DUser;
import org.hamster.pm.main.service.IUserService;
import org.hamster.pm.main.util.HashUtil;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Expression;
import org.springframework.stereotype.Service;

@Service("userService")
public class UserServiceImpl extends CRUDServiceImpl<DUser> implements IUserService {
	
	public static final String RANDOM_STRING = "kjIUN23JO";
	
	public UserServiceImpl(){
		super();
		this.setEntityClass(DUser.class);
	}
	
	/* (non-Javadoc)
	 * @see org.hamster.pm.main.service.IUserService#addUser(java.lang.String, java.lang.String)
	 */
	public DUser addUser(String email, String password) {
		String encryptedPass = getEncryptedPassword(email, password);
		DUser user = new DUser(email, encryptedPass);
		this.save(user);
		return user;
	}
	
	/* (non-Javadoc)
	 * @see org.hamster.pm.main.service.IUserService#delUser(java.io.Serializable)
	 */
	public Serializable delUser(Serializable id){
		this.removeById(id);
		return id;
	}
	
	/* (non-Javadoc)
	 * @see org.hamster.pm.main.service.IUserService#validateUser(java.lang.String, java.lang.String)
	 */
	@SuppressWarnings("unchecked")
	public DUser validateUser(String email, String password) {
		String encryptedPass = getEncryptedPassword(email, password);
		Criterion[] criterions = { Expression.eq("email", email), Expression.eq("password", encryptedPass) };
		List<DUser> result = this.dao.getList(DUser.class, criterions);
		return result.size() == 0 ? null : result.get(0);
	}
	
	/**
	 * @param userName
	 * @param password
	 * @return encrypted password string
	 */
	public static String getEncryptedPassword(String email, String password) {
		return HashUtil.hash(email + RANDOM_STRING + password);
	}
}
