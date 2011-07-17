package org.hamster.pm.common.service;

import java.io.Serializable;
import java.util.List;

import org.hibernate.criterion.Criterion;

/**
 * <p>
 * The interface of general functions.
 * </p>
 * 
 */
public interface CRUDService<T> {
	/**
	 * Get object by id.
	 */
	T get(Serializable id);

	/**
	 * Get all objects.
	 * 
	 */
	List<T> getAll();

	/**
	 * Get objects by hql.
	 * 
	 */
	List<T> getObjectList(String hql, int start, int length);

	/**
	 * Save object.
	 * 
	 */

	void save(Object o);

	/**
	 * Update object.
	 * 
	 */

	void update(Object o);

	/**
	 * Save or update object.
	 * 
	 */

	void saveOrUpdate(Object o);

	/**
	 * Delete object.
	 * 
	 */
	void remove(Object o);

	/**
	 * Delete by id.
	 * 
	 */
	void removeById(Serializable id);

	/**
	 * Find by hql.
	 * 
	 */
	List<T> find(String hql);

	/**
	 * Find by hql and parmes.
	 * 
	 */
	List<T> find(String hql, Object[] param);

	/**
	 * Query by hql and parameters.
	 * 
	 * @param hql
	 * @param param
	 * @return
	 */
	public List<T> find(String hql, Serializable param);

	/**
	 * Set class of object.
	 * 
	 */
	void setEntityClass(Class<T> entityClass);
	
	public List<T> getList(Criterion[] criterions);
	
	public T getFirst(Criterion[] criterions);

}
