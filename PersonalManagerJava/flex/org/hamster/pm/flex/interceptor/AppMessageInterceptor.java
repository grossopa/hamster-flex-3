package org.hamster.pm.flex.interceptor;

import org.springframework.flex.core.MessageInterceptor;
import org.springframework.flex.core.MessageProcessingContext;

import flex.messaging.messages.Message;

public class AppMessageInterceptor implements MessageInterceptor {

	@Override
	public Message postProcess(MessageProcessingContext context, Message inputMessage,
			Message outputMessage) {
		return outputMessage;
	}

	@Override
	public Message preProcess(MessageProcessingContext arg0, Message inputMessage) {
		// TODO Auto-generated method stub
		return inputMessage;
	}

}
