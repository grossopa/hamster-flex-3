package org.hamster.test.undo.undocommand
{
	import flash.geom.Point;
	
	import org.hamster.frameworks.undo.IUndoCommand;
	import org.hamster.log.Logger;
	import org.hamster.log.LoggerPanel;
	import org.hamster.test.undo.TestDragableUnit;

	public class DragUndoCommand implements IUndoCommand
	{
		// do not change the reference
		private const targetPoint:Point = new Point();
		private const nextPoint:Point = new Point();
		
		public static const LOG:Logger = Logger.getLogger("DragUndoCommand");
		
		public var targetObj:TestDragableUnit;
		
		
		public function DragUndoCommand(target:TestDragableUnit, nextPoint:Point) {
			this.targetObj = target;
			this.nextPoint.x = nextPoint.x;
			this.nextPoint.y = nextPoint.y;
		}

		public function execute():void
		{
			targetPoint.x = targetObj.x;
			targetPoint.y = targetObj.y;
			targetObj.x = nextPoint.x;
			targetObj.y = nextPoint.y;
			LOG.traceValue(nextPoint.toString(), "execute");
			LOG.debug(nextPoint.toString(), "execute");
			LOG.info(nextPoint.toString(), "execute");
			LOG.warning(nextPoint.toString(), "execute");
			LOG.error(nextPoint.toString(), "execute");
			LOG.fatal(nextPoint.toString(), "execute");
		}
		
		public function undo():void
		{
			targetObj.x = targetPoint.x;
			targetObj.y = targetPoint.y;
			LOG.error(targetPoint.toString(), "undo");
		}
		
	}
}