package org.hamster.networks.command
{	
		
	public interface ICommandResponder
	{
		function commandResult(cmd:ICommand):void;
		function commandFault(cmd:ICommand):void;
	}
}