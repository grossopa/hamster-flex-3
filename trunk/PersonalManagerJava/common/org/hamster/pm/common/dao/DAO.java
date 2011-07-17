package org.hamster.pm.common.dao;

import java.io.Serializable;
import java.util.List;

import org.hamster.pm.common.dao.query.QueryBuilder;
import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
@SuppressWarnings("rawtypes") 
public interface DAO {

	/**
	 * Query all records of class.
	 * 
	 * @param clazz the type of objects (a.k.a. while table) to get data from
	 * @return List of populated objects
	 */
	public List getObjects(Class clazz);

	/**
	 * Get a record by class and id.
	 * 
	 * @param clazz
	 *            model class to lookup
	 * @param id
	 *            the identifier (primary key) of the class
	 * @return a populated object
	 * @see org.springframework.orm.ObjectRetrievalFailureException
	 */
	public Object getObject(Class clazz, Serializable id);

	/**
	 * Find records stated by object.
	 * 
	 * @param o
	 *            the object to save
	 * @return
	 */
	public List findByExample(Object obj);

	/**
	 * Insert a record.
	 * 
	 * @param o
	 *            the object to save
	 * @return
	 */
	public Object save(Object o);

	public Object save(Object o, Serializable id);

	/**
	 * Persist an object , save or update.
	 * 
	 * @param o
	 *            the object to save
	 * @return
	 */
	public Object saveOrUpdate(Object o);

	/**
	 * Update an object.
	 * 
	 * @param object
	 * @return
	 */
	public Object update(Object object);

	/**
	 * Delete a record by class and id.
	 * 
	 * @param clazz
	 *            model class to lookup
	 * @param id
	 *            the identifier (primary key) of the class
	 */
	public void removeObject(Class clazz, Serializable id);

	/**
	 * Delete an object.
	 */
	public void removeObject(Object object);

	/**
	 * Delete objects by ids.
	 * 
	 * @param clazz
	 * @param ids
	 */
	public void removeBatch(Class clazz, Serializable[] ids);

	/**
	 *batch Execute By Hql
	 * 
	 * @param hql
	 * @param param
	 */

	public int batchExecuteByHql(final String hql, final Object[] param);

	/**
	 * Find records by query.
	 * 
	 * @param filter
	 * @return
	 */
	public List find(String query);

	/**
	 * Find records by filter.
	 * 
	 * @param query
	 * @return
	 */
	public List find(QueryBuilder queryBuilder);

	/**
	 * Refresh an object.
	 * 
	 * @param object
	 * 
	 */
	public void refresh(Object object);

	/**
	 * Commit update to db.
	 */
	public void flush();

	/**
	 * Query pagination results by query.
	 * 
	 * @param query
	 * @param start
	 * @param length
	 * @return
	 */
	public List find(String query, int start, int length);

	/**
	 * Query by hql and parameters.
	 * 
	 * @param hql
	 * @param param
	 * @return
	 */
	public List find(String hql, Serializable param);

	/**
	 * Query by hql and parameters.
	 * 
	 * @param hql
	 * @param param
	 * @return
	 */
	public List find(String hql, Object[] param);

	/**
	 * Query by class and parameters.
	 * 
	 * @param clazz
	 *            class.
	 * @param criterions
	 *            parameters.
	 * @return result.
	 */
	public List getList(Class clazz, Criterion[] criterions);

	/**
	 * @param clazz
	 * @param criterions
	 * @return
	 */
	public Object getFirst(Class clazz, Criterion[] criterions);

	/**
	 * @param class1
	 * @param criterions
	 * @param orders
	 * @param maxResults
	 * @return
	 */
	public List getList(Class class1, Criterion[] criterions, Order[] orders,
			Long maxResults);

	/**
	 * @param className
	 * @param criterions
	 * @return
	 */
	public List getList(String className, Criterion[] criterions);

	/**
	 * @param className
	 * @param sequenceName
	 * @return
	 */
	public List getNextId(String sequenceName);

	/**
	 * @param qb
	 * @return
	 */
	public int count(QueryBuilder qb);

	/**
	 * Whether the values exists on the columns in the records
	 * 
	 * @param names
	 *            columns, separated by ','<br>
	 *            such as "name,loginid,password"
	 */
	public boolean isNotUnique(Object entity, String names);

	public Session getHibSession();

}
