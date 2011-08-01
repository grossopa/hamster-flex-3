/**
 * 
 */
package org.hamster.pm.flex.config;

import org.springframework.flex.config.MessageBrokerConfigProcessor;

import flex.messaging.MessageBroker;
import flex.messaging.services.RemotingService;

/**
 * @author Grossopa
 *
 */
public class AppMessageBrokerConfigProcessor implements
		MessageBrokerConfigProcessor {

	/* (non-Javadoc)
	 * @see org.springframework.flex.config.MessageBrokerConfigProcessor#processAfterStartup(flex.messaging.MessageBroker)
	 */
	@Override
	public MessageBroker processAfterStartup(MessageBroker broker) {
		RemotingService remotingService = 
            (RemotingService) broker.getServiceByType(RemotingService.class.getName());
        if (remotingService.isStarted()) {
            System.out.println("The Remoting Service has been started with "
                    +remotingService.getDestinations().size()+" Destinations.");
        }
		return broker;
	}

	/* (non-Javadoc)
	 * @see org.springframework.flex.config.MessageBrokerConfigProcessor#processBeforeStartup(flex.messaging.MessageBroker)
	 */
	@Override
	public MessageBroker processBeforeStartup(MessageBroker broker) {
		return broker;
	}

}
