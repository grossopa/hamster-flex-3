package org.hamster.frameworks.undo
{
	
	/**
	 * @author jack yin grossopforever@gmail.com
	 */
	 
	public interface IUndoCommand
	{
		function execute():void;
		function undo():void;
	}
}