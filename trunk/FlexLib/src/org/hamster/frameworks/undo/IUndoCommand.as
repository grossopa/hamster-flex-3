package org.hamster.frameworks.undo
{
	public interface IUndoCommand
	{
		function execute():void;
		function undo():void;
	}
}