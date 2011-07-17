/**
 * 
 */
package org.hamster.pm.main.pojo;

import javax.persistence.MappedSuperclass;
import javax.persistence.Version;

/**
 * @author yinz
 * 
 */
@MappedSuperclass
public abstract class AbstractPojo {
	/**
	 * 
	 */
	private static final long serialVersionUID = 9121826565352668235L;

	private long version;

	/**
	 * @return the version
	 */
	@Version
	public long getVersion() {
		return version;
	}

	/**
	 * @param version
	 *            the version to set
	 */
	public void setVersion(long version) {
		this.version = version;
	}

	public int hashCode() {
		return 13;
	}
}
