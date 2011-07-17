package org.hamster.pm.common.service.impl;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hamster.pm.common.dao.DAO;
import org.hamster.pm.common.service.CRUDService;
import org.hibernate.criterion.Criterion;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


@Service("CRUDService")
public class CRUDServiceImpl<T> implements CRUDService<T> {

	private final Logger logger = Logger.getLogger(this.getClass().getName());

	@Resource(name = "dao")
	protected DAO dao;

	public DAO getDao() {
		return dao;
	}

	public void setDao(DAO dao) {
		this.dao = dao;
	}

	private Class<T> entityClass;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.hp.ipg.framework.web.service.CRUDService#get(java.io.Serializable)
	 */
	@SuppressWarnings("unchecked")
	public T get(Serializable id) {
		logger.debug("running  get(Serializable id)");
		return (T) dao.getObject(entityClass, id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.hp.ipg.framework.web.service.CRUDService#get(java.io.Serializable)
	 */
	@SuppressWarnings("unchecked")
	public List<T> find(String hql) {
		logger.debug("running  find(String hql)");
		return (List<T>) dao.find(hql);
	}

	@SuppressWarnings("unchecked")
	public List<T> find(String hql, Serializable param) {
		logger.debug("running  find(String hql, Serializable param)");
		return (List<T>) dao.find(hql, param);
	}

	@SuppressWarnings("unchecked")
	public List<T> find(String hql, Object[] param) {
		logger.debug("running  find(String hql, Object[] param)");
		return (List<T>) dao.find(hql, param);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.hp.ipg.framework.web.service.CRUDService#getAll(int, int)
	 */
	@SuppressWarnings("unchecked")
	public List<T> getAll() {
		logger.debug("running  getAll()");
		return (List<T>) dao.getObjects(entityClass);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.hp.ipg.framework.web.service.CRUDService#getObjectList(java.lang.
	 * String, int, int)
	 */
	@SuppressWarnings("unchecked")
	public List<T> getObjectList(String hql, int start, int length) {
		logger
				.debug("running  getObjectList(String hql, int start, int length)");
		return (List<T>) dao.find(hql, start, length);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.hp.ipg.framework.web.service.CRUDService#remove(java.lang.Object)
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void remove(Object o) {
		logger.debug("running  remove(Object o)");
		dao.removeObject(o);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.hp.ipg.framework.web.service.CRUDService#removeById(java.io.Serializable
	 * )
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void removeById(Serializable id) {
		logger.debug("running  removeById(Serializable id)");
		dao.removeObject(entityClass, id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.hp.ipg.framework.web.service.CRUDService#save(java.lang.Object)
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void save(Object o) {
		logger.debug("running  save(Object o)");
		dao.save(o);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.hp.ipg.framework.web.service.CRUDService#saveOrUpdate(java.lang.Object
	 * )
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void saveOrUpdate(Object object) {
		logger.debug("running  saveOrUpdate(Object object)");
		dao.saveOrUpdate(object);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.hp.ipg.framework.web.service.CRUDService#update(java.lang.Object)
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void update(Object o) {
		logger.debug("running  update(Object o)");
		dao.update(o);
	}

	public Class<T> getEntityClass() {
		return entityClass;
	}

	public void setEntityClass(Class<T> entityClass) {
		this.entityClass = entityClass;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<T> getList(Criterion[] criterions) {
		return dao.getList(entityClass, criterions);
	}

	@SuppressWarnings("unchecked")
	@Override
	public T getFirst(Criterion[] criterions) {
		return (T) dao.getFirst(entityClass, criterions);
	}

}
