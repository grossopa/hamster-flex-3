package org.hamster.pm.main.pojo;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hamster.pm.main.pojo.annotation.PojoToResponse;
import org.hibernate.validator.Length;
import org.hibernate.validator.NotNull;
import org.springframework.flex.core.io.AmfIgnoreField;

/**
 * USER
 */
@Entity
@Table(name = "USER")
public class DUser extends AbstractPojo {

	private static final long serialVersionUID = 4018162115450280083L;

	private Long id;
	private String email;
	@AmfIgnoreField(onSerialization=false)
	private String password;
	private String token;

	public DUser() {
	}

	public DUser(String email) {
		this.email = email;
	}

	public DUser(String email, String password) {
		this.email = email;
		this.password = password;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@PojoToResponse
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@NotNull
	@Length(max=30)
	@PojoToResponse
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	@NotNull
	@Length(max=50)
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	@Length(max=50)
	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}
	
}
