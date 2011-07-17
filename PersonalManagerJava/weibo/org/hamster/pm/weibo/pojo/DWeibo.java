/**
 * 
 */
package org.hamster.pm.weibo.pojo;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hamster.pm.main.pojo.AbstractPojo;
import org.hibernate.validator.Length;
import org.hibernate.validator.NotNull;

/**
 * @author grossopa
 *
 */
@Entity
@Table(name = "WEIBO")
public class DWeibo extends AbstractPojo {
	private Long id;
	private String type;
	private String requestTokenKey;
	private String requestTokenSecret;
	private String accessTokenKey;
	private String accessTokenSecret;
	
	private Long createDate;
	private Long lastAccessDate;
	
	private DWeiboUser weiboUserId;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public Long getId() { return id; }
	public void setId(Long id) { this.id = id; }

	@NotNull
	@Length(max=10)
	public String getType() { return type; }
	public void setType(String type) { this.type = type; }

	@Length(max=50)
	public String getRequestTokenKey() { return requestTokenKey; }
	public void setRequestTokenKey(String requestTokenKey) { this.requestTokenKey = requestTokenKey; }

	@Length(max=50)
	public String getRequestTokenSecret() { return requestTokenSecret; }
	public void setRequestTokenSecret(String requestTokenSecret) { this.requestTokenSecret = requestTokenSecret; }

	@Length(max=50)
	public String getAccessTokenKey() { return accessTokenKey; }
	public void setAccessTokenKey(String accessTokenKey) { this.accessTokenKey = accessTokenKey; }

	@Length(max=50)
	public String getAccessTokenSecret() { return accessTokenSecret; }
	public void setAccessTokenSecret(String accessTokenSecret) { this.accessTokenSecret = accessTokenSecret; }

	public Long getCreateDate() { return createDate; }
	public void setCreateDate(Long createDate) { this.createDate = createDate; }

	public Long getLastAccessDate() { return lastAccessDate;}
	public void setLastAccessDate(Long lastAccessDate) { this.lastAccessDate = lastAccessDate; }
	
	@ManyToOne(targetEntity = DWeiboUser.class, fetch = FetchType.EAGER)
	@NotNull
	public DWeiboUser getWeiboUserId() { return weiboUserId; }
	public void setWeiboUserId(DWeiboUser weiboUserId) { this.weiboUserId = weiboUserId; }
	
}
