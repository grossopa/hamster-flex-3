//==============================================================================
// Created on 2007-3-27
// $Id: BaseDAOHibernate.java,v 1.3 2008/07/08 07:54:10 maozh Exp $
//==============================================================================

package org.hamster.pm.common.dao.impl;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hamster.pm.common.dao.DAO;
import org.hamster.pm.common.dao.query.QueryBuilder;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.util.Assert;

/**
 * <p>
 * Base dao
 * </p>
 * 
 */
@SuppressWarnings({ "unchecked", "rawtypes" })
public class BaseDAOHibernate extends HibernateDaoSupport implements DAO {
	protected final Log log = LogFactory.getLog(getClass());

	/*
	 * 
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#getObjects(java.lang.Class)
	 */
	
	public List getObjects(Class clazz) {
		Assert.notNull(clazz, "Class can not be null!");
		return getHibernateTemplate().loadAll(clazz);
	}

	/*
	 * 
	 * @see
	 * com.hp.hpl.articleclipper.dao.base.DAO#findByExample(java.lang.Object)
	 */
	
	public List findByExample(Object obj) {
		Assert.notNull(obj, "The query object can not be null!");
		return getHibernateTemplate().findByExample(obj);
	}

	/*
	 * 
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#getObject(java.lang.Class,
	 * java.io.Serializable)
	 */
	
	public Object getObject(Class clazz, Serializable id) {
		Assert.notNull(clazz, "Class can not be null!");
		Assert.notNull(id, "The query object can not be null!");
		return getHibernateTemplate().get(clazz, id);
	}

	/*
	 * 
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#save(java.lang.Object)
	 */
	public Object save(Object o) {
		Assert.notNull(o, "The object saved can not be null!");
		getHibernateTemplate().save(o);
		return o;
	}

	/*
	 * 
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#save(java.lang.Object,
	 * java.io.Serializable)
	 */
	public Object save(Object o, Serializable id) {
		Assert.notNull(o, "The object saved can not be null!");
		Assert.notNull(id, "The key of saved object can not be null!");
		getHibernateTemplate().save(o);
		return o;
	}

	/*
	 * 
	 * @see
	 * com.hp.hpl.articleclipper.dao.base.DAO#saveOrUpdate(java.lang.Object)
	 */
	public Object saveOrUpdate(Object o) {
		Assert.notNull(o, "The object saved or updated can not be null!");
		getHibernateTemplate().saveOrUpdate(o);
		return o;
	}

	/*
	 * 
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#update(java.lang.Object)
	 */
	public Object update(Object object) {
		Assert.notNull(object, "The object updated can not be null!");
		getHibernateTemplate().update(object);
		return object;
	}

	/*
	 * 
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#removeObject(java.lang.Class,
	 * java.io.Serializable)
	 */
	
	public void removeObject(Class clazz, Serializable id) {
		Assert.notNull(clazz, "Class can not be null!");
		Assert.notNull(id, "The key of removed object can not be null!");
		getHibernateTemplate().delete(getObject(clazz, id));
	}

	/*
	 * 
	 * @see
	 * com.hp.hpl.articleclipper.dao.base.DAO#removeObject(java.lang.Object)
	 */
	public void removeObject(Object object) {
		Assert.notNull(object, "The removed object can not be null!");
		getHibernateTemplate().delete(object);
	}

