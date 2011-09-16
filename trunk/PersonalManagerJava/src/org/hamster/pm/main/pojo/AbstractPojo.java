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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (version ^ (version >>> 32));
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AbstractPojo other = (AbstractPojo) obj;
		if (version != other.version)
			return false;
		return true;
	}
	
}
