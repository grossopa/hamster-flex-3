package org.hamster.networks.command
{
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	public interface IDataFormatter
	{
		/**
		 * format result data.
		 * 
		 * @param result
		 */
		function formatResult(result:ResultEvent):*;
		
		/**
		 * format fault data.
		 * 
		 * @param fault
		 */
		function formatFault(fault:FaultEvent):*;
	}
}