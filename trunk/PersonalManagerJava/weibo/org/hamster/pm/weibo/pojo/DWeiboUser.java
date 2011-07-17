package org.hamster.pm.weibo.pojo;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hamster.pm.main.pojo.AbstractPojo;
import org.hibernate.validator.Length;
import org.hibernate.validator.NotNull;

@Entity
@Table(name = "WEIBO_USER")
public class DWeiboUser extends AbstractPojo {
	private Long id;
	private String userKey;
	private List<DWeibo> weiboList;

	public DWeiboUser() {
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "weiboUserId")
	public List<DWeibo> getWeiboList() {
		return weiboList;
	}

	public void setWeiboList(List<DWeibo> weiboList) {
		this.weiboList = weiboList;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	@NotNull
	@Length(max=50)
	public String getUserKey() {
		return userKey;
	}

	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}
}
