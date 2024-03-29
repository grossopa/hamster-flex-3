
import flash.geom.Point;

import mx.events.DragEvent;
import mx.managers.DragManager;

import org.hamster.frameworks.undo.UndoCommandHistoryManager;
import org.hamster.log.LoggerPanel;
import org.hamster.test.undo.TestDragableUnit;

private var undoManager:UndoCommandHistoryManager 
		= new UndoCommandHistoryManager();

private function creationComplete():void
{
	LoggerPanel.getInstance().setLogMode(
			LoggerPanel.HTML_MODE 
			| LoggerPanel.PANEL_MODE
			| LoggerPanel.TRACE_MODE);
}

private function dragDropHandler(e:DragEvent):void
{
	if(e.dragInitiator is TestDragableUnit) {
		undoManager.clearRedoList();
		var tdu:TestDragableUnit = TestDragableUnit(e.dragInitiator);
		undoManager.executeCommand(
				tdu.createDragUndoCommand(new Point(e.localX, e.localY)));
	}
}

private function dragEnterHandler(e:DragEvent):void
{
	DragManager.acceptDragDrop(this);
}

public function undoHandler():void
{
	undoManager.undo();
}

public function redoHandler():void
{
	undoManager.redo();
}