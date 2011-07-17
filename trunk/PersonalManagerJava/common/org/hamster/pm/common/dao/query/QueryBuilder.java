//==============================================================================
// Created on 2007-3-27
// $Id: QueryBuilder.java,v 1.2 2008/06/24 08:16:43 maozh Exp $
//==============================================================================
package org.hamster.pm.common.dao.query;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;

/**
 * <p>
 * Interface used on query
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2007-2010 www.hp.com
 * </p>
 * 
 * @author <a href="mailto:hualong.wang@hp.com">wang hualong</a>
 * @version 1.0, $Revision: 1.2 $, $Date: 2008/06/24 08:16:43 $
 */
public interface QueryBuilder extends Serializable {

	/**
	 * Whether they are equal.
	 * 
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public abstract QueryBuilder eq(String propertyName, Object value);

	/**
	 * Whether they are like
	 * 
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public abstract QueryBuilder like(String propertyName, Object value);

	/**
	 * Whether they are like on matchmode
	 * 
	 * @param propertyName
	 * @param value
	 * @param matchMode
	 * @return
	 */
	public abstract QueryBuilder like(String propertyName, String value,
			MatchMode matchMode);

	/**
	 * Whether they are like on matchmode
	 * 
	 * @param propertyName
	 * @param value
	 * @param matchMode
	 * @return
	 */
	public abstract QueryBuilder ilike(String propertyName, String value,
			MatchMode matchMode);

	/**
	 * Whether they are not equal.
	 * 
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public abstract QueryBuilder ilike(String propertyName, Object value);

	/**
	 * Whether it is bigger.
	 * 
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public abstract QueryBuilder gt(String propertyName, Object value);

	/**
	 * Whether it is smaller
	 * 
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public abstract QueryBuilder lt(String propertyName, Object value);

	/**
	 * Whether it is smaller or equal.
	 * 
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public abstract QueryBuilder le(String propertyName, Object value);

	/**
	 * Whether it is bigger or equal.
	 * 
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public abstract QueryBuilder ge(String propertyName, Object value);

	/**
	 * Whether it is in a limit range.
	 * 
	 * @param propertyName
	 * @param lo
	 * @param hi
	 * @return
	 */
	public abstract QueryBuilder between(String propertyName, Object lo,
			Object hi);

	/**
	 * Whether it is in a refer array.
	 * 
	 * @param propertyName
	 * @param values
	 * @return
	 */
	public abstract QueryBuilder in(String propertyName, Object[] values);

	/**
	 * Whether it is in a collection.
	 * 
	 * @param propertyName
	 * @param values
	 * @return
	 */
	public abstract QueryBuilder in(String propertyName, Collection<?> values);

	/**
	 * Whether it is null.
	 * 
	 * @param propertyName
	 * @return
	 */
	public abstract QueryBuilder isNull(String propertyName);

	/**
	 * Whether its property is equal.
	 * 
	 * @param propertyName
	 * @param otherPropertyName
	 * @return
	 */
	public abstract QueryBuilder eqProperty(String propertyName,
			String otherPropertyName);

	/**
	 * Whether its peroperty is smaller.
	 * 
	 * @param propertyName
	 * @param otherPropertyName
	 * @return
	 */
	public abstract QueryBuilder ltProperty(String propertyName,
			String otherPropertyName);

	/**
	 * Whether its peroperty is smaller or equal.
	 * 
	 * @param propertyName
	 * @param otherPropertyName
	 * @return
	 */
	public abstract QueryBuilder leProperty(String propertyName,
			String otherPropertyName);

	/**
	 * Whether its peroperty is not equal.
	 * 
	 * @param propertyName
	 * @return
	 */
	public abstract QueryBuilder isNotNull(String propertyName);

	/**
	 * @param propertyNameValues
	 * @return
	 */
	public abstract QueryBuilder allEq(Map<?, ?> propertyNameValues);

	/**
	 * @param orderBy
	 * @return
	 */
	public abstract QueryBuilder addOrderBy(Order orderBy);

	/**
	 * @param criterion
	 * @return
	 */
	public abstract QueryBuilder addCriterion(Criterion criterion);

	/**
	 * @return
	 */
	public abstract List<?> getOrderBys();

	/**
	 * 
	 * @return
	 */
	public abstract DetachedCriteria getDetachedCriteria();

	public abstract Class<?> getClazz();

}