	/*
	 * 
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#removeBatch(java.lang.Class,
	 * java.io.Serializable[])
	 */
	public void removeBatch(final Class clazz, final Serializable[] ids) {
		Assert.notNull(clazz, "Class can not be null!");
		getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				for (int i = 0; i < ids.length; i++) {
					Object obj = session.load(clazz, ids[i]);
					if (obj != null) {
						session.delete(obj);
					} else {
						log.warn("Can not delete the object with key:" + ids[i]
								+ " on " + clazz.getName());
					}
				}
				return null;
			}
		});
	}

	/*
	 * 
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#find(java.lang.String)
	 */
	
	public List find(String query) {
		Assert.notNull(query, "The query can not be null!");
		return getHibernateTemplate().find(query);
	}

	/*
	 * 
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#refresh(java.lang.Object)
	 */
	public void refresh(Object object) {
		getHibernateTemplate().refresh(object);
	}

	/*
	 * 
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#flush()
	 */
	public void flush() {
		getHibernateTemplate().flush();
	}

	/*
	 * 
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#find(java.lang.String, int,
	 * int)
	 */
	
	public List find(String query, int start, int length) {
		return getObjects(query, start, length);
	}

	
	public List getObjects(final String queryString, final int position,
			final int length) {
		Assert.notNull(queryString, "The query can not be null!");
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery(queryString);
				query.setFirstResult(position);
				query.setMaxResults(length);
				List lt = query.list();
				return lt;
			}
		});
	}

	/*
	 * 
	 * @see
	 * com.hp.hpl.articleclipper.dao.base.DAO#find(com.insigma.trust.base.query
	 * .QueryBuilder)
	 */
	public List find(final QueryBuilder queryBuilder) {
		if (queryBuilder != null) {
			return (List) getHibernateTemplate().execute(
					new HibernateCallback() {

						public Object doInHibernate(Session session)
								throws HibernateException, SQLException {
							DetachedCriteria dc = queryBuilder
									.getDetachedCriteria();
							for (Iterator it = queryBuilder.getOrderBys()
									.iterator(); it.hasNext();) {
								Order element = (Order) it.next();
								dc.addOrder(element);
							}
							return dc.getExecutableCriteria(session).list();
						}

					});
		}
		return null;
	}

	/**
	 * @param hql
	 * @param param
	 * @return
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#find(java.lang.String,
	 *      java.io.Serializable)
	 */
	
	public List find(final String hql, final Serializable param) {
		Assert.notNull(hql, "The query can not be null!");
		Assert.notNull(param, "The parameter can not be null!");
		return getHibernateTemplate().find(hql, param);
	}

	/**
	 * 
	 * @param hql
	 * @param param
	 * @return
	 */
	
	public List find(final String hql, final Object[] param) {
		Assert.notNull(hql, "The query can not be null!");
		Assert.notNull(param, "The parameter can not be null!");
		return getHibernateTemplate().find(hql, param);
	}

	/**
	 * @param clazz
	 * @param criterions
	 * @return
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#getList(java.lang.Class,
	 *      org.hibernate.criterion.Criterion[])
	 */
	public List getList(final Class clazz, final Criterion[] criterions) {
		Assert.notNull(clazz, "Class can not be null!");

		return getHibernateTemplate().executeFind(new HibernateCallback() {

			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Criteria query = session.createCriteria(clazz);
				if ((criterions != null) && (criterions.length > 0)) {
					for (int i = 0; i < criterions.length; i++) {
						query.add(criterions[i]);
					}
				}
				return query.list();
			}
		});
	}

	/**
	 * Get the first record of the query
	 * 
	 * @param clazz
	 *            class name.
	 * @param criterions
	 *            conditions.
	 * @return result.
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#getFirst(java.lang.Class,
	 *      org.hibernate.criterion.Criterion[])
	 */
	public Object getFirst(Class clazz, Criterion[] criterions) {
		List lt = getList(clazz, criterions);
		if ((lt != null) && (!lt.isEmpty())) {
			return lt.get(0);
		}
		return null;
	}

	/**
	 * @param clazz
	 * @param criterions
	 * @param orders
	 * @return
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#getList(java.lang.Class,
	 *      org.hibernate.criterion.Criterion[],
	 *      org.hibernate.criterion.Order[])
	 */
	public List getList(final Class clazz, final Criterion[] criterions,
			final Order[] orders, final Long maxResults) {
		Assert.notNull(clazz, "Class can not be null!");
		return getHibernateTemplate().executeFind(new HibernateCallback() {

			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Criteria criteria = session.createCriteria(clazz);
				if ((criterions != null) && (criterions.length > 0)) {
					for (int i = 0; i < criterions.length; i++) {
						criteria.add(criterions[i]);
					}
				}
				if ((orders != null) && (orders.length > 0)) {
					for (int i = 0; i < orders.length; i++) {
						criteria.addOrder(orders[i]);
					}
				}
				if (maxResults != null)
					criteria.setMaxResults(maxResults.intValue());
				return criteria.list();
			}
		});
	}

	/**
	 * batch deal by HQL
	 */
	public int batchExecuteByHql(final String hql, final Object[] param) {
		return createQuery(hql, param).executeUpdate();
	}

	/**
	 * create HQL's Query object.
	 * 
	 */
	private Query createQuery(final String queryString, final Object[] param) {
		Assert.hasText(queryString, "queryString is not null");
		return (Query) getHibernateTemplate().execute(
				new HibernateCallback() {

					@Override
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						Query query = getSession().createQuery(queryString);
						if (param != null) {
							for (int i = 0; i < param.length; i++) {
								query.setParameter(i, param[i]);
							}
						}
						return query;
					}
				});
	}

	/**
	 * @param className
	 * @param criterions
	 * @return
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#getList(java.lang.String,
	 *      org.hibernate.criterion.Criterion[])
	 */
	public List getList(final String className, final Criterion[] criterions) {
		Assert.notNull(className, "Class name can not be null");
		return getHibernateTemplate().executeFind(new HibernateCallback() {

			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Criteria criteria = null;
				try {
					criteria = session.createCriteria(Class.forName(className));
				} catch (ClassNotFoundException e) {
					logger
							.error(
									"$HibernateCallback.doInHibernate(Session) -- e=" + e, e); //$NON-NLS-1$
					throw new IllegalArgumentException(
							"The class name is not correct,classname = "
									+ className);
				}
				if ((criterions != null) && (criterions.length > 0)) {
					for (int i = 0; i < criterions.length; i++) {
						criteria.add(criterions[i]);
					}
				}
				return criteria.list();
			}
		});
	}

	/**
	 * @param className
	 * @param sequenceName
	 * @return
	 */
	public List getNextId(final String sequenceName) {
		return getHibernateTemplate().executeFind(new HibernateCallback() {

			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = null;
				query = session.createSQLQuery("select next value for "
						+ sequenceName + " from sysibm.sysdummy1");
				return query.list();
			}
		});
	}

	/**
	 * @param qb
	 * @return
	 * @see com.hp.hpl.articleclipper.dao.base.DAO#count(com.hp.ipg.framework.web.base.query.QueryBuilder)
	 */
	public int count(final QueryBuilder queryBuilder) {
		return ((Integer) getHibernateTemplate().execute(
				new HibernateCallback() {

					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						DetachedCriteria dc = queryBuilder
								.getDetachedCriteria();
						Criteria ct = dc.getExecutableCriteria(session);
						return ct.setProjection(Projections.rowCount())
								.uniqueResult();
					}
				})).intValue();
	}

	/**
	 * Get session.
	 * 
	 * @return
	 */
	public Session getHibSession() {
		return getSession();
	}

	/**
	 * Whether the values exists on the columns in the records
	 * 
	 * @param names
	 *            columns, seperated by ','<br>
	 *            such as "name,loginid,password"
	 */
	public boolean isNotUnique(Object entity, String names) {
		Assert.hasText(names);
		Criteria criteria = getHibSession().createCriteria(entity.getClass())
				.setProjection(Projections.rowCount());
		String[] nameList = names.split(",");
		try {
			for (String name : nameList) {
				criteria.add(Restrictions.eq(name, PropertyUtils.getProperty(
						entity, name)));
			}

			String idName = getSessionFactory().getClassMetadata(
					entity.getClass()).getIdentifierPropertyName();
			if (idName != null) {
				Object idValue = PropertyUtils.getProperty(entity, idName);
				// If update, exclude itself
				if ((idValue != null) && (!idValue.equals("")))
					criteria.add(Restrictions.not(Restrictions.eq(idName,
							idValue)));
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			return false;
		}
		return ((Integer) criteria.uniqueResult()) > 0;
	}

}
