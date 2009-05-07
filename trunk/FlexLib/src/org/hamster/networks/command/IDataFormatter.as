package org.hamster.networks.command
{
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 * 
	 * This class serves for AbstractCommand
	 */
	public interface IDataFormatter
	{
		/**
		 * format result data.
		 * 
		 * @param result
		 * @return formattedData
		 */
		function formatResult(result:ResultEvent):*;
		
		/**
		 * format fault data.
		 * 
		 * @param fault
		 * @return formattedData
		 */
		function formatFault(fault:FaultEvent):*;
	}
}