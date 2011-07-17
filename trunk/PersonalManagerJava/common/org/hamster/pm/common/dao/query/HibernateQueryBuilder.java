//==============================================================================
// Created on 2007-3-27
// $Id: HibernateQueryBuilder.java,v 1.3 2008/07/08 07:54:10 maozh Exp $
//==============================================================================
package org.hamster.pm.common.dao.query;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 * <p>
 * Functions used on hibernate query
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2007-2010 www.hp.com
 * </p>
 * 
 * @author <a href="mailto:hualong.wang@hp.com">wang hualong</a>
 * @version 1.0, $Revision: 1.3 $, $Date: 2008/07/08 07:54:10 $
 */
public class HibernateQueryBuilder implements QueryBuilder, Serializable {

	/**
	 * <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 1L;

	DetachedCriteria dc = null;

	private List<Order> orderLists = new ArrayList<Order>();

	private Class<?> clazz = null;

	public HibernateQueryBuilder(Class<?> clazz) {
		this.clazz = clazz;
		dc = DetachedCriteria.forClass(clazz);
	}

	public Class<?> getClazz() {
		return clazz;
	}

	public QueryBuilder eq(String propertyName, Object value) {
		if (isNotEmpty(value)) {
			dc.add(Restrictions.eq(propertyName, value));
		}
		return this;
	}

	private boolean isNotEmpty(Object value) {
		return ((value != null) && (value.toString().trim().length() > 0));
	}

	public QueryBuilder like(String propertyName, Object value) {
		if (isNotEmpty(value)) {
			dc.add(Restrictions.like(propertyName, value));
		}
		return this;
	}

	public QueryBuilder like(String propertyName, String value,
			MatchMode matchMode) {
		if (isNotEmpty(value)) {
			dc.add(Restrictions.like(propertyName, value, matchMode));
		}
		return this;
	}

	public QueryBuilder ilike(String propertyName, String value,
			MatchMode matchMode) {
		if (isNotEmpty(value)) {
			dc.add(Restrictions.ilike(propertyName, value, matchMode));
		}
		return this;
	}

	public QueryBuilder ilike(String propertyName, Object value) {
		if (isNotEmpty(value)) {
			dc.add(Restrictions.ilike(propertyName, value));
		}
		return this;
	}

	public QueryBuilder gt(String propertyName, Object value) {
		if (isNotEmpty(value)) {
			dc.add(Restrictions.gt(propertyName, value));
		}
		return this;
	}

	public QueryBuilder lt(String propertyName, Object value) {
		if (isNotEmpty(value)) {
			dc.add(Restrictions.lt(propertyName, value));
		}
		return this;
	}

	public QueryBuilder le(String propertyName, Object value) {
		if (isNotEmpty(value)) {
			dc.add(Restrictions.le(propertyName, value));
		}
		return this;
	}

	public QueryBuilder ge(String propertyName, Object value) {
		if (isNotEmpty(value)) {
			dc.add(Restrictions.ge(propertyName, value));
		}
		return this;
	}

	public QueryBuilder between(String propertyName, Object lo, Object hi) {
		if (isNotEmpty(lo) && isNotEmpty(hi)) {
			dc.add(Restrictions.between(propertyName, lo, hi));
		} else if (isNotEmpty(lo)) {
			dc.add(Restrictions.ge(propertyName, lo));
		} else if (isNotEmpty(hi)) {
			dc.add(Restrictions.le(propertyName, hi));
		}
		return this;
	}

	public QueryBuilder in(String propertyName, Object[] values) {
		if ((values != null) && (values.length > 0)) {
			dc.add(Restrictions.in(propertyName, values));
		}
		return this;
	}

	public QueryBuilder in(String propertyName, Collection<?> values) {
		if ((values != null) && (values.size() > 0)) {
			dc.add(Restrictions.in(propertyName, values));
		}
		return this;
	}

	public QueryBuilder isNull(String propertyName) {
		dc.add(Restrictions.isNull(propertyName));
		return this;
	}

	public QueryBuilder eqProperty(String propertyName, String otherPropertyName) {
		dc.add(Restrictions.eqProperty(propertyName, otherPropertyName));
		return this;
	}

	public QueryBuilder ltProperty(String propertyName, String otherPropertyName) {
		dc.add(Restrictions.ltProperty(propertyName, otherPropertyName));
		return this;
	}

	public QueryBuilder leProperty(String propertyName, String otherPropertyName) {
		dc.add(Restrictions.leProperty(propertyName, otherPropertyName));
		return this;
	}

	public QueryBuilder isNotNull(String propertyName) {
		dc.add(Restrictions.isNotNull(propertyName));
		return this;
	}

	public QueryBuilder allEq(Map<?, ?> propertyNameValues) {
		dc.add(Restrictions.allEq(propertyNameValues));
		return this;
	}

	public QueryBuilder addOrderBy(Order orderBy) {
		orderLists.add(orderBy);
		return this;
	}

	public DetachedCriteria getDetachedCriteria() {
		return dc;
	}

	/**
	 * @return
	 * @see com.hp.hpl.articleclipper.dao.base.query.QueryBuilder#getOrderBys()
	 */
	public List<Order> getOrderBys() {
		return orderLists;
	}

	/**
	 * @param criterion
	 * @return
	 * @see com.hp.hpl.articleclipper.dao.base.query.QueryBuilder#addCriterion(org.hibernate.criterion.Criterion)
	 */
	public QueryBuilder addCriterion(Criterion criterion) {
		if (criterion != null) {
			dc.add(criterion);
		}
		return this;
	}
	
}
