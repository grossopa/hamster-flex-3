package org.hamster.networks.command
{	
			
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 
	public interface ICommandResponder
	{
		/**
		 * formattedData can be any type, such as int, string, custom Model
		 * Object.
		 * 
		 * @param cmd
		 * @param formattedData  
		 * 
		 */
		function commandResult(cmd:ICommand, formattedData:*):void;
		
		/**
		 * formattedData can be any type, such as int, string, custom Model
		 * Object.
		 * 
		 * @param cmd
		 * @param formattedData  
		 * 
		 */
		function commandFault(cmd:ICommand, formattedData:*):void;
	}
}