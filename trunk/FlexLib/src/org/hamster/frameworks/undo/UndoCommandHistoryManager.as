package org.hamster.frameworks.undo
{
	public class UndoCommandHistoryManager implements IUndoCommandManager
	{
		public var undoList:Array = new Array();
		public var redoList:Array = new Array();
		
		public function UndoCommandHistoryManager()
		{
		}

		public function executeCommand(undoable:IUndoCommand):void
		{
			undoable.execute();
			undoList.push(undoable);
		}
		
		public function clearAllCommand():void
		{
			undoList = new Array();
			redoList = new Array();
		}
		
		public function clearRedoList():void
		{
			redoList = new Array();
		}
		
		public function undo():void
		{
			if(undoList.length == 0) return;
			var undoable:IUndoCommand = IUndoCommand(undoList.pop());
			undoable.undo();
			redoList.push(undoable);
		}
		
		public function redo():void
		{
			if(redoList.length == 0) return;
			var undoable:IUndoCommand = IUndoCommand(redoList.pop());
			undoable.execute();
			undoList.push(undoable);
		}
		
	}
}