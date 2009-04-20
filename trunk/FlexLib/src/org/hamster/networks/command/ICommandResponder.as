package org.hamster.networks.command
{	
			
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 
	public interface ICommandResponder
	{
		function commandResult(cmd:ICommand):void;
		function commandFault(cmd:ICommand):void;
	}
}