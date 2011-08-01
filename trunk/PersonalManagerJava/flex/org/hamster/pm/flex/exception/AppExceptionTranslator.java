package org.hamster.pm.flex.exception;

import org.springframework.flex.core.ExceptionTranslator;

import flex.messaging.MessageException;

public class AppExceptionTranslator implements ExceptionTranslator {

	@Override
	public boolean handles(Class<?> clazz) {
		return true;
	}

	@Override
	public MessageException translate(Throwable t) {
		return new MessageException(t);
	}

}
