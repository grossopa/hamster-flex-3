package org.hamster.frameworks.undo
{
	public interface IUndoCommandManager
	{
    	function executeCommand(undoable:IUndoCommand):void;
		function clearAllCommand():void;
		function clearRedoList():void;
		function undo():void;
		function redo():void;
	}
}