package org.hamster.test.undo
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.hamster.test.undo.model.DataSource;
	import org.hamster.test.undo.undocommand.DragUndoCommand;
	
	import mx.containers.Canvas;
	import mx.core.DragSource;
	import mx.core.UIComponent;
	import mx.managers.DragManager;

	public class TestDragableUnit extends Canvas
	{
		public var dragStartPoint:Point = new Point();
		public var mainData:DataSource = new DataSource();
		
		public function TestDragableUnit()
		{
			super();
			this.width = 100;
			this.height = 30;
			setStyle("backgroundColor", "black");
			this.addEventListener(MouseEvent.MOUSE_DOWN, enableDragHandler);
		}
		
		protected function enableDragHandler(e:MouseEvent):void
		{
			dragStartPoint.x = e.localX;
			dragStartPoint.y = e.localY;
			var ds:DragSource = new DragSource();
			ds.addData({"x":e.localX, "y":e.localY}, "xy");
			DragManager.doDrag(UIComponent(e.currentTarget), ds, e);
		}
		
		public function createDragUndoCommand(eventPoint:Point):DragUndoCommand
		{
			eventPoint.x -= dragStartPoint.x;
			eventPoint.y -= dragStartPoint.y;
			var dragCmd:DragUndoCommand = new DragUndoCommand(this, eventPoint);
			return dragCmd;
		}
		
	}
